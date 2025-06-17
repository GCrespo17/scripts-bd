const express = require('express');
const cors = require('cors');
const oracledb = require('oracledb');

const app = express();
app.use(cors()); // Habilita CORS
app.use(express.json()); // Permite al servidor entender JSON

// Middleware para loggear todas las peticiones
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next();
});

// Configuración de la conexión a Oracle
const dbConfig = {
    user: "SYSTEM", // o tu usuario de esquema
    password: "admin", // la de tu BD
    connectString: "oracle-db:1521/XE",
    schema: "SYSTEM" // Añadimos el esquema aquí
};

// Endpoint de prueba
app.get('/api/test', (req, res) => {
    res.json({ message: "La API del Backend funciona!" });
});

// Endpoint de prueba de conexión a BD
app.get('/api/test-db', async (req, res) => {
    let connection;
    try {
        console.log('[TEST-DB] Intentando conectar...');
        connection = await oracledb.getConnection(dbConfig);
        console.log('[TEST-DB] Conexión exitosa');
        
        const result = await connection.execute('SELECT 1 as test FROM dual');
        console.log('[TEST-DB] Query test ejecutada');
        
        res.json({ 
            message: "Conexión a BD exitosa!",
            test_result: result.rows[0][0],
            config: {
                user: dbConfig.user,
                connectString: dbConfig.connectString,
                schema: dbConfig.schema
            }
        });
    } catch (err) {
        console.error('[TEST-DB] Error:', err);
        res.status(500).json({ 
            message: "Error de conexión a BD",
            error: err.message,
            code: err.code || 'UNKNOWN'
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error('[TEST-DB] Error cerrando conexión:', err);
            }
        }
    }
});

// Endpoint de debug para verificar empleados en la base de datos
app.get('/api/debug/empleados/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;
    
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // 1. Verificar si el museo existe
        const museoResult = await connection.execute(
            `SELECT nombre FROM ${dbConfig.schema}.MUSEOS WHERE id_museo = :id`,
            [id_museo]
        );
        
        // 2. Verificar todos los empleados del museo
        const empleadosResult = await connection.execute(
            `SELECT ep.id_empleado, ep.primer_nombre, ep.primer_apellido, he.cargo, he.fecha_fin
             FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
             JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON he.id_empleado_prof = ep.id_empleado
             WHERE he.id_museo = :id
             ORDER BY he.cargo, ep.primer_apellido`,
            [id_museo]
        );
        
        // 3. Contar por cargo
        const cargosResult = await connection.execute(
            `SELECT he.cargo, COUNT(*) as total
             FROM ${dbConfig.schema}.HIST_EMPLEADOS he
             WHERE he.id_museo = :id AND he.fecha_fin IS NULL
             GROUP BY he.cargo`,
            [id_museo]
        );
        
        const debug = {
            museo_exists: museoResult.rows.length > 0,
            museo_nombre: museoResult.rows.length > 0 ? museoResult.rows[0][0] : 'No encontrado',
            total_empleados: empleadosResult.rows.length,
            empleados_activos: empleadosResult.rows.filter(row => row[4] === null).length,
            empleados_por_cargo: cargosResult.rows.map(row => ({
                cargo: row[0],
                total: row[1]
            })),
            empleados_detalle: empleadosResult.rows.map(row => ({
                id: row[0],
                nombre: `${row[1]} ${row[2]}`,
                cargo: row[3],
                activo: row[4] === null ? 'SI' : 'NO'
            }))
        };
        
        res.json(debug);
        
    } catch (err) {
        console.error('Error en debug:', err);
        res.status(500).json({ error: err.message });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener lugares (países y ciudades)
app.get('/api/lugares', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT id_lugar, nombre, tipo, id_lugar_padre, continente 
             FROM ${dbConfig.schema}.LUGARES 
             ORDER BY tipo DESC, nombre ASC`
        );
        
        // Estructurar los datos en un formato jerárquico
        const lugares = result.rows.map(row => ({
            id: row[0],
            nombre: row[1],
            tipo: row[2],
            padre_id: row[3],
            continente: row[4]
        }));
        
        res.json(lugares);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error al obtener lugares' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para registrar un artista (Corregido con asociación de obras)
app.post('/api/artistas', async (req, res) => {
    const { 
        primer_nombre, 
        segundo_nombre, 
        primer_apellido, 
        segundo_apellido, 
        fecha_nacimiento, 
        fecha_difuncion, 
        apodo, 
        resumen_caracteristicas, 
        id_lugar,
        obras_asociadas = [] // Campo obligatorio para obras asociadas
    } = req.body;
    
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // Validar que se envíen obras asociadas
        if (!obras_asociadas || obras_asociadas.length === 0) {
            return res.status(400).json({ 
                message: 'Debe asociar al menos una obra al artista' 
            });
        }
        
        // 1. Insertar el artista y obtener su ID
        const sqlArtista = `
            INSERT INTO ${dbConfig.schema}.ARTISTAS (
                primer_nombre, 
                segundo_nombre, 
                primer_apellido, 
                segundo_apellido, 
                fecha_nacimiento, 
                fecha_difuncion, 
                apodo, 
                resumen_caracteristicas, 
                id_lugar
            ) VALUES (
                :primer_nombre,
                :segundo_nombre,
                :primer_apellido,
                :segundo_apellido,
                :fecha_nacimiento,
                :fecha_difuncion,
                :apodo,
                :resumen_caracteristicas,
                :id_lugar
            ) RETURNING id_artista INTO :id_artista
        `;
        
        // Preparar los parámetros del artista
        const paramsArtista = {
            primer_nombre: primer_nombre || null,
            segundo_nombre: segundo_nombre || null,
            primer_apellido: primer_apellido || null,
            segundo_apellido: segundo_apellido || null,
            fecha_nacimiento: fecha_nacimiento ? new Date(fecha_nacimiento) : null,
            fecha_difuncion: fecha_difuncion ? new Date(fecha_difuncion) : null,
            apodo: apodo || null,
            resumen_caracteristicas: resumen_caracteristicas,
            id_lugar: id_lugar || null,
            id_artista: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        };
        
        // Ejecutar inserción del artista sin autoCommit para manejar transacción manualmente
        const resultArtista = await connection.execute(sqlArtista, paramsArtista, { autoCommit: false });
        const idArtistaGenerado = resultArtista.outBinds.id_artista[0];
        
        // 2. Insertar las asociaciones con obras (ahora obligatorias)
        const sqlAsociacion = `
            INSERT INTO ${dbConfig.schema}.ARTISTAS_OBRAS (id_artista, id_obra) 
            VALUES (:id_artista, :id_obra)
        `;
        
        for (const id_obra of obras_asociadas) {
            await connection.execute(sqlAsociacion, {
                id_artista: idArtistaGenerado,
                id_obra: id_obra
            }, { autoCommit: false });
        }
        
        // Confirmar transacción
        await connection.commit();
        
        res.status(201).json({ 
            message: 'Artista registrado exitosamente', 
            id_artista: idArtistaGenerado,
            obras_asociadas: obras_asociadas.length
        });
        
    } catch (err) {
        // Rollback en caso de error
        if (connection) {
            try {
                await connection.rollback();
            } catch (rollbackErr) {
                console.error('Error en rollback:', rollbackErr);
            }
        }
        
        console.error('Error al registrar artista:', err);
        res.status(500).json({ 
            message: 'Error al registrar el artista',
            error: err.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener todos los museos
app.get('/api/museos', async (req, res) => {
    console.log('[DEBUG] Iniciando petición a /api/museos');
    let connection;
    try {
        console.log('[DEBUG] Intentando conectar a BD...');
        console.log('[DEBUG] Config BD:', { 
            user: dbConfig.user, 
            connectString: dbConfig.connectString, 
            schema: dbConfig.schema 
        });
        
        connection = await oracledb.getConnection(dbConfig);
        console.log('[DEBUG] Conexión a BD establecida exitosamente');
        
        const query = `SELECT id_museo, nombre FROM ${dbConfig.schema}.MUSEOS ORDER BY nombre ASC`;
        console.log('[DEBUG] Ejecutando query:', query);
        
        const result = await connection.execute(query);
        console.log(`[DEBUG] Query ejecutada. Filas encontradas: ${result.rows.length}`);
        
        const museos = result.rows.map(row => ({
            id: row[0],
            nombre: row[1]
        }));
        
        console.log('[DEBUG] Museos procesados:', JSON.stringify(museos.slice(0, 3))); // Solo los primeros 3
        res.json(museos);
    } catch (err) {
        console.error('ERROR DETALLADO al obtener museos:', err);
        console.error('ERROR Stack:', err.stack);
        res.status(500).json({ 
            message: 'Error al obtener museos',
            error: err.message,
            code: err.code || 'UNKNOWN'
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
                console.log('[DEBUG] Conexión a BD cerrada');
            } catch (err) {
                console.error('Error cerrando conexión:', err);
            }
        }
    }
});

// Endpoint para obtener las salas de exposición de un museo
app.get('/api/salas-exp/museo/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT id_sala, nombre, id_est 
             FROM ${dbConfig.schema}.SALAS_EXP 
             WHERE id_museo = :id_museo 
             ORDER BY nombre ASC`,
            [id_museo]
        );
        
        const salas = result.rows.map(row => ({
            id_sala: row[0],
            nombre: row[1],
            id_est: row[2]
        }));
        
        res.json(salas);
    } catch (err) {
        console.error(`Error al obtener salas para el museo ${id_museo}:`, err);
        res.status(500).json({ message: 'Error al obtener las salas de exposición' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para registrar una nueva exposición o evento
app.post('/api/exposiciones-eventos', async (req, res) => {
    const {
        id_sala,
        id_est,
        id_museo,
        nombre,
        fecha_inicio,
        fecha_fin,
        costo_persona,
        institucion_educativa
    } = req.body;
    
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const sql = `
            INSERT INTO ${dbConfig.schema}.EXPOSICIONES_EVENTOS (
                id_sala, id_est, id_museo, nombre, fecha_inicio, 
                fecha_fin, costo_persona, institucion_educativa
            ) VALUES (
                :id_sala, :id_est, :id_museo, :nombre, :fecha_inicio, 
                :fecha_fin, :costo_persona, :institucion_educativa
            )
        `;
        
        const params = {
            id_sala: id_sala,
            id_est: id_est,
            id_museo: id_museo,
            nombre: nombre,
            fecha_inicio: new Date(fecha_inicio),
            fecha_fin: new Date(fecha_fin),
            costo_persona: costo_persona || null,
            institucion_educativa: institucion_educativa || null
        };
        
        await connection.execute(sql, params, { autoCommit: true });
        res.status(201).json({ message: 'Exposición/Evento registrado exitosamente' });
        
    } catch (err) {
        console.error('Error al registrar exposición/evento:', err);
        res.status(500).json({ 
            message: 'Error al registrar la exposición o evento',
            error: err.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener todas las obras
app.get('/api/obras', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT o.id_obra, o.nombre as nombre_obra, hom.id_catalogo_museo
             FROM ${dbConfig.schema}.OBRAS o
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON o.id_obra = hom.id_obra
             WHERE hom.fecha_salida IS NULL
             ORDER BY o.nombre ASC`
        );
        
        const obras = result.rows.map(row => ({
            id_obra: row[0],
            nombre: row[1],
            id_catalogo: row[2]
        }));
        
        res.json(obras);
    } catch (err) {
        console.error('Error al obtener obras:', err);
        res.status(500).json({ message: 'Error al obtener obras' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener obras activas de un museo (necesario para el formulario de mantenimiento)
app.get('/api/obras-activas/museo/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    console.log(`[DEBUG] Solicitando obras activas para museo ID: ${id_museo}`);

    try {
        connection = await oracledb.getConnection(dbConfig);
        console.log('[DEBUG] Conexión a BD establecida');
        
        const result = await connection.execute(
            `SELECT 
                hom.id_catalogo_museo as id_catalogo,
                hom.id_obra,
                o.nombre,
                o.tipo_obra,
                hom.fecha_entrada,
                COUNT(pm.id_mant) as programas_existentes
             FROM ${dbConfig.schema}.HIST_OBRAS_MOV hom
             JOIN ${dbConfig.schema}.OBRAS o ON hom.id_obra = o.id_obra
             LEFT JOIN ${dbConfig.schema}.PROGRAMAS_MANT pm ON hom.id_catalogo_museo = pm.id_catalogo 
                 AND hom.id_obra = pm.id_obra
             WHERE hom.id_museo = :id_museo 
               AND hom.fecha_salida IS NULL
             GROUP BY hom.id_catalogo_museo, hom.id_obra, o.nombre, o.tipo_obra, hom.fecha_entrada
             ORDER BY o.nombre ASC`,
            [id_museo]
        );
        
        console.log(`[DEBUG] Consulta ejecutada. Filas encontradas: ${result.rows.length}`);
        
        const obras = result.rows.map(row => ({
            id_catalogo: row[0],
            id_obra: row[1],
            nombre: row[2],
            tipo_obra: row[3],
            fecha_entrada: row[4],
            programas_existentes: row[5]
        }));
        
        console.log(`[DEBUG] Obras procesadas: ${JSON.stringify(obras.slice(0, 2))}`); // Solo las primeras 2 para logging
        res.json(obras);
    } catch (err) {
        console.error('Error al obtener obras activas:', err);
        res.status(500).json({ 
            message: 'Error al obtener obras activas del museo',
            error: err.message,
            details: err.stack 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener detalles de mantenimiento de una obra específica
app.get('/api/obras/:id_obra/detalles-mantenimiento', async (req, res) => {
    const { id_obra } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // Consultar datos base de la obra y su ubicación actual
        const obraResult = await connection.execute(
            `SELECT 
                o.nombre,
                o.tipo_obra,
                o.dimensiones,
                o.desc_materiales_tecnicas,
                m.nombre as museo_actual,
                se.nombre as sala_actual,
                hom.fecha_entrada,
                hom.destacada
             FROM ${dbConfig.schema}.OBRAS o
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON o.id_obra = hom.id_obra
             JOIN ${dbConfig.schema}.MUSEOS m ON hom.id_museo = m.id_museo
             LEFT JOIN ${dbConfig.schema}.SALAS_EXP se ON hom.id_sala = se.id_sala 
                 AND hom.id_est_fis = se.id_est AND hom.id_museo = se.id_museo
             WHERE o.id_obra = :id_obra 
               AND hom.fecha_salida IS NULL`,
            [id_obra]
        );

        // Consultar último mantenimiento realizado
        const ultimoMantResult = await connection.execute(
            `SELECT 
                mor.fecha_inicio,
                mor.fecha_fin,
                mor.observaciones,
                ep.primer_nombre || ' ' || ep.primer_apellido as responsable
             FROM ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor
             JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON mor.id_empleado = ep.id_empleado
             WHERE mor.id_obra = :id_obra
               AND mor.fecha_fin IS NOT NULL
             ORDER BY mor.fecha_fin DESC
             FETCH FIRST 1 ROWS ONLY`,
            [id_obra]
        );

        if (obraResult.rows.length === 0) {
            return res.status(404).json({ message: 'Obra no encontrada o no está activa' });
        }

        const obra = obraResult.rows[0];
        const ultimoMant = ultimoMantResult.rows.length > 0 ? ultimoMantResult.rows[0] : null;

        const detalles = {
            nombre: obra[0],
            tipo_obra: obra[1],
            dimensiones: obra[2],
            materiales_tecnicas: obra[3],
            ubicacion_actual: `${obra[4]} - ${obra[5] || 'Sala no especificada'}`,
            fecha_entrada_museo: obra[6],
            es_destacada: obra[7] === 'SI',
            ultimo_mantenimiento: ultimoMant ? {
                fecha: ultimoMant[1], // fecha_fin
                responsable: ultimoMant[3],
                observaciones: ultimoMant[2]
            } : null
        };
        
        res.json(detalles);
    } catch (err) {
        console.error('Error al obtener detalles de mantenimiento:', err);
        res.status(500).json({ message: 'Error al obtener detalles de la obra' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint mejorado para registrar un nuevo programa de mantenimiento (VERSIÓN INTEGRAL)
app.post('/api/programas-mant', async (req, res) => {
    const {
        id_catalogo,
        id_obra,
        id_museo,
        actividad,
        frecuencia,
        tipo_responsable,
        id_empleado_responsable
    } = req.body;
    
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // ===== FASE 1: VALIDACIONES PREVIAS =====
        
        // 1.1 Verificar que la obra esté activa en el museo especificado
        const obraActivaResult = await connection.execute(
            `SELECT 1 FROM ${dbConfig.schema}.HIST_OBRAS_MOV 
             WHERE id_catalogo_museo = :catalogo 
               AND id_obra = :obra 
               AND id_museo = :museo
               AND fecha_salida IS NULL`,
            [id_catalogo, id_obra, id_museo]
        );
        
        if (obraActivaResult.rows.length === 0) {
            return res.status(400).json({
                error: 'La obra no está actualmente en el museo especificado o no es válida',
                details: 'Verifique que la obra esté activa en el museo seleccionado'
            });
        }
        
        // 1.2 Verificar disponibilidad de empleados del tipo requerido
        const empleadosDisponiblesResult = await connection.execute(
            `SELECT COUNT(*) as disponibles, 
                    MIN(ep.primer_nombre || ' ' || ep.primer_apellido) as primer_empleado
             FROM ${dbConfig.schema}.HIST_EMPLEADOS he
             JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
             WHERE he.id_museo = :museo 
               AND he.cargo = :tipo_responsable 
               AND he.fecha_fin IS NULL`,
            [id_museo, tipo_responsable]
        );
        
        const disponibles = empleadosDisponiblesResult.rows[0][0];
        const primerEmpleado = empleadosDisponiblesResult.rows[0][1];

        // 1.3 Verificar si ya existe un programa activo para esta obra
        const programaExistenteResult = await connection.execute(
            `SELECT COUNT(*) as existentes
             FROM ${dbConfig.schema}.PROGRAMAS_MANT 
             WHERE id_catalogo = :catalogo 
               AND id_obra = :obra`,
            [id_catalogo, id_obra]
        );

        const programasExistentes = programaExistenteResult.rows[0][0];
        
        // ===== FASE 2: INSERCIÓN CON TRANSACCIÓN =====
        
        const sql = `
            INSERT INTO ${dbConfig.schema}.PROGRAMAS_MANT (
                id_catalogo, id_obra, actividad, frecuencia, tipo_responsable
            ) VALUES (
                :catalogo, :obra, :actividad, :frecuencia, :responsable
            )
        `;
        
        const params = {
            catalogo: id_catalogo,
            obra: id_obra,
            actividad: actividad.trim(),
            frecuencia: frecuencia,
            responsable: tipo_responsable
        };
        
        // Ejecutar inserción sin autoCommit para manejar transacción manualmente
        await connection.execute(sql, params, { autoCommit: false });
        
        // ===== FASE 3: AUTOMATIZACIÓN OPCIONAL INMEDIATA =====
        
        let automatizacionActivada = false;
        let registrosProcesados = 0;
        
        try {
            // Si se proporcionó un empleado específico, programar mantenimiento inmediato
            if (id_empleado_responsable) {
                await connection.execute(
                    `INSERT INTO ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS (
                        id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, observaciones
                    ) 
                    SELECT pm.id_mant, pm.id_catalogo, pm.id_obra, :empleado, SYSDATE,
                           'Mantenimiento programado desde formulario. Empleado asignado manualmente: ' || 
                           ep.primer_nombre || ' ' || ep.primer_apellido
                    FROM ${dbConfig.schema}.PROGRAMAS_MANT pm
                    JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON ep.id_empleado = :empleado
                    WHERE pm.id_catalogo = :catalogo AND pm.id_obra = :obra
                      AND pm.id_mant = (SELECT MAX(id_mant) FROM ${dbConfig.schema}.PROGRAMAS_MANT 
                                       WHERE id_catalogo = :catalogo AND id_obra = :obra)`,
                    {
                        empleado: id_empleado_responsable,
                        catalogo: id_catalogo,
                        obra: id_obra
                    },
                    { autoCommit: false }
                );
                
                automatizacionActivada = true;
                registrosProcesados = 1;
            } else if (disponibles > 0) {
                // Llamar al procedimiento de automatización si hay empleados disponibles pero no se especificó uno
                const automatizacionResult = await connection.execute(
                    `DECLARE
                        v_registros_procesados NUMBER;
                     BEGIN
                        SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(
                            p_id_museo => :museo,
                            p_dias_anticipacion => 0,
                            p_registros_procesados => v_registros_procesados
                        );
                        :out_registros := v_registros_procesados;
                     END;`,
                    {
                        museo: id_museo,
                        out_registros: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
                    },
                    { autoCommit: false }
                );
                
                registrosProcesados = automatizacionResult.outBinds.out_registros;
                automatizacionActivada = registrosProcesados > 0;
            }
        } catch (autoErr) {
            console.log('Advertencia: Error en automatización (no crítico):', autoErr.message);
            // No fallar si la automatización falla, solo registrar advertencia
        }
        
        // Confirmar transacción
        await connection.commit();
        
        // ===== FASE 4: RESPUESTA ENRIQUECIDA =====
        
        const respuesta = {
            message: 'Programa de mantenimiento registrado exitosamente',
            detalles: {
                programas_previos_para_obra: programasExistentes,
                empleados_disponibles: disponibles,
                primer_empleado_disponible: primerEmpleado,
                automatizacion_activada: automatizacionActivada,
                mantenimientos_programados_inmediatamente: registrosProcesados
            },
            recomendaciones: []
        };

        // Agregar recomendaciones basadas en el contexto
        if (disponibles === 0) {
            respuesta.recomendaciones.push(
                `⚠️ No hay ${tipo_responsable.toLowerCase()}s disponibles en el museo. ` +
                `El programa se ejecutará automáticamente cuando haya personal asignado.`
            );
        }

        if (programasExistentes > 0) {
            respuesta.recomendaciones.push(
                `ℹ️ Esta obra ya tiene ${programasExistentes} programa(s) de mantenimiento registrado(s). ` +
                `Verifique que no haya duplicados o conflictos de frecuencia.`
            );
        }

        if (automatizacionActivada) {
            respuesta.recomendaciones.push(
                `🤖 Se activó automáticamente el sistema de mantenimiento. ` +
                `${registrosProcesados} tarea(s) de mantenimiento fueron programadas inmediatamente.`
            );
        }

        res.status(201).json(respuesta);
        
    } catch (err) {
        // Rollback en caso de error
        if (connection) {
            try {
                await connection.rollback();
            } catch (rollbackErr) {
                console.error('Error en rollback:', rollbackErr);
            }
        }
        
        console.error('Error integral en programa de mantenimiento:', err);
        
        // Manejo específico de errores de constraint
        if (err.message && err.message.includes('ORA-00001')) {
            res.status(409).json({ 
                error: 'Ya existe un programa de mantenimiento idéntico para esta obra',
                details: 'Considere modificar la frecuencia o actividad si desea crear un programa adicional'
            });
        } else if (err.message && err.message.includes('ORA-02291')) {
            res.status(400).json({ 
                error: 'Problema de integridad referencial',
                details: 'La obra especificada no existe en el historial de movimientos'
            });
        } else {
            res.status(500).json({ 
                error: 'Error en el ecosistema de mantenimiento',
                details: err.message,
                codigo_oracle: err.errorNum || 'No disponible'
            });
        }
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error('Error cerrando conexión:', err);
            }
        }
    }
});

// Endpoint para obtener la estructura física de un museo de forma jerárquica
app.get('/api/est-fisica/museo/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT id_est, nombre, tipo, descripcion, direccion_edificio, id_est_padre 
             FROM ${dbConfig.schema}.EST_FISICA 
             WHERE id_museo = :id_museo`,
            [id_museo]
        );
        
        const list = result.rows.map(row => ({
            id: row[0],
            nombre: row[1],
            tipo: row[2],
            descripcion: row[3],
            direccion: row[4],
            padre_id: row[5],
            children: []
        }));

        const map = {}, roots = [];
        for (let i = 0; i < list.length; i += 1) {
            map[list[i].id] = i;
        }

        for (const node of list) {
            if (node.padre_id) {
                if (list[map[node.padre_id]]) {
                   list[map[node.padre_id]].children.push(node);
                }
            } else {
                roots.push(node);
            }
        }
        
        res.json(roots);
    } catch (err) {
        console.error(`Error al obtener estructura física para el museo ${id_museo}:`, err);
        res.status(500).json({ message: 'Error al obtener la estructura física' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para registrar un nuevo elemento en la estructura física
app.post('/api/est-fisica', async (req, res) => {
    const {
        id_museo,
        nombre,
        tipo,
        descripcion,
        direccion_edificio,
        id_est_padre
    } = req.body;
    
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const sql = `
            INSERT INTO ${dbConfig.schema}.EST_FISICA (
                id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre
            ) VALUES (
                :id_museo, :nombre, :tipo, :descripcion, :direccion_edificio, :id_est_padre
            )
        `;
        
        const params = {
            id_museo,
            nombre,
            tipo,
            descripcion: descripcion || null,
            direccion_edificio: direccion_edificio || null,
            id_est_padre: id_est_padre || null
        };
        
        await connection.execute(sql, params, { autoCommit: true });
        res.status(201).json({ message: 'Elemento de estructura física registrado exitosamente' });
        
    } catch (err) {
        console.error('Error al registrar elemento de estructura física:', err);
        res.status(500).json({ 
            message: 'Error al registrar el elemento de la estructura física',
            error: err.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener la estructura organizacional de un museo de forma jerárquica (MEJORADO)
app.get('/api/est-organizacional/museo/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    const { nivel } = req.query; // Parámetro opcional para filtrar por nivel
    let connection;

    console.log(`\n🔍 CONSULTANDO ORGANIGRAMA PARA MUSEO ID: ${id_museo}`);

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Obtener todas las unidades organizacionales del museo (con filtro opcional por nivel)
        let query = `SELECT id_est_org, nombre, tipo, nivel, descripcion, id_est_org_padre 
             FROM ${dbConfig.schema}.EST_ORGANIZACIONAL 
             WHERE id_museo = :id_museo`;
        
        const params = [id_museo];
        
        if (nivel) {
            query += ` AND tipo = :nivel`;
            params.push(nivel);
        }
        
        query += ` ORDER BY nivel ASC, nombre ASC`;
        
        const orgUnitsPromise = connection.execute(query, params);

        // 2. Obtener todos los empleados actualmente asignados en ese museo
        // Incluimos información adicional para mejorar la presentación
        const empleadosPromise = connection.execute(
            `SELECT
                he.id_est_org,
                ep.id_empleado,
                ep.primer_nombre,
                ep.segundo_nombre,
                ep.primer_apellido,
                ep.segundo_apellido,
                he.cargo,
                he.fecha_inicio,
                ep.doc_identidad,
                he.fecha_fin
             FROM ${dbConfig.schema}.HIST_EMPLEADOS he
             JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
             WHERE he.id_museo = :id_museo 
             ORDER BY he.cargo DESC, ep.primer_apellido ASC`,
            [id_museo]
        );

        const [orgUnitsResult, empleadosResult] = await Promise.all([orgUnitsPromise, empleadosPromise]);

        // DEBUG: Ver qué empleados estamos obteniendo
        console.log(`\n=== EMPLEADOS ENCONTRADOS PARA MUSEO ${id_museo} ===`);
        console.log(`Total empleados encontrados: ${empleadosResult.rows.length}`);
        empleadosResult.rows.forEach((row, index) => {
            const nombreCompleto = [row[2], row[3], row[4], row[5]].filter(Boolean).join(' ');
            const fechaFin = row[9] ? ` (INACTIVO desde ${row[9].toISOString().split('T')[0]})` : ' (ACTIVO)';
            console.log(`${index + 1}. ${nombreCompleto} - ${row[6]} (Est_Org: ${row[0]})${fechaFin}`);
        });

        // Mapear empleados a su unidad organizacional con mejor estructura
        const empleadosPorUnidad = {};
        empleadosResult.rows.forEach(row => {
            // Solo incluir empleados ACTIVOS (fecha_fin IS NULL)
            if (row[9] !== null) {
                console.log(`  SALTANDO: ${[row[2], row[3], row[4], row[5]].filter(Boolean).join(' ')} - NO ACTIVO`);
                return;
            }
            
            const id_est_org = row[0];
            if (!empleadosPorUnidad[id_est_org]) {
                empleadosPorUnidad[id_est_org] = [];
            }
            
            // Construir nombre completo de forma más robusta
            const nombreCompleto = [
                row[2], // primer_nombre
                row[3], // segundo_nombre
                row[4], // primer_apellido
                row[5]  // segundo_apellido
            ].filter(Boolean).join(' ');
            
            // Mejorar la lógica de clasificación de jefes/directores
            const cargo = row[6] ? row[6].toLowerCase() : '';
            const esJefe = cargo.includes('director') || 
                          cargo.includes('subdirector') ||
                          cargo.includes('jefe') ||
                          cargo.includes('coordinador') ||
                          cargo.includes('responsable') ||
                          cargo.includes('gerente') ||
                          cargo.includes('superintendente') ||
                          cargo.includes('supervisor');
            
            // Para curadores, solo considerarlos jefes si están en departamentos específicos de colecciones/curaduría
            const esCuradorJefe = cargo.includes('curador') && (
                row[6].includes('Jef') || // "Jefa de Colecciones", etc.
                id_est_org // Si queremos aplicar lógica más específica por unidad
            );
            
            empleadosPorUnidad[id_est_org].push({
                id_empleado: row[1],
                nombre_completo: nombreCompleto,
                cargo: row[6],
                fecha_inicio: row[7],
                doc_identidad: row[8],
                id_est_org: id_est_org, // Añadimos esta información para contexto
                // Determinar si es jefe/director de la unidad
                es_jefe: esJefe || esCuradorJefe
            });
            
            // DEBUG: Mostrar clasificación
            console.log(`  -> ${nombreCompleto} en unidad ${id_est_org}: ${(esJefe || esCuradorJefe) ? 'JEFE' : 'PERSONAL'} (cargo: ${row[6]})`);
        });

        console.log('\n=== EMPLEADOS POR UNIDAD ===');
        Object.keys(empleadosPorUnidad).forEach(unidadId => {
            console.log(`Unidad ${unidadId}: ${empleadosPorUnidad[unidadId].length} empleados`);
        });

        // Construir la lista de nodos del árbol con mejor estructura
        const list = orgUnitsResult.rows.map(row => {
            const empleados = empleadosPorUnidad[row[0]] || [];
            
            // Separar jefes/directores del resto del personal
            const jefes = empleados.filter(emp => emp.es_jefe);
            const personal = empleados.filter(emp => !emp.es_jefe);
            
            // Añadir información adicional para empleados con múltiples roles
            const jefesConInfo = jefes.map(jefe => ({
                ...jefe,
                roles_multiples: empleadosResult.rows
                    .filter(row => row[1] === jefe.id_empleado && row[9] === null) // mismo empleado, activo
                    .length > 1
            }));
            
            const personalConInfo = personal.map(emp => ({
                ...emp,
                roles_multiples: empleadosResult.rows
                    .filter(row => row[1] === emp.id_empleado && row[9] === null) // mismo empleado, activo
                    .length > 1
            }));
            
            const nodo = {
                id: row[0],
                nombre: row[1],
                tipo: row[2],
                nivel: row[3],
                descripcion: row[4],
                padre_id: row[5],
                jefes: jefesConInfo,
                personal: personalConInfo,
                total_empleados: empleados.length,
                children: []
            };
            
            // DEBUG: Mostrar cada nodo creado
            console.log(`\nNodo creado: ${nodo.nombre} (ID: ${nodo.id})`);
            console.log(`  - Jefes: ${nodo.jefes.length}, Personal: ${nodo.personal.length}, Total: ${nodo.total_empleados}`);
            if (nodo.jefes.length > 0) {
                nodo.jefes.forEach(jefe => {
                    console.log(`    JEFE: ${jefe.nombre_completo} - ${jefe.cargo}${jefe.roles_multiples ? ' (ROLES MÚLTIPLES)' : ''}`);
                });
            }
            
            return nodo;
        });

        // Construir el árbol jerárquico
        const map = {};
        const roots = [];
        list.forEach((node, i) => {
            map[node.id] = i;
        });

        for (const node of list) {
            if (node.padre_id && map[node.padre_id] !== undefined) {
                list[map[node.padre_id]].children.push(node);
            } else {
                roots.push(node);
            }
        }
        
        // DEBUG: Mostrar respuesta final
        console.log('\n=== RESPUESTA FINAL DEL ORGANIGRAMA ===');
        console.log('Número de nodos raíz:', roots.length);
        roots.forEach((root, index) => {
            console.log(`Raíz ${index + 1}: ${root.nombre}`);
            console.log(`  - Jefes: ${root.jefes?.length || 'undefined'}, Personal: ${root.personal?.length || 'undefined'}, Total: ${root.total_empleados || 'undefined'}`);
            console.log(`  - Hijos: ${root.children?.length || 0}`);
        });
        
        res.json(roots);
    } catch (err) {
        console.error(`Error al obtener estructura organizacional para el museo ${id_museo}:`, err);
        res.status(500).json({ message: 'Error al obtener la estructura organizacional' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener la ficha detallada de un museo (AJUSTADO SEGÚN TUTORA)
app.get('/api/museos/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // --- Consultas Básicas ---
        const museoPromise = connection.execute(
            `SELECT id_museo, nombre, fecha_fundacion, mision 
             FROM ${dbConfig.schema}.MUSEOS 
             WHERE id_museo = :id`,
            [id_museo]
        );
        
        const historiaPromise = connection.execute(
            `SELECT anio, hecho 
             FROM ${dbConfig.schema}.HIST_MUSEOS 
             WHERE id_museo = :id 
             ORDER BY anio ASC`,
            [id_museo]
        );
        
        // --- Colecciones Simplificadas (solo nombres, sin descripciones) ---
        const coleccionesPromise = connection.execute(
            `SELECT nombre 
             FROM ${dbConfig.schema}.COLECCIONES_PERMANENTES 
             WHERE id_museo = :id 
             ORDER BY orden_recorrido ASC`,
            [id_museo]
        );

                // --- Ranking desde la vista mejorada (consulta simple) ---
        const rankingPromise = connection.execute(
            `SELECT 
                ciudad,
                pais,
                antiguedad_promedio_anios,
                tasa_rotacion_alta_pct,
                visitas_ultimo_anio,
                estabilidad_score,
                popularidad_score,
                score_final,
                categoria_ranking,
                posicion_mundial,
                total_mundial,
                posicion_nacional,
                total_nacional
             FROM ${dbConfig.schema}.V_MUSEOS_RANKING_SCORES 
             WHERE id_museo = :id`,
            [id_museo]
        );
        
        // --- Ejecución y Procesamiento ---
        const [museoResult, historiaResult, coleccionesResult, rankingResult] = await Promise.all([
            museoPromise,
            historiaPromise,
            coleccionesPromise,
            rankingPromise
        ]);

        if (museoResult.rows.length === 0) {
            return res.status(404).json({ message: 'Museo no encontrado' });
        }

        // --- Procesamiento del Ranking con Posiciones ---
        let rankingData = null;
        
        if (rankingResult.rows.length > 0) {
            const r = rankingResult.rows[0];
            rankingData = {
                ubicacion: {
                    ciudad: r[0] || 'No especificada',
                    pais: r[1] || 'No especificado'
                },
                metricas: {
                    antiguedad_promedio_anios: r[2] || 0,
                    tasa_rotacion_alta_pct: r[3] || 0,
                    visitas_ultimo_anio: r[4] || 0
                },
                puntuaciones: {
                    estabilidad_score: r[5] || 0,
                    popularidad_score: r[6] || 0,
                    score_final: r[7] || 0
                },
                categoria: r[8] || 'Sin clasificar',
                posiciones: {
                    mundial: {
                        posicion: r[9] || null,
                        total: r[10] || null
                    },
                    nacional: {
                        posicion: r[11] || null,
                        total: r[12] || null
                    }
                }
            };
        }

        // --- Ensamblaje de la Respuesta ---
        const museoData = {
            id: museoResult.rows[0][0],
            nombre: museoResult.rows[0][1],
            fecha_fundacion: museoResult.rows[0][2],
            mision: museoResult.rows[0][3],
            ranking: rankingData,
            historia: historiaResult.rows.map(r => ({ anio: r[0], hecho: r[1] })),
            colecciones: coleccionesResult.rows.map(r => r[0]) // Solo nombres de colecciones
        };
        
        res.json(museoData);

    } catch (err) {
        console.error(`Error al obtener la ficha del museo ${id_museo}:`, err);
        res.status(500).json({ message: 'Error al obtener la ficha del museo', error: err.message });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});




// Endpoint para obtener la lista de curadores
app.get('/api/empleados/curadores/:id_museo', async (req, res) => {
    let connection;
    try {
        const idMuseo = req.params.id_museo;
        console.log(`Buscando curadores para museo ID: ${idMuseo}`);
        connection = await oracledb.getConnection(dbConfig);

        const query = 
        `SELECT 
            ep.id_empleado, 
            ep.primer_nombre, 
            ep.primer_apellido, 
            ep.doc_identidad, 
            he.cargo,
            ROUND((SYSDATE - he.fecha_inicio) / 365.25, 1) as antiguedad_años
         FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
         JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON he.id_empleado_prof = ep.id_empleado
         WHERE he.id_museo = :idMuseo 
           AND he.cargo = 'CURADOR'
           AND he.fecha_fin IS NULL
         ORDER BY ep.primer_apellido, ep.primer_nombre`;

        const result = await connection.execute(query, [idMuseo]);
        
        console.log(`Encontrados ${result.rows.length} curadores`);

        const empleados = result.rows.map(row => ({
            id: row[0],
            nombre: `${row[1]} ${row[2]}`,
            apellido: row[2], // Añadir apellido separado para compatibilidad
            doc_identidad: row[3],
            cargo: row[4],
            antiguedad_años: row[5]
        }));
        
        res.json(empleados);
    } catch (err) {
        console.error('Error al obtener curadores:', err);
        res.status(500).json({message: 'Error al obtener a los curadores', error: err.message});
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener la lista de restauradores  
app.get('/api/empleados/restauradores/:id_museo', async (req, res) => {
    let connection;
    try {
        const idMuseo = req.params.id_museo;
        console.log(`Buscando restauradores para museo ID: ${idMuseo}`);
        connection = await oracledb.getConnection(dbConfig);
        
        const result = await connection.execute(
            `SELECT 
                ep.id_empleado, 
                ep.primer_nombre, 
                ep.primer_apellido, 
                ep.doc_identidad, 
                he.cargo,
                ROUND((SYSDATE - he.fecha_inicio) / 365.25, 1) as antiguedad_años
             FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
             JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON he.id_empleado_prof = ep.id_empleado
             WHERE he.id_museo = :idMuseo 
               AND he.cargo = 'RESTAURADOR' 
               AND he.fecha_fin IS NULL
             ORDER BY ep.primer_apellido, ep.primer_nombre`,
            [idMuseo]
        );
        
        console.log(`Encontrados ${result.rows.length} restauradores`);
        
        const empleados = result.rows.map(row => ({
            id: row[0],
            nombre: `${row[1]} ${row[2]}`,
            apellido: row[2], // Añadir apellido separado para compatibilidad
            doc_identidad: row[3],
            cargo: row[4],
            antiguedad_años: row[5]
        }));
        
        res.json(empleados);
    } catch (err) {
        console.error('Error al obtener restauradores:', err);
        res.status(500).json({message: 'Error al obtener a los restauradores', error: err.message});
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});


// Endpoint para obtener la lista de empleados profesionales
app.get('/api/empleados', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT id_empleado, primer_nombre, primer_apellido, doc_identidad 
             FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES 
             ORDER BY primer_apellido, primer_nombre`
        );
        
        const empleados = result.rows.map(row => ({
            id: row[0],
            nombre: `${row[1]} ${row[2]}`,
            doc_identidad: row[3]
        }));
        
        res.json(empleados);
    } catch (err) {
        console.error('Error al obtener empleados:', err);
        res.status(500).json({ message: 'Error al obtener la lista de empleados' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para búsqueda de empleados para expediente (SOLO CURADORES Y RESTAURADORES)
app.get('/api/empleados/buscar', async (req, res) => {
    const { q } = req.query; // q = query de búsqueda
    let connection;
    
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // Construir la consulta de búsqueda - SOLO curadores y restauradores activos
        let sql = `
            SELECT DISTINCT
                ep.id_empleado,
                ep.primer_nombre,
                ep.segundo_nombre,
                ep.primer_apellido,
                ep.segundo_apellido,
                ep.doc_identidad,
                -- Información de posición actual (solo empleados activos)
                he_actual.cargo as cargo_actual,
                m_actual.nombre as museo_actual,
                eo_actual.nombre as departamento_actual,
                he_actual.fecha_inicio as fecha_inicio_actual
            FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
            -- JOIN para obtener la posición actual (empleados activos)
            INNER JOIN ${dbConfig.schema}.HIST_EMPLEADOS he_actual 
                ON ep.id_empleado = he_actual.id_empleado_prof 
                AND he_actual.fecha_fin IS NULL
                AND he_actual.cargo IN ('CURADOR', 'RESTAURADOR')
            LEFT JOIN ${dbConfig.schema}.MUSEOS m_actual 
                ON he_actual.id_museo = m_actual.id_museo
            LEFT JOIN ${dbConfig.schema}.EST_ORGANIZACIONAL eo_actual 
                ON he_actual.id_est_org = eo_actual.id_est_org
            WHERE 1=1
        `;
        
        const params = {};
        
        // Si hay query de búsqueda, filtrar por nombre o documento
        if (q && q.trim() !== '') {
            sql += ` AND (
                UPPER(ep.primer_nombre) LIKE UPPER(:search) 
                OR UPPER(ep.segundo_nombre) LIKE UPPER(:search) 
                OR UPPER(ep.primer_apellido) LIKE UPPER(:search) 
                OR UPPER(ep.segundo_apellido) LIKE UPPER(:search)
                OR UPPER(ep.doc_identidad) LIKE UPPER(:search)
                OR UPPER(ep.primer_nombre || ' ' || ep.primer_apellido) LIKE UPPER(:search)
                OR UPPER(ep.primer_nombre || ' ' || ep.segundo_nombre || ' ' || ep.primer_apellido || ' ' || ep.segundo_apellido) LIKE UPPER(:search)
            )`;
            params.search = `%${q.trim()}%`;
        }
        
        sql += ` ORDER BY he_actual.cargo, ep.primer_apellido, ep.primer_nombre`;
        
        const result = await connection.execute(sql, params);
        
        const empleados = result.rows.map(row => {
            // Construir nombre completo
            const nombres = [row[1], row[2], row[3], row[4]].filter(Boolean);
            const nombreCompleto = nombres.join(' ');
            
            return {
                id: row[0],
                nombre_completo: nombreCompleto,
                primer_nombre: row[1],
                segundo_nombre: row[2],
                primer_apellido: row[3],
                segundo_apellido: row[4],
                doc_identidad: row[5],
                // Información de posición actual
                posicion_actual: {
                    cargo: row[6],
                    museo: row[7],
                    departamento: row[8],
                    fecha_inicio: row[9],
                    activo: row[6] !== null // Si tiene cargo, está activo
                }
            };
        });
        
        res.json(empleados);
        
    } catch (err) {
        console.error('Error en búsqueda de empleados:', err);
        res.status(500).json({ 
            message: 'Error al buscar empleados (curadores y restauradores)',
            error: err.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener la ficha detallada de un empleado
app.get('/api/empleados/:id_empleado', async (req, res) => {
    const { id_empleado } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Datos personales
        const empleadoPromise = connection.execute(
            `SELECT * FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES WHERE id_empleado = :id`,
            [id_empleado]
        );

        // 2. Formación académica
        const formacionPromise = connection.execute(
            `SELECT titulo, anio, descripcion_espec FROM ${dbConfig.schema}.FORMACIONES WHERE id_empleado_prof = :id ORDER BY anio DESC`,
            [id_empleado]
        );

        // 3. Idiomas
        const idiomasPromise = connection.execute(
            `SELECT i.nombre FROM ${dbConfig.schema}.IDIOMAS i JOIN ${dbConfig.schema}.EMPLEADOS_IDIOMAS ei ON i.id_idioma = ei.id_idioma WHERE ei.id_empleado = :id`,
            [id_empleado]
        );

        // 4. Historial laboral (con filtro opcional por museo)
        const { id_museo_actual } = req.query; // Parámetro opcional
        
        let historialQuery = `
            SELECT h.fecha_inicio, h.fecha_fin, h.cargo, e.nombre as unidad_organizativa, m.nombre as museo
            FROM ${dbConfig.schema}.HIST_EMPLEADOS h
            JOIN ${dbConfig.schema}.EST_ORGANIZACIONAL e ON h.id_est_org = e.id_est_org
            JOIN ${dbConfig.schema}.MUSEOS m ON h.id_museo = m.id_museo
            WHERE h.id_empleado_prof = :id_empleado
        `;
        
        const historialParams = [id_empleado];
        
        // Si se especifica un museo, filtrar solo por ese museo
        if (id_museo_actual) {
            historialQuery += ` AND h.id_museo = :id_museo_actual`;
            historialParams.push(id_museo_actual);
        }
        
        historialQuery += ` ORDER BY h.fecha_inicio DESC`;
        
        const historialPromise = connection.execute(historialQuery, historialParams);

        const [empleadoResult, formacionResult, idiomasResult, historialResult] = await Promise.all([
            empleadoPromise,
            formacionPromise,
            idiomasPromise,
            historialPromise
        ]);

        if (empleadoResult.rows.length === 0) {
            return res.status(404).json({ message: 'Empleado no encontrado' });
        }
        
        const emp = empleadoResult.rows[0];
        const empleadoData = {
            id: emp[0],
            doc_identidad: emp[1],
            primer_nombre: emp[2],
            primer_apellido: emp[3],
            fecha_nacimiento: emp[4],
            contacto: emp[5],
            segundo_nombre: emp[6],
            segundo_apellido: emp[7],
            formaciones: formacionResult.rows.map(r => ({ titulo: r[0], anio: r[1], descripcion: r[2] })),
            idiomas: idiomasResult.rows.map(r => r[0]),
            historial: historialResult.rows.map(r => ({
                fecha_inicio: r[0],
                fecha_fin: r[1],
                cargo: r[2],
                unidad: r[3],
                museo: r[4]
            }))
        };
        
        res.json(empleadoData);

    } catch (err) {
        console.error(`Error al obtener la ficha del empleado ${id_empleado}:`, err);
        res.status(500).json({ message: 'Error al obtener la ficha del empleado' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener reporte de ingresos por tickets
app.get('/api/tickets/ingresos', async (req, res) => {
    const { id_museo, fecha_inicio, fecha_fin } = req.query;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        let sql = `
            SELECT 
                m.nombre as nombre_museo,
                t.tipo,
                COUNT(t.id_num_ticket) as cantidad_tickets,
                SUM(t.precio) as total_ingresos
            FROM ${dbConfig.schema}.TICKETS t
            JOIN ${dbConfig.schema}.MUSEOS m ON t.id_museo = m.id_museo
        `;
        
        const whereClauses = [];
        const params = {};

        if (id_museo) {
            whereClauses.push(`t.id_museo = :id_museo`);
            params.id_museo = id_museo;
        }
        if (fecha_inicio) {
            whereClauses.push(`t.fecha_hora_emision >= :fecha_inicio`);
            params.fecha_inicio = new Date(fecha_inicio);
        }
        if (fecha_fin) {
            // Se suma un día para incluir todo el día de fecha_fin
            const fin = new Date(fecha_fin);
            fin.setDate(fin.getDate() + 1);
            whereClauses.push(`t.fecha_hora_emision < :fecha_fin`);
            params.fecha_fin = fin;
        }

        if (whereClauses.length > 0) {
            sql += ` WHERE ${whereClauses.join(' AND ')}`;
        }

        sql += ` 
            GROUP BY m.nombre, t.tipo
            ORDER BY m.nombre, t.tipo
        `;

        const result = await connection.execute(sql, params);

        const reporte = result.rows.map(r => ({
            museo: r[0],
            tipo_ticket: r[1],
            cantidad: r[2],
            ingresos: r[3]
        }));

        res.json(reporte);

    } catch (err) {
        console.error('Error al generar el reporte de ingresos:', err);
        res.status(500).json({ message: 'Error al generar el reporte de ingresos' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para registrar la venta de un ticket
// ACTUALIZADO: Ahora maneja la lógica que antes realizaba el trigger TRG_TICKETS_BEFORE_INSERT
app.post('/api/tickets', async (req, res) => {
    const { id_museo, tipo } = req.body;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // PASO 1: Validar entrada
        if (!id_museo || !tipo) {
            return res.status(400).json({ 
                message: 'Error: id_museo y tipo son obligatorios' 
            });
        }

        // PASO 2: Obtener el precio correcto desde TIPO_TICKETS
        const precioResult = await connection.execute(
            `SELECT precio 
             FROM ${dbConfig.schema}.TIPO_TICKETS 
             WHERE id_museo = :id_museo 
               AND tipo = :tipo 
               AND SYSDATE >= fecha_inicio 
               AND (fecha_fin IS NULL OR SYSDATE <= fecha_fin)`,
            { id_museo, tipo }
        );

        if (precioResult.rows.length === 0) {
            return res.status(400).json({ 
                message: `Error: No se encontró un precio válido para el ticket tipo "${tipo}" en el museo ${id_museo} para la fecha actual.`
            });
        }

        if (precioResult.rows.length > 1) {
            return res.status(400).json({ 
                message: `Error: Se encontraron múltiples precios válidos. Verifique los datos en TIPO_TICKETS para evitar solapamientos de fechas.`
            });
        }

        const precio = precioResult.rows[0][0];

        // PASO 3: Generar el siguiente ID de ticket para el museo
        const maxIdResult = await connection.execute(
            `SELECT NVL(MAX(id_num_ticket), 0) + 1 as next_id 
             FROM ${dbConfig.schema}.TICKETS 
             WHERE id_museo = :id_museo`,
            { id_museo }
        );

        const nuevoIdTicket = maxIdResult.rows[0][0];

        // PASO 4: Insertar el ticket con los valores calculados
        const insertResult = await connection.execute(
            `INSERT INTO ${dbConfig.schema}.TICKETS (
                id_num_ticket, id_museo, tipo, precio, fecha_hora_emision
             ) VALUES (
                :id_num_ticket, :id_museo, :tipo, :precio, SYSDATE
             )`,
            {
                id_num_ticket: nuevoIdTicket,
                id_museo: id_museo,
                tipo: tipo,
                precio: precio
            },
            { autoCommit: true }
        );

        const nuevoTicket = {
            id_num_ticket: nuevoIdTicket,
            id_museo: id_museo,
            tipo: tipo,
            precio: precio,
            fecha_hora_emision: new Date()
        };

        res.status(201).json({ 
            message: 'Ticket vendido exitosamente',
            ticket: nuevoTicket 
        });
        
    } catch (err) {
        console.error('Error al vender ticket:', err);
        
        // Manejo específico de errores comunes
        if (err.message && err.message.includes('ORA-00001')) {
            res.status(409).json({ 
                message: 'Error: Ya existe un ticket con ese ID. Intente nuevamente.',
                error: 'Duplicated ID' 
            });
        } else {
            res.status(500).json({ 
                message: 'Error al vender el ticket',
                error: err.message 
            });
        }
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para obtener la ficha detallada de una obra
app.get('/api/obras/:id_obra', async (req, res) => {
    const { id_obra } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Datos base de la obra
        const obraPromise = connection.execute(
            `SELECT * FROM ${dbConfig.schema}.OBRAS WHERE id_obra = :id`,
            [id_obra]
        );

        // 2. Artistas de la obra
        const artistasPromise = connection.execute(
            `SELECT a.id_artista, a.primer_nombre, a.primer_apellido, a.apodo 
             FROM ${dbConfig.schema}.ARTISTAS a 
             JOIN ${dbConfig.schema}.ARTISTAS_OBRAS ao ON a.id_artista = ao.id_artista 
             WHERE ao.id_obra = :id`,
            [id_obra]
        );

        // 3. Historial de movimientos
        const historialPromise = connection.execute(
            `SELECT m.nombre as museo, h.fecha_ingreso, h.fecha_salida, h.id_catalogo_museo, h.motivo_mov 
             FROM ${dbConfig.schema}.HIST_OBRAS_MOV h 
             JOIN ${dbConfig.schema}.MUSEOS m ON h.id_museo = m.id_museo 
             WHERE h.id_obra = :id 
             ORDER BY h.fecha_ingreso DESC`,
            [id_obra]
        );

        const [obraResult, artistasResult, historialResult] = await Promise.all([
            obraPromise,
            artistasPromise,
            historialPromise
        ]);

        if (obraResult.rows.length === 0) {
            return res.status(404).json({ message: 'Obra no encontrada' });
        }
        
        const o = obraResult.rows[0];
        const obraData = {
            id: o[0],
            nombre: o[1],
            anio_creacion: o[2],
            descripcion_detallada: o[3],
            epoca: o[4],
            origen: o[5],
            dimensiones: o[6],
            estado_conservacion: o[7],
            tecnica: o[8],
            tipo_obra: o[9],
            estatus: o[10],
            url_img: o[11],
            artistas: artistasResult.rows.map(r => ({
                id: r[0],
                nombre: `${r[1]} ${r[2]}`.trim(),
                apodo: r[3]
            })),
            historial_movimientos: historialResult.rows.map(r => ({
                museo: r[0],
                fecha_ingreso: r[1],
                fecha_salida: r[2],
                id_catalogo: r[3],
                motivo: r[4]
            }))
        };
        
        res.json(obraData);

    } catch (err) {
        console.error(`Error al obtener la ficha de la obra ${id_obra}:`, err);
        res.status(500).json({ message: 'Error al obtener la ficha de la obra' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para dashboard de mantenimientos (funcionalidad avanzada)
app.get('/api/dashboard/mantenimientos/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Programas activos
        const programasActivosPromise = connection.execute(
            `SELECT 
                pm.id_mant,
                o.nombre as obra,
                pm.actividad,
                pm.frecuencia,
                pm.tipo_responsable,
                hom.fecha_entrada,
                COUNT(mor.id_mant_realizado) as mantenimientos_realizados
             FROM ${dbConfig.schema}.PROGRAMAS_MANT pm
             JOIN ${dbConfig.schema}.OBRAS o ON pm.id_obra = o.id_obra
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON pm.id_catalogo = hom.id_catalogo_museo 
                 AND pm.id_obra = hom.id_obra
             LEFT JOIN ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor ON pm.id_mant = mor.id_mant
             WHERE hom.id_museo = :id_museo 
               AND hom.fecha_salida IS NULL
             GROUP BY pm.id_mant, o.nombre, pm.actividad, pm.frecuencia, pm.tipo_responsable, hom.fecha_entrada
             ORDER BY o.nombre`,
            [id_museo]
        );

        // 2. Mantenimientos pendientes (programados automáticamente)
        const mantenimientosPendientesPromise = connection.execute(
            `SELECT 
                mor.id_mant_realizado,
                o.nombre as obra,
                pm.actividad,
                mor.fecha_inicio,
                ep.primer_nombre || ' ' || ep.primer_apellido as responsable,
                CASE 
                    WHEN mor.fecha_inicio < SYSDATE - 7 THEN 'VENCIDO'
                    WHEN mor.fecha_inicio < SYSDATE THEN 'URGENTE'
                    ELSE 'PENDIENTE'
                END as estado
             FROM ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor
             JOIN ${dbConfig.schema}.PROGRAMAS_MANT pm ON mor.id_mant = pm.id_mant
             JOIN ${dbConfig.schema}.OBRAS o ON mor.id_obra = o.id_obra
             JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON mor.id_empleado = ep.id_empleado
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON mor.id_catalogo = hom.id_catalogo_museo 
                 AND mor.id_obra = hom.id_obra
             WHERE hom.id_museo = :id_museo 
               AND mor.fecha_fin IS NULL
             ORDER BY mor.fecha_inicio ASC`,
            [id_museo]
        );

        // 3. Mantenimientos en curso
        const mantenimientosEnCursoPromise = connection.execute(
            `SELECT 
                mor.id_mant_realizado,
                o.nombre as obra,
                pm.actividad,
                mor.fecha_inicio,
                ep.primer_nombre || ' ' || ep.primer_apellido as responsable,
                SYSDATE - mor.fecha_inicio as dias_transcurridos
             FROM ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor
             JOIN ${dbConfig.schema}.PROGRAMAS_MANT pm ON mor.id_mant = pm.id_mant
             JOIN ${dbConfig.schema}.OBRAS o ON mor.id_obra = o.id_obra
             JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON mor.id_empleado = ep.id_empleado
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON mor.id_catalogo = hom.id_catalogo_museo 
                 AND mor.id_obra = hom.id_obra
             WHERE hom.id_museo = :id_museo 
               AND mor.fecha_fin IS NULL 
               AND mor.fecha_inicio <= SYSDATE
             ORDER BY mor.fecha_inicio DESC`,
            [id_museo]
        );

        // 4. Estadísticas generales
        const estadisticasPromise = connection.execute(
            `SELECT 
                COUNT(DISTINCT pm.id_mant) as total_programas,
                COUNT(DISTINCT CASE WHEN mor.fecha_fin IS NULL THEN mor.id_mant_realizado END) as mantenimientos_activos,
                COUNT(DISTINCT CASE WHEN mor.fecha_fin IS NOT NULL THEN mor.id_mant_realizado END) as mantenimientos_completados,
                AVG(CASE WHEN mor.fecha_fin IS NOT NULL THEN mor.fecha_fin - mor.fecha_inicio END) as duracion_promedio_dias
             FROM ${dbConfig.schema}.PROGRAMAS_MANT pm
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON pm.id_catalogo = hom.id_catalogo_museo 
                 AND pm.id_obra = hom.id_obra
             LEFT JOIN ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor ON pm.id_mant = mor.id_mant
             WHERE hom.id_museo = :id_museo 
               AND hom.fecha_salida IS NULL`,
            [id_museo]
        );

        const [programasResult, pendientesResult, enCursoResult, estadisticasResult] = await Promise.all([
            programasActivosPromise,
            mantenimientosPendientesPromise,
            mantenimientosEnCursoPromise,
            estadisticasPromise
        ]);

        const dashboard = {
            programas_activos: programasResult.rows.map(row => ({
                id: row[0],
                obra: row[1],
                actividad: row[2],
                frecuencia: row[3],
                tipo_responsable: row[4],
                fecha_entrada_obra: row[5],
                mantenimientos_realizados: row[6]
            })),
            mantenimientos_pendientes: pendientesResult.rows.map(row => ({
                id: row[0],
                obra: row[1],
                actividad: row[2],
                fecha_inicio: row[3],
                responsable: row[4],
                estado: row[5]
            })),
            mantenimientos_en_curso: enCursoResult.rows.map(row => ({
                id: row[0],
                obra: row[1],
                actividad: row[2],
                fecha_inicio: row[3],
                responsable: row[4],
                dias_transcurridos: Math.floor(row[5])
            })),
            estadisticas: {
                total_programas: estadisticasResult.rows[0][0],
                mantenimientos_activos: estadisticasResult.rows[0][1],
                mantenimientos_completados: estadisticasResult.rows[0][2],
                duracion_promedio_dias: estadisticasResult.rows[0][3] ? Math.round(estadisticasResult.rows[0][3] * 10) / 10 : 0
            }
        };

        res.json(dashboard);

    } catch (err) {
        console.error('Error en dashboard de mantenimientos:', err);
        res.status(500).json({ message: 'Error al obtener el dashboard de mantenimientos' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para reporte de eficiencia de mantenimientos
app.get('/api/reportes/eficiencia-mantenimiento/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    const { periodo } = req.query; // 'mensual', 'trimestral', 'anual'
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // Definir período de análisis
        let fechaInicio;
        switch(periodo) {
            case 'mensual':
                fechaInicio = 'SYSDATE - 30';
                break;
            case 'trimestral':
                fechaInicio = 'SYSDATE - 90';
                break;
            case 'anual':
                fechaInicio = 'SYSDATE - 365';
                break;
            default:
                fechaInicio = 'SYSDATE - 90'; // Por defecto trimestral
        }

        // KPIs de eficiencia
        const eficienciaResult = await connection.execute(
            `SELECT 
                -- % de mantenimientos completados a tiempo
                ROUND(
                    COUNT(CASE WHEN mor.fecha_fin IS NOT NULL AND mor.fecha_fin <= mor.fecha_inicio + 7 THEN 1 END) * 100.0 / 
                    NULLIF(COUNT(CASE WHEN mor.fecha_fin IS NOT NULL THEN 1 END), 0), 2
                ) as porcentaje_a_tiempo,
                
                -- Tiempo promedio de ejecución por tipo
                AVG(CASE WHEN pm.tipo_responsable = 'RESTAURADOR' AND mor.fecha_fin IS NOT NULL 
                         THEN mor.fecha_fin - mor.fecha_inicio END) as tiempo_promedio_restaurador,
                AVG(CASE WHEN pm.tipo_responsable = 'CURADOR' AND mor.fecha_fin IS NOT NULL 
                         THEN mor.fecha_fin - mor.fecha_inicio END) as tiempo_promedio_curador,
                
                -- Obras con mantenimiento vencido
                COUNT(CASE WHEN mor.fecha_fin IS NULL AND mor.fecha_inicio < SYSDATE - 7 THEN 1 END) as obras_vencidas,
                
                -- Carga de trabajo por empleado (activos)
                COUNT(CASE WHEN mor.fecha_fin IS NULL THEN 1 END) / 
                NULLIF(COUNT(DISTINCT mor.id_empleado), 0) as carga_promedio_por_empleado
                
             FROM ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor
             JOIN ${dbConfig.schema}.PROGRAMAS_MANT pm ON mor.id_mant = pm.id_mant
             JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON mor.id_catalogo = hom.id_catalogo_museo 
                 AND mor.id_obra = hom.id_obra
             WHERE hom.id_museo = :id_museo 
               AND mor.fecha_inicio >= ${fechaInicio}`,
            [id_museo]
        );

        // Detalle por empleado
        const empleadosResult = await connection.execute(
            `SELECT 
                ep.primer_nombre || ' ' || ep.primer_apellido as empleado,
                he.cargo,
                COUNT(mor.id_mant_realizado) as total_asignados,
                COUNT(CASE WHEN mor.fecha_fin IS NOT NULL THEN 1 END) as completados,
                COUNT(CASE WHEN mor.fecha_fin IS NULL THEN 1 END) as pendientes,
                AVG(CASE WHEN mor.fecha_fin IS NOT NULL THEN mor.fecha_fin - mor.fecha_inicio END) as tiempo_promedio
             FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
             JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON ep.id_empleado = he.id_empleado_prof
             LEFT JOIN ${dbConfig.schema}.MANTENIMIENTOS_OBRAS_REALIZADOS mor ON ep.id_empleado = mor.id_empleado
                 AND mor.fecha_inicio >= ${fechaInicio}
             WHERE he.id_museo = :id_museo 
               AND he.fecha_fin IS NULL
               AND he.cargo IN ('RESTAURADOR', 'CURADOR')
             GROUP BY ep.primer_nombre, ep.primer_apellido, he.cargo
             ORDER BY total_asignados DESC`,
            [id_museo]
        );

        const eficiencia = eficienciaResult.rows[0];
        const reporte = {
            periodo: periodo || 'trimestral',
            kpis: {
                porcentaje_completados_a_tiempo: eficiencia[0] || 0,
                tiempo_promedio_restaurador: eficiencia[1] ? Math.round(eficiencia[1] * 10) / 10 : null,
                tiempo_promedio_curador: eficiencia[2] ? Math.round(eficiencia[2] * 10) / 10 : null,
                obras_con_mantenimiento_vencido: eficiencia[3] || 0,
                carga_promedio_por_empleado: eficiencia[4] ? Math.round(eficiencia[4] * 10) / 10 : 0
            },
            detalle_empleados: empleadosResult.rows.map(row => ({
                empleado: row[0],
                cargo: row[1],
                total_asignados: row[2],
                completados: row[3],
                pendientes: row[4],
                tiempo_promedio_dias: row[5] ? Math.round(row[5] * 10) / 10 : null,
                eficiencia_porcentaje: row[2] > 0 ? Math.round((row[3] / row[2]) * 100) : 0
            }))
        };

        res.json(reporte);

    } catch (err) {
        console.error('Error en reporte de eficiencia:', err);
        res.status(500).json({ message: 'Error al generar el reporte de eficiencia' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para generar el reporte de estructura física (REFACTORIZADO - SIN CONSULTAS INNECESARIAS)
app.get('/api/reportes/estructura-fisica/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Información básica del museo
        const museoPromise = connection.execute(
            `SELECT nombre, fecha_fundacion, mision FROM ${dbConfig.schema}.MUSEOS WHERE id_museo = :id`,
            [id_museo]
        );

        // 2. Estructura física jerárquica con información detallada
        const estructuraPromise = connection.execute(
            `SELECT 
                ef.id_est, 
                ef.nombre, 
                ef.tipo, 
                ef.descripcion, 
                ef.direccion_edificio, 
                ef.id_est_padre
             FROM ${dbConfig.schema}.EST_FISICA ef
             WHERE ef.id_museo = :id
             ORDER BY ef.tipo DESC, ef.nombre ASC`,
            [id_museo]
        );

        // 3. Exposiciones actuales (solo campos usados en frontend)
        const exposicionesPromise = connection.execute(
            `SELECT 
                ee.nombre as nombre_evento,
                se.nombre as nombre_sala
             FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS ee
             JOIN ${dbConfig.schema}.SALAS_EXP se ON ee.id_sala = se.id_sala 
                 AND ee.id_est = se.id_est AND ee.id_museo = se.id_museo
             WHERE ee.id_museo = :id 
                 AND ee.fecha_fin >= SYSDATE
             ORDER BY ee.fecha_inicio ASC`,
            [id_museo]
        );

        const [museoResult, estructuraResult, exposicionesResult] = await Promise.all([
            museoPromise,
            estructuraPromise,
            exposicionesPromise
        ]);

        if (museoResult.rows.length === 0) {
            return res.status(404).json({ message: 'Museo no encontrado' });
        }

        // Procesar estructura física en formato jerárquico (SIMPLIFICADO)
        const estructura = estructuraResult.rows.map(row => ({
            id: row[0],
            nombre: row[1],
            tipo: row[2],
            descripcion: row[3],
            direccion_edificio: row[4],
            padre_id: row[5],
            children: []
        }));

        // Construir jerarquía
        const map = {}, roots = [];
        estructura.forEach((node, i) => {
            map[node.id] = i;
        });

        for (const node of estructura) {
            if (node.padre_id && estructura[map[node.padre_id]]) {
                estructura[map[node.padre_id]].children.push(node);
            } else {
                roots.push(node);
            }
        }

        // Datos del reporte final (SIMPLIFICADO - SOLO CAMPOS USADOS)
        const reporte = {
            museo: {
                nombre: museoResult.rows[0][0],
                fecha_fundacion: museoResult.rows[0][1],
                mision: museoResult.rows[0][2]
            },
            estructura_fisica: roots,
            exposiciones_actuales: exposicionesResult.rows.map(r => ({
                nombre: r[0],
                sala: r[1]
            })),
            resumen: {
                total_elementos: estructura.length,
                total_edificios: estructura.filter(e => e.tipo === 'EDIFICIO').length,
                total_pisos: estructura.filter(e => e.tipo === 'PISO').length,
                total_areas: estructura.filter(e => e.tipo === 'AREA').length,
                total_exposiciones_activas: exposicionesResult.rows.length
            }
        };
        
        res.json(reporte);

    } catch (err) {
        console.error(`Error al generar reporte de estructura física para museo ${id_museo}:`, err);
        res.status(500).json({ message: 'Error al generar el reporte de estructura física' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// ENDPOINT DUPLICADO ELIMINADO - YA EXISTE UNA VERSIÓN REFACTORIZADA ARRIBA

// Endpoint para obtener estadísticas generales del sistema
app.get('/api/estadisticas', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        console.log('[ESTADISTICAS] Iniciando consultas con schema:', dbConfig.schema);
        
        // Ejecutar consultas una por una para identificar cuál falla
        let estadisticas = {
            totalArtistas: 0,
            totalEmpleados: 0,
            totalMuseos: 0,
            totalExposiciones: 0
        };

        try {
            console.log('[ESTADISTICAS] Consultando ARTISTAS...');
            const artistasResult = await connection.execute(`SELECT COUNT(*) FROM ${dbConfig.schema}.ARTISTAS`);
            estadisticas.totalArtistas = artistasResult.rows[0][0];
            console.log('[ESTADISTICAS] ARTISTAS OK:', estadisticas.totalArtistas);
        } catch (err) {
            console.error('[ESTADISTICAS] Error en ARTISTAS:', err.message);
        }

        try {
            console.log('[ESTADISTICAS] Consultando EMPLEADOS...');
            const empleadosResult = await connection.execute(`SELECT COUNT(DISTINCT ep.id_empleado) FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON ep.id_empleado = he.id_empleado_prof WHERE he.fecha_fin IS NULL`);
            estadisticas.totalEmpleados = empleadosResult.rows[0][0];
            console.log('[ESTADISTICAS] EMPLEADOS OK:', estadisticas.totalEmpleados);
        } catch (err) {
            console.error('[ESTADISTICAS] Error en EMPLEADOS:', err.message);
        }

        try {
            console.log('[ESTADISTICAS] Consultando MUSEOS...');
            const museosResult = await connection.execute(`SELECT COUNT(*) FROM ${dbConfig.schema}.MUSEOS`);
            estadisticas.totalMuseos = museosResult.rows[0][0];
            console.log('[ESTADISTICAS] MUSEOS OK:', estadisticas.totalMuseos);
        } catch (err) {
            console.error('[ESTADISTICAS] Error en MUSEOS:', err.message);
        }

        try {
            console.log('[ESTADISTICAS] Consultando EXPOSICIONES...');
            const exposicionesResult = await connection.execute(`SELECT COUNT(*) FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS WHERE fecha_fin >= SYSDATE`);
            estadisticas.totalExposiciones = exposicionesResult.rows[0][0];
            console.log('[ESTADISTICAS] EXPOSICIONES OK:', estadisticas.totalExposiciones);
        } catch (err) {
            console.error('[ESTADISTICAS] Error en EXPOSICIONES:', err.message);
        }
        
        console.log('[ESTADISTICAS] Resultado final:', estadisticas);
        res.json(estadisticas);
    } catch (err) {
        console.error('[ESTADISTICAS] Error general:', err);
        res.status(500).json({ 
            message: 'Error al obtener estadísticas del sistema',
            error: err.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint de debug para verificar qué tablas existen
app.get('/api/debug/tables', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const result = await connection.execute(
            `SELECT table_name FROM all_tables WHERE owner = :schema ORDER BY table_name`,
            [dbConfig.schema]
        );
        
        const tables = result.rows.map(row => row[0]);
        
        res.json({
            schema: dbConfig.schema,
            tables: tables,
            total_tables: tables.length
        });
    } catch (err) {
        console.error('[DEBUG-TABLES] Error:', err);
        res.status(500).json({ 
            message: 'Error al obtener lista de tablas',
            error: err.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para estadísticas de artistas
app.get('/api/estadisticas/artistas', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        const totalArtistasPromise = connection.execute(
            `SELECT COUNT(*) FROM ${dbConfig.schema}.ARTISTAS`
        );

        const paisesQuery = `
            SELECT COUNT(DISTINCT pais_id)
            FROM (
                SELECT 
                    CASE 
                        WHEN l.tipo = 'PAIS' THEN l.id_lugar
                        ELSE l.id_lugar_padre 
                    END as pais_id
                FROM ${dbConfig.schema}.ARTISTAS a
                JOIN ${dbConfig.schema}.LUGARES l ON a.id_lugar = l.id_lugar
                WHERE a.id_lugar IS NOT NULL
            )
        `;
        const paisesRepresentadosPromise = connection.execute(paisesQuery);

        const artistasDestacadosPromise = connection.execute(
            `SELECT COUNT(*) FROM ${dbConfig.schema}.ARTISTAS WHERE apodo IS NOT NULL`
        );

        const [
            totalArtistasResult,
            paisesRepresentadosResult,
            artistasDestacadosResult
        ] = await Promise.all([
            totalArtistasPromise,
            paisesRepresentadosPromise,
            artistasDestacadosPromise
        ]);

        const stats = {
            totalArtistas: totalArtistasResult.rows[0][0],
            paisesRepresentados: paisesRepresentadosResult.rows[0][0],
            artistasDestacados: artistasDestacadosResult.rows[0][0]
        };

        res.json(stats);

    } catch (err) {
        console.error('Error al obtener estadísticas de artistas:', err);
        res.status(500).json({ message: 'Error al obtener estadísticas de artistas', error: err.message });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para estadísticas de exposiciones
app.get('/api/estadisticas/exposiciones', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        const exposicionesActivasPromise = connection.execute(
            `SELECT COUNT(*) FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS WHERE SYSDATE BETWEEN fecha_inicio AND fecha_fin`
        );
        
        const eventosProgramadosPromise = connection.execute(
            `SELECT COUNT(*) FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS WHERE fecha_inicio > SYSDATE`
        );

        const salasDisponiblesPromise = connection.execute(
            `SELECT 
                (SELECT COUNT(*) FROM ${dbConfig.schema}.SALAS_EXP) - 
                (SELECT COUNT(DISTINCT id_sala) FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS WHERE SYSDATE BETWEEN fecha_inicio AND fecha_fin) 
             FROM DUAL`
        );
        
        const [
            exposicionesActivasResult,
            eventosProgramadosResult,
            salasDisponiblesResult
        ] = await Promise.all([
            exposicionesActivasPromise,
            eventosProgramadosPromise,
            salasDisponiblesPromise
        ]);

        const stats = {
            exposicionesActivas: exposicionesActivasResult.rows[0][0],
            eventosProgramados: eventosProgramadosResult.rows[0][0],
            salasDisponibles: salasDisponiblesResult.rows[0][0]
        };

        res.json(stats);

    } catch (err) {
        console.error('Error al obtener estadísticas de exposiciones:', err);
        res.status(500).json({ message: 'Error al obtener estadísticas de exposiciones', error: err.message });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Endpoint para crear un nuevo lugar
app.post('/api/lugares', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        const { nombre, tipo, continente, id_lugar_padre } = req.body;

        // Validaciones básicas
        if (!nombre || !tipo) {
            return res.status(400).json({ message: 'Nombre y tipo son obligatorios' });
        }

        if (!['PAIS', 'CIUDAD'].includes(tipo)) {
            return res.status(400).json({ message: 'Tipo debe ser PAIS o CIUDAD' });
        }

        if (tipo === 'PAIS' && !continente) {
            return res.status(400).json({ message: 'Continente es obligatorio para países' });
        }

        if (tipo === 'CIUDAD' && !id_lugar_padre) {
            return res.status(400).json({ message: 'País padre es obligatorio para ciudades' });
        }

        // Verificar si el lugar ya existe
        const existeResult = await connection.execute(
            `SELECT COUNT(*) FROM ${dbConfig.schema}.LUGARES WHERE UPPER(nombre) = UPPER(:nombre) AND tipo = :tipo`,
            { nombre, tipo }
        );

        if (existeResult.rows[0][0] > 0) {
            return res.status(409).json({ message: `Ya existe un ${tipo.toLowerCase()} con ese nombre` });
        }

        // Insertar el nuevo lugar
        const insertQuery = `
            INSERT INTO ${dbConfig.schema}.LUGARES (
                id_lugar, nombre, tipo, continente, id_lugar_padre
            ) VALUES (
                SEQ_LUGARES.NEXTVAL, :nombre, :tipo, :continente, :id_lugar_padre
            ) RETURNING id_lugar INTO :id_lugar
        `;

        const insertParams = {
            nombre,
            tipo,
            continente: tipo === 'PAIS' ? continente : null,
            id_lugar_padre: tipo === 'CIUDAD' ? id_lugar_padre : null,
            id_lugar: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        };

        const result = await connection.execute(insertQuery, insertParams);
        await connection.commit();

        const nuevoId = result.outBinds.id_lugar[0];

        // Obtener el lugar completo insertado
        const lugarResult = await connection.execute(
            `SELECT id_lugar, nombre, tipo, continente, id_lugar_padre 
             FROM ${dbConfig.schema}.LUGARES 
             WHERE id_lugar = :id`,
            { id: nuevoId }
        );

        const nuevoLugar = {
            id: lugarResult.rows[0][0],
            nombre: lugarResult.rows[0][1],
            tipo: lugarResult.rows[0][2],
            continente: lugarResult.rows[0][3],
            id_lugar_padre: lugarResult.rows[0][4]
        };

        res.status(201).json({
            message: 'Lugar creado exitosamente',
            lugar: nuevoLugar
        });

    } catch (err) {
        console.error('Error al crear lugar:', err);
        if (connection) {
            try {
                await connection.rollback();
            } catch (rollbackErr) {
                console.error('Error en rollback:', rollbackErr);
            }
        }
        res.status(500).json({ message: 'Error al crear el lugar', error: err.message });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor backend corriendo en el puerto ${PORT}`);
    console.log(`[DEBUG] Endpoint de obras activas disponible en: GET /api/obras-activas/museo/:id_museo`);
    
    // Log de todas las rutas registradas para debugging (después de la inicialización)
    console.log('[DEBUG] Rutas registradas:');
    if (app._router && app._router.stack) {
        app._router.stack.forEach((r) => {
            if (r.route && r.route.path) {
                console.log(`[DEBUG] ${Object.keys(r.route.methods).join(',').toUpperCase()} ${r.route.path}`);
            }
        });
    } else {
        console.log('[DEBUG] Router no disponible para debug');
    }
}); 

// Endpoint para probar procedimientos almacenados dinámicamente
app.post('/api/test-procedure', async (req, res) => {
    const { procedureName, parameters } = req.body;
    let connection;
    
    try {
        if (!procedureName) {
            return res.status(400).json({ message: 'Nombre del procedimiento es requerido' });
        }
        
        connection = await oracledb.getConnection(dbConfig);
        
        let result;
        let outParams = {};
        
        // Configurar bind variables dinámicamente
        const bindVars = {};
        let sql = '';
        
        // Definición de procedimientos y sus parámetros
        const procedures = {
            // === PROCEDIMIENTOS DE VENTA Y GESTIÓN BÁSICA ===
            'SP_VENDER_TICKET': {
                params: [
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_tipo_ticket', type: 'IN', dbType: 'STRING' },
                    { name: 'p_id_ticket_generado', type: 'OUT', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_VENDER_TICKET(:p_id_museo, :p_tipo_ticket, :p_id_ticket_generado)'
            },
            
            // === PROCEDIMIENTOS DE GESTIÓN DE EMPLEADOS ===
            'SP_REGISTRAR_NUEVO_EMPLEADO': {
                params: [
                    { name: 'p_doc_identidad', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_primer_nombre', type: 'IN', dbType: 'STRING' },
                    { name: 'p_primer_apellido', type: 'IN', dbType: 'STRING' },
                    { name: 'p_fecha_nacimiento', type: 'IN', dbType: 'DATE' },
                    { name: 'p_contacto', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_segundo_nombre', type: 'IN', dbType: 'STRING' },
                    { name: 'p_segundo_apellido', type: 'IN', dbType: 'STRING' },
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_nombre_unidad_org', type: 'IN', dbType: 'STRING' },
                    { name: 'p_cargo', type: 'IN', dbType: 'STRING' },
                    { name: 'p_fecha_inicio_cargo', type: 'IN', dbType: 'DATE' },
                    { name: 'p_id_empleado_generado', type: 'OUT', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_REGISTRAR_NUEVO_EMPLEADO(:p_doc_identidad, :p_primer_nombre, :p_primer_apellido, :p_fecha_nacimiento, :p_contacto, :p_segundo_nombre, :p_segundo_apellido, :p_id_museo, :p_nombre_unidad_org, :p_cargo, :p_fecha_inicio_cargo, :p_id_empleado_generado)'
            },
            'SP_MOVER_EMPLEADO_ACTIVO': {
                params: [
                    { name: 'n_id_empleado', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_est_org', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_cargo', type: 'IN', dbType: 'STRING' }
                ],
                sql: 'CALL SP_MOVER_EMPLEADO_ACTIVO(:n_id_empleado, :n_id_museo, :n_id_est_org, :n_cargo)'
            },
            'SP_MOVER_EMPLEADO_INACTIVO': {
                params: [
                    { name: 'n_id_empleado', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_est_org', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_cargo', type: 'IN', dbType: 'STRING' }
                ],
                sql: 'CALL SP_MOVER_EMPLEADO_INACTIVO(:n_id_empleado, :n_id_museo, :n_id_est_org, :n_cargo)'
            },
            
            // === PROCEDIMIENTOS DE GESTIÓN DE OBRAS ===
            'SP_REGISTRAR_OBRA_NUEVA': {
                params: [
                    { name: 'n_nombre', type: 'IN', dbType: 'STRING' },
                    { name: 'n_fecha_periodo', type: 'IN', dbType: 'DATE' },
                    { name: 'n_tipo_obra', type: 'IN', dbType: 'STRING' },
                    { name: 'n_dimensiones', type: 'IN', dbType: 'STRING' },
                    { name: 'n_desc_mat_tec', type: 'IN', dbType: 'STRING' },
                    { name: 'n_desc_estilos', type: 'IN', dbType: 'STRING' },
                    { name: 'n_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_coleccion', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_sala', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_empleado', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_tipo_adq', type: 'IN', dbType: 'STRING' },
                    { name: 'n_destacada', type: 'IN', dbType: 'STRING' },
                    { name: 'n_orden_recorrido', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_valor_monetario', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_REGISTRAR_OBRA_NUEVA(:n_nombre, :n_fecha_periodo, :n_tipo_obra, :n_dimensiones, :n_desc_mat_tec, :n_desc_estilos, :n_id_museo, :n_id_coleccion, :n_id_sala, :n_id_empleado, :n_tipo_adq, :n_destacada, :n_orden_recorrido, :n_valor_monetario)'
            },
            'SP_MOVER_OBRA': {
                params: [
                    { name: 'n_id_obra', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_museo_destino', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_coleccion_destino', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_sala_destino', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_empleado_destino', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_tipo_adq_destino', type: 'IN', dbType: 'STRING' },
                    { name: 'p_destacada_destino', type: 'IN', dbType: 'STRING' },
                    { name: 'p_orden_recorrido_destino', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_valor_monetario_destino', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_MOVER_OBRA(:n_id_obra, :p_id_museo_destino, :p_id_coleccion_destino, :p_id_sala_destino, :p_id_empleado_destino, :p_tipo_adq_destino, :p_destacada_destino, :p_orden_recorrido_destino, :p_valor_monetario_destino)'
            },
            
            // === PROCEDIMIENTOS DE GESTIÓN DE EXPOSICIONES ===
            'SP_FINALIZAR_EXPOSICION': {
                params: [
                    { name: 'p_id_expo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_FINALIZAR_EXPOSICION(:p_id_expo, :p_id_museo)'
            },
            'SP_ASIGNAR_OBRA_A_EXPOSICION': {
                params: [
                    { name: 'p_id_obra', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_expo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_orden_en_exposicion', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_ASIGNAR_OBRA_A_EXPOSICION(:p_id_obra, :p_id_expo, :p_id_museo, :p_orden_en_exposicion)'
            },
            
            // === PROCEDIMIENTOS DE GESTIÓN DE COLECCIONES ===
            'SP_INSERTAR_COLECCION': {
                params: [
                    { name: 'n_nombre_museo', type: 'IN', dbType: 'STRING' },
                    { name: 'n_nombre_depto', type: 'IN', dbType: 'STRING' },
                    { name: 'n_nombre_coleccion', type: 'IN', dbType: 'STRING' },
                    { name: 'n_caracteristicas', type: 'IN', dbType: 'STRING' },
                    { name: 'n_palabra_clave', type: 'IN', dbType: 'STRING' },
                    { name: 'n_orden_recorrido', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_INSERTAR_COLECCION(:n_nombre_museo, :n_nombre_depto, :n_nombre_coleccion, :n_caracteristicas, :n_palabra_clave, :n_orden_recorrido)'
            },
            'SP_MODIFICAR_ORDEN_COLECCION': {
                params: [
                    { name: 'n_id_coleccion', type: 'IN', dbType: 'STRING' },
                    { name: 'n_orden_recorrido', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_MODIFICAR_ORDEN_COLECCION(:n_id_coleccion, :n_orden_recorrido)'
            },
            'SP_ELIMINAR_COLECCION': {
                params: [
                    { name: 'p_id_coleccion', type: 'IN', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_ELIMINAR_COLECCION(:p_id_coleccion)'
            },
            
            // === PROCEDIMIENTOS DE MANTENIMIENTO ===
            'SP_REGISTRAR_MANTENIMIENTO_OBRA': {
                params: [
                    { name: 'n_id_mant', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_empleado', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_observaciones', type: 'IN', dbType: 'STRING' },
                    { name: 'n_fecha_fin', type: 'IN', dbType: 'DATE' }
                ],
                sql: 'CALL SP_REGISTRAR_MANTENIMIENTO_OBRA(:n_id_mant, :n_id_empleado, :n_observaciones, :n_fecha_fin)'
            },
            'SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO': {
                params: [
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_dias_anticipacion', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_registros_procesados', type: 'OUT', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(:p_id_museo, :p_dias_anticipacion, :p_registros_procesados)'
            },
            'SP_REGISTRAR_CIERRE_TEMPORAL': {
                params: [
                    { name: 'n_fecha_inicio', type: 'IN', dbType: 'DATE' },
                    { name: 'n_id_sala', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_fecha_fin', type: 'IN', dbType: 'DATE' }
                ],
                sql: 'CALL SP_REGISTRAR_CIERRE_TEMPORAL(:n_fecha_inicio, :n_id_sala, :n_fecha_fin)'
            },
            
            // === PROCEDIMIENTOS DE GESTIÓN DE VIGILANCIA ===
            'SP_REGISTRAR_VIGILANTE_MANT': {
                params: [
                    { name: 'n_nombre', type: 'IN', dbType: 'STRING' },
                    { name: 'n_apellido', type: 'IN', dbType: 'STRING' },
                    { name: 'n_doc_identidad', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_tipo_responsable', type: 'IN', dbType: 'STRING' },
                    { name: 'n_id_est', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_turno', type: 'IN', dbType: 'STRING' }
                ],
                sql: 'CALL SP_REGISTRAR_VIGILANTE_MANT(:n_nombre, :n_apellido, :n_doc_identidad, :n_tipo_responsable, :n_id_est, :n_turno)'
            },
            'SP_ASIGNAR_VIGILANTE_MANT': {
                params: [
                    { name: 'n_id_vig_mant', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_id_est', type: 'IN', dbType: 'NUMBER' },
                    { name: 'n_turno', type: 'IN', dbType: 'STRING' }
                ],
                sql: 'CALL SP_REGISTRAR_VIGILANTE_MANT(:n_id_vig_mant, :n_id_est, :n_turno)'
            },
            
            // === PROCEDIMIENTOS DE ANÁLISIS Y RANKING ===
            'SP_CALCULAR_RANKING_MUSEO': {
                params: [
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_antiguedad_promedio_anios', type: 'OUT', dbType: 'NUMBER' },
                    { name: 'p_tasa_rotacion_alta_pct', type: 'OUT', dbType: 'NUMBER' },
                    { name: 'p_visitas_ultimo_anio', type: 'OUT', dbType: 'NUMBER' },
                    { name: 'p_categoria_ranking', type: 'OUT', dbType: 'STRING' }
                ],
                sql: 'CALL SP_CALCULAR_RANKING_MUSEO(:p_id_museo, :p_antiguedad_promedio_anios, :p_tasa_rotacion_alta_pct, :p_visitas_ultimo_anio, :p_categoria_ranking)'
            },
            
            // === PROCEDIMIENTOS DE AUTOMATIZACIÓN Y GESTIÓN DIARIA ===
            'SP_GESTIONAR_ESTADO_EXPOSICIONES': {
                params: [
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_accion_automatica', type: 'IN', dbType: 'STRING' },
                    { name: 'p_registros_procesados', type: 'OUT', dbType: 'NUMBER' }
                ],
                sql: 'CALL SP_GESTIONAR_ESTADO_EXPOSICIONES(:p_id_museo, :p_accion_automatica, :p_registros_procesados)'
            },
            'SP_CONSOLIDAR_OPERACIONES_DIARIAS': {
                params: [
                    { name: 'p_id_museo', type: 'IN', dbType: 'NUMBER' },
                    { name: 'p_ejecutar_acciones', type: 'IN', dbType: 'STRING' },
                    { name: 'p_resumen_operaciones', type: 'OUT', dbType: 'STRING' }
                ],
                sql: 'CALL SP_CONSOLIDAR_OPERACIONES_DIARIAS(:p_id_museo, :p_ejecutar_acciones, :p_resumen_operaciones)'
            }
        };
        
        const procedureConfig = procedures[procedureName];
        if (!procedureConfig) {
            return res.status(400).json({ 
                message: 'Procedimiento no configurado',
                availableProcedures: Object.keys(procedures)
            });
        }
        
        // Configurar parámetros de entrada y salida
        procedureConfig.params.forEach(param => {
            if (param.type === 'IN') {
                let value = parameters[param.name];
                
                // Convertir tipos según sea necesario
                if (param.dbType === 'DATE' && value) {
                    // Convertir string a Date si es necesario
                    if (typeof value === 'string') {
                        value = new Date(value);
                    }
                }
                
                bindVars[param.name] = value;
            } else if (param.type === 'OUT') {
                bindVars[param.name] = { dir: oracledb.BIND_OUT, type: param.dbType === 'NUMBER' ? oracledb.NUMBER : oracledb.STRING };
            }
        });
        
        console.log(`[TEST-PROCEDURE] Ejecutando: ${procedureName}`);
        console.log(`[TEST-PROCEDURE] Parámetros:`, bindVars);
        
        result = await connection.execute(procedureConfig.sql, bindVars);
        
        // Extraer parámetros de salida
        procedureConfig.params
            .filter(param => param.type === 'OUT')
            .forEach(param => {
                outParams[param.name] = bindVars[param.name];
            });
        
        await connection.commit();
        
        res.json({
            success: true,
            message: `Procedimiento ${procedureName} ejecutado exitosamente`,
            outParameters: outParams,
            affectedRows: result.rowsAffected
        });
        
    } catch (err) {
        console.error(`[TEST-PROCEDURE] Error:`, err);
        
        if (connection) {
            try {
                await connection.rollback();
            } catch (rollbackErr) {
                console.error('[TEST-PROCEDURE] Error en rollback:', rollbackErr);
            }
        }
        
        res.status(500).json({
            success: false,
            message: 'Error ejecutando procedimiento',
            error: err.message,
            code: err.code || 'UNKNOWN'
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error('[TEST-PROCEDURE] Error cerrando conexión:', err);
            }
        }
    }
});

// Endpoint para obtener la lista de procedimientos disponibles
app.get('/api/procedures', (req, res) => {
    const procedures = {
        // === VENTA Y GESTIÓN BÁSICA ===
        'SP_VENDER_TICKET': {
            name: 'SP_VENDER_TICKET',
            description: 'Vender un ticket de entrada al museo',
            category: 'Ventas y Admisiones',
            inputParams: [
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true },
                { name: 'p_tipo_ticket', label: 'Tipo de Ticket', type: 'dropdown', dataSource: 'tiposTicket', required: true }
            ],
            outputParams: [
                { name: 'p_id_ticket_generado', label: 'ID del Ticket Generado', type: 'number' }
            ]
        },
        
        // === GESTIÓN DE EMPLEADOS ===
        'SP_REGISTRAR_NUEVO_EMPLEADO': {
            name: 'SP_REGISTRAR_NUEVO_EMPLEADO',
            description: 'Registrar un nuevo empleado profesional en el museo',
            category: 'Recursos Humanos',
            inputParams: [
                { name: 'p_doc_identidad', label: 'Documento de Identidad', type: 'number', required: true },
                { name: 'p_primer_nombre', label: 'Primer Nombre', type: 'text', required: true },
                { name: 'p_primer_apellido', label: 'Primer Apellido', type: 'text', required: true },
                { name: 'p_fecha_nacimiento', label: 'Fecha de Nacimiento', type: 'date', required: true },
                { name: 'p_contacto', label: 'Contacto', type: 'number', required: true },
                { name: 'p_segundo_nombre', label: 'Segundo Nombre', type: 'text', required: false },
                { name: 'p_segundo_apellido', label: 'Segundo Apellido', type: 'text', required: false },
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true },
                { name: 'p_nombre_unidad_org', label: 'Unidad Organizacional', type: 'dropdown', dataSource: 'unidadesOrganizacionales', displayField: 'nombre', required: true },
                { name: 'p_cargo', label: 'Cargo', type: 'dropdown', dataSource: 'cargos', required: true },
                { name: 'p_fecha_inicio_cargo', label: 'Fecha Inicio Cargo', type: 'date', required: true }
            ],
            outputParams: [
                { name: 'p_id_empleado_generado', label: 'ID del Empleado Generado', type: 'number' }
            ]
        },
        'SP_MOVER_EMPLEADO_ACTIVO': {
            name: 'SP_MOVER_EMPLEADO_ACTIVO',
            description: 'Transferir un empleado activo a otro museo o cargo',
            category: 'Recursos Humanos',
            inputParams: [
                { name: 'n_id_empleado', label: 'Empleado', type: 'dropdown', dataSource: 'empleados', required: true },
                { name: 'n_id_museo', label: 'Museo Destino', type: 'dropdown', dataSource: 'museos', required: false },
                { name: 'n_id_est_org', label: 'Estructura Organizacional', type: 'dropdown', dataSource: 'unidadesOrganizacionales', required: false },
                { name: 'n_cargo', label: 'Nuevo Cargo', type: 'dropdown', dataSource: 'cargos', required: false }
            ],
            outputParams: []
        },
        'SP_MOVER_EMPLEADO_INACTIVO': {
            name: 'SP_MOVER_EMPLEADO_INACTIVO',
            description: 'Reactivar y transferir un empleado inactivo',
            category: 'Recursos Humanos',
            inputParams: [
                { name: 'n_id_empleado', label: 'Empleado', type: 'dropdown', dataSource: 'empleados', required: true },
                { name: 'n_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true },
                { name: 'n_id_est_org', label: 'Estructura Organizacional', type: 'dropdown', dataSource: 'unidadesOrganizacionales', required: true },
                { name: 'n_cargo', label: 'Cargo', type: 'dropdown', dataSource: 'cargos', required: true }
            ],
            outputParams: []
        },
        
        // === GESTIÓN DE OBRAS ===
        'SP_REGISTRAR_OBRA_NUEVA': {
            name: 'SP_REGISTRAR_OBRA_NUEVA',
            description: 'Registrar una nueva obra de arte en el sistema',
            category: 'Gestión de Obras',
            inputParams: [
                { name: 'n_nombre', label: 'Título de la Obra', type: 'text', required: true },
                { name: 'n_fecha_periodo', label: 'Fecha/Período', type: 'date', required: true },
                { name: 'n_tipo_obra', label: 'Tipo de Obra', type: 'dropdown', dataSource: 'tiposObra', required: true },
                { name: 'n_dimensiones', label: 'Dimensiones', type: 'text', required: true },
                { name: 'n_desc_mat_tec', label: 'Materiales y Técnicas', type: 'text', required: true },
                { name: 'n_desc_estilos', label: 'Estilos y Géneros', type: 'text', required: true },
                { name: 'n_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true },
                { name: 'n_id_coleccion', label: 'Colección', type: 'dropdown', dataSource: 'colecciones', required: true },
                { name: 'n_id_sala', label: 'Sala', type: 'dropdown', dataSource: 'salas', required: true },
                { name: 'n_id_empleado', label: 'Empleado Responsable', type: 'dropdown', dataSource: 'empleados', required: true },
                { name: 'n_tipo_adq', label: 'Tipo de Adquisición', type: 'dropdown', dataSource: 'tiposAdquisicion', required: true },
                { name: 'n_destacada', label: '¿Es Obra Destacada?', type: 'select', required: true, options: ['SI', 'NO'] },
                { name: 'n_orden_recorrido', label: 'Orden de Recorrido', type: 'number', required: false },
                { name: 'n_valor_monetario', label: 'Valor Monetario', type: 'number', required: false }
            ],
            outputParams: []
        },
        'SP_MOVER_OBRA': {
            name: 'SP_MOVER_OBRA',
            description: 'Mover una obra de arte entre museos, colecciones o salas',
            category: 'Gestión de Obras',
            inputParams: [
                { name: 'n_id_obra', label: 'Obra', type: 'dropdown', dataSource: 'obras', required: true },
                { name: 'p_id_museo_destino', label: 'Museo Destino', type: 'dropdown', dataSource: 'museos', required: false },
                { name: 'p_id_coleccion_destino', label: 'Colección Destino', type: 'dropdown', dataSource: 'colecciones', required: false },
                { name: 'p_id_sala_destino', label: 'Sala Destino', type: 'dropdown', dataSource: 'salas', required: false },
                { name: 'p_id_empleado_destino', label: 'Empleado Responsable', type: 'dropdown', dataSource: 'empleados', required: false },
                { name: 'p_tipo_adq_destino', label: 'Tipo de Adquisición', type: 'dropdown', dataSource: 'tiposAdquisicion', required: false },
                { name: 'p_destacada_destino', label: '¿Es Destacada?', type: 'select', required: false, options: ['SI', 'NO'] },
                { name: 'p_orden_recorrido_destino', label: 'Orden de Recorrido', type: 'number', required: false },
                { name: 'p_valor_monetario_destino', label: 'Valor Monetario', type: 'number', required: false }
            ],
            outputParams: []
        },
        
        // === GESTIÓN DE EXPOSICIONES ===
        'SP_FINALIZAR_EXPOSICION': {
            name: 'SP_FINALIZAR_EXPOSICION',
            description: 'Finalizar una exposición temporal',
            category: 'Gestión de Exposiciones',
            inputParams: [
                { name: 'p_id_expo', label: 'Exposición', type: 'dropdown', dataSource: 'exposiciones', required: true },
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true }
            ],
            outputParams: []
        },
        'SP_ASIGNAR_OBRA_A_EXPOSICION': {
            name: 'SP_ASIGNAR_OBRA_A_EXPOSICION',
            description: 'Asignar una obra a una exposición temporal',
            category: 'Gestión de Exposiciones',
            inputParams: [
                { name: 'p_id_obra', label: 'Obra', type: 'dropdown', dataSource: 'obras', required: true },
                { name: 'p_id_expo', label: 'Exposición', type: 'dropdown', dataSource: 'exposiciones', required: true },
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true },
                { name: 'p_orden_en_exposicion', label: 'Orden en la Exposición', type: 'number', required: false }
            ],
            outputParams: []
        },
        
        // === GESTIÓN DE COLECCIONES ===
        'SP_INSERTAR_COLECCION': {
            name: 'SP_INSERTAR_COLECCION',
            description: 'Crear una nueva colección permanente',
            category: 'Gestión de Colecciones',
            inputParams: [
                { name: 'n_nombre_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', displayField: 'nombre', required: true },
                { name: 'n_nombre_depto', label: 'Departamento', type: 'dropdown', dataSource: 'departamentos', required: true },
                { name: 'n_nombre_coleccion', label: 'Nombre de la Colección', type: 'text', required: true },
                { name: 'n_caracteristicas', label: 'Características', type: 'text', required: true },
                { name: 'n_palabra_clave', label: 'Palabra Clave', type: 'text', required: true },
                { name: 'n_orden_recorrido', label: 'Orden de Recorrido', type: 'number', required: true }
            ],
            outputParams: []
        },
        'SP_MODIFICAR_ORDEN_COLECCION': {
            name: 'SP_MODIFICAR_ORDEN_COLECCION',
            description: 'Modificar el orden de recorrido de una colección',
            category: 'Gestión de Colecciones',
            inputParams: [
                { name: 'n_id_coleccion', label: 'Colección', type: 'dropdown', dataSource: 'colecciones', required: true },
                { name: 'n_orden_recorrido', label: 'Nuevo Orden de Recorrido', type: 'number', required: true }
            ],
            outputParams: []
        },
        'SP_ELIMINAR_COLECCION': {
            name: 'SP_ELIMINAR_COLECCION',
            description: 'Eliminar una colección permanente',
            category: 'Gestión de Colecciones',
            inputParams: [
                { name: 'p_id_coleccion', label: 'Colección', type: 'dropdown', dataSource: 'colecciones', required: true }
            ],
            outputParams: []
        },
        
        // === MANTENIMIENTO ===
        'SP_REGISTRAR_MANTENIMIENTO_OBRA': {
            name: 'SP_REGISTRAR_MANTENIMIENTO_OBRA',
            description: 'Registrar un mantenimiento realizado a una obra',
            category: 'Mantenimiento',
            inputParams: [
                { name: 'n_id_mant', label: 'Mantenimiento Programado', type: 'dropdown', dataSource: 'mantenimientos', displayField: 'tipo', required: true },
                { name: 'n_id_empleado', label: 'Empleado Responsable', type: 'dropdown', dataSource: 'empleados', required: true },
                { name: 'n_observaciones', label: 'Observaciones', type: 'text', required: true },
                { name: 'n_fecha_fin', label: 'Fecha de Finalización', type: 'date', required: false }
            ],
            outputParams: []
        },
        'SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO': {
            name: 'SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO',
            description: 'Programar mantenimientos automáticos para un museo',
            category: 'Mantenimiento',
            inputParams: [
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: false },
                { name: 'p_dias_anticipacion', label: 'Días de Anticipación', type: 'number', required: false }
            ],
            outputParams: [
                { name: 'p_registros_procesados', label: 'Registros Procesados', type: 'number' }
            ]
        },
        'SP_REGISTRAR_CIERRE_TEMPORAL': {
            name: 'SP_REGISTRAR_CIERRE_TEMPORAL',
            description: 'Registrar el cierre temporal de una sala',
            category: 'Mantenimiento',
            inputParams: [
                { name: 'n_fecha_inicio', label: 'Fecha de Inicio', type: 'date', required: false },
                { name: 'n_id_sala', label: 'Sala', type: 'dropdown', dataSource: 'salas', required: true },
                { name: 'n_fecha_fin', label: 'Fecha de Fin', type: 'date', required: false }
            ],
            outputParams: []
        },
        
        // === GESTIÓN DE VIGILANCIA ===
        'SP_REGISTRAR_VIGILANTE_MANT': {
            name: 'SP_REGISTRAR_VIGILANTE_MANT',
            description: 'Registrar un nuevo vigilante de mantenimiento',
            category: 'Vigilancia y Seguridad',
            inputParams: [
                { name: 'n_nombre', label: 'Nombre', type: 'text', required: true },
                { name: 'n_apellido', label: 'Apellido', type: 'text', required: true },
                { name: 'n_doc_identidad', label: 'Documento de Identidad', type: 'number', required: true },
                { name: 'n_tipo_responsable', label: 'Tipo de Responsable', type: 'dropdown', dataSource: 'tiposResponsable', required: true },
                { name: 'n_id_est', label: 'Estructura Física', type: 'dropdown', dataSource: 'estructurasFisicas', required: true },
                { name: 'n_turno', label: 'Turno', type: 'dropdown', dataSource: 'turnos', required: true }
            ],
            outputParams: []
        },
        'SP_ASIGNAR_VIGILANTE_MANT': {
            name: 'SP_ASIGNAR_VIGILANTE_MANT',
            description: 'Asignar un vigilante existente a una nueva área',
            category: 'Vigilancia y Seguridad',
            inputParams: [
                { name: 'n_id_vig_mant', label: 'Vigilante', type: 'dropdown', dataSource: 'vigilantes', required: true },
                { name: 'n_id_est', label: 'Estructura Física', type: 'dropdown', dataSource: 'estructurasFisicas', required: true },
                { name: 'n_turno', label: 'Turno', type: 'dropdown', dataSource: 'turnos', required: true }
            ],
            outputParams: []
        },
        
        // === ANÁLISIS Y RANKING ===
        'SP_CALCULAR_RANKING_MUSEO': {
            name: 'SP_CALCULAR_RANKING_MUSEO',
            description: 'Calcular métricas y ranking de un museo',
            category: 'Análisis y Reporting',
            inputParams: [
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: true }
            ],
            outputParams: [
                { name: 'p_antiguedad_promedio_anios', label: 'Antigüedad Promedio (años)', type: 'number' },
                { name: 'p_tasa_rotacion_alta_pct', label: 'Tasa de Rotación Alta (%)', type: 'number' },
                { name: 'p_visitas_ultimo_anio', label: 'Visitas Último Año', type: 'number' },
                { name: 'p_categoria_ranking', label: 'Categoría del Ranking', type: 'text' }
            ]
        },
        
        // === AUTOMATIZACIÓN Y GESTIÓN DIARIA ===
        'SP_GESTIONAR_ESTADO_EXPOSICIONES': {
            name: 'SP_GESTIONAR_ESTADO_EXPOSICIONES',
            description: 'Gestionar automáticamente el estado de las exposiciones',
            category: 'Automatización',
            inputParams: [
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: false },
                { name: 'p_accion_automatica', label: 'Acción Automática', type: 'select', required: false, options: ['REPORTE', 'FINALIZAR', 'ALERTAR'] }
            ],
            outputParams: [
                { name: 'p_registros_procesados', label: 'Registros Procesados', type: 'number' }
            ]
        },
        'SP_CONSOLIDAR_OPERACIONES_DIARIAS': {
            name: 'SP_CONSOLIDAR_OPERACIONES_DIARIAS',
            description: 'Consolidar todas las operaciones diarias del museo',
            category: 'Automatización',
            inputParams: [
                { name: 'p_id_museo', label: 'Museo', type: 'dropdown', dataSource: 'museos', required: false },
                { name: 'p_ejecutar_acciones', label: 'Ejecutar Acciones', type: 'select', required: false, options: ['SI', 'NO'] }
            ],
            outputParams: [
                { name: 'p_resumen_operaciones', label: 'Resumen de Operaciones', type: 'text' }
            ]
        }
    };
    
    res.json(procedures);
});

// Endpoint para obtener datos de apoyo (museos, empleados, etc.) - VERSIÓN ULTRA ROBUSTA
app.get('/api/support-data', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        
        console.log('[SUPPORT-DATA] Iniciando carga de datos de apoyo...');
        console.log(`[SUPPORT-DATA] Esquema: ${dbConfig.schema}`);
        
        // === FUNCIÓN AUXILIAR PARA EJECUTAR CONSULTAS SEGURAS ===
        const safeExecute = async (query, label) => {
            try {
                console.log(`[SUPPORT-DATA] Ejecutando ${label}...`);
                const result = await connection.execute(query);
                console.log(`[SUPPORT-DATA] ${label}: ✅ ${result.rows.length} registros`);
                return result;
            } catch (err) {
                console.error(`[SUPPORT-DATA] ${label}: ❌ ${err.message}`);
                return { rows: [] }; // Retornar resultado vacío en caso de error
            }
        };
        
        // === VERIFICAR TABLAS EXISTENTES PRIMERO ===
        const checkTables = async () => {
            try {
                const tablesResult = await connection.execute(
                    `SELECT table_name FROM all_tables WHERE owner = '${dbConfig.schema}' ORDER BY table_name`
                );
                const existingTables = tablesResult.rows.map(row => row[0]);
                console.log(`[SUPPORT-DATA] Tablas disponibles (${existingTables.length}):`, existingTables.slice(0, 10));
                return existingTables;
            } catch (err) {
                console.error(`[SUPPORT-DATA] Error verificando tablas:`, err.message);
                return [];
            }
        };
        
        const existingTables = await checkTables();
        
        // === ENTIDADES PRINCIPALES CON IDs (SOLO TABLAS BÁSICAS) ===
        
        // Obtener museos (tabla principal - debe existir)
        const museosResult = await safeExecute(
            `SELECT id_museo, nombre FROM ${dbConfig.schema}.MUSEOS ORDER BY nombre`,
            'MUSEOS'
        );
        
        // Obtener empleados (solo tabla base, sin joins complejos)
        const empleadosResult = existingTables.includes('EMPLEADOS_PROFESIONALES') ? 
            await safeExecute(
                `SELECT id_empleado, 
                        primer_nombre || ' ' || primer_apellido as nombre_completo
                 FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES 
                 ORDER BY primer_apellido, primer_nombre`,
                'EMPLEADOS_PROFESIONALES'
            ) : { rows: [] };
        
        // Obtener obras (solo tabla base)
        const obrasResult = existingTables.includes('OBRAS') ? 
            await safeExecute(
                `SELECT id_obra, nombre as titulo, tipo_obra
                 FROM ${dbConfig.schema}.OBRAS 
                 ORDER BY nombre`,
                'OBRAS'
            ) : { rows: [] };
        
        // Obtener colecciones permanentes
        const coleccionesResult = existingTables.includes('COLECCIONES_PERMANENTES') ?
            await safeExecute(
                `SELECT id_coleccion, nombre, id_museo, nombre_depto 
                 FROM ${dbConfig.schema}.COLECCIONES_PERMANENTES 
                 ORDER BY nombre`,
                'COLECCIONES_PERMANENTES'
            ) : { rows: [] };
        
        // Obtener salas de exposición (sin join complejo)
        const salasResult = existingTables.includes('SALAS_EXP') ?
            await safeExecute(
                `SELECT id_sala, nombre, id_museo
                 FROM ${dbConfig.schema}.SALAS_EXP 
                 ORDER BY nombre`,
                'SALAS_EXP'
            ) : { rows: [] };
        
        // Obtener exposiciones
        const exposicionesResult = existingTables.includes('EXPOSICIONES_EVENTOS') ?
            await safeExecute(
                `SELECT id_expo, nombre as titulo, id_museo, fecha_inicio, fecha_fin
                 FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS 
                 ORDER BY fecha_inicio DESC`,
                'EXPOSICIONES_EVENTOS'
            ) : { rows: [] };

        // Obtener unidades organizacionales
        const unidadesOrgResult = existingTables.includes('EST_ORGANIZACIONAL') ?
            await safeExecute(
                `SELECT id_est_org, nombre, id_museo, tipo, nivel 
                 FROM ${dbConfig.schema}.EST_ORGANIZACIONAL 
                 ORDER BY nivel, nombre`,
                'EST_ORGANIZACIONAL'
            ) : { rows: [] };

        // Obtener estructuras físicas
        const estructurasFisicasResult = existingTables.includes('EST_FISICA') ?
            await safeExecute(
                `SELECT id_est, nombre, id_museo, tipo, descripcion 
                 FROM ${dbConfig.schema}.EST_FISICA 
                 ORDER BY tipo, nombre`,
                'EST_FISICA'
            ) : { rows: [] };

        // Obtener artistas
        const artistasResult = existingTables.includes('ARTISTAS') ?
            await safeExecute(
                `SELECT id_artista, 
                        primer_nombre || ' ' || primer_apellido as nombre_completo
                 FROM ${dbConfig.schema}.ARTISTAS 
                 ORDER BY primer_apellido, primer_nombre`,
                'ARTISTAS'
            ) : { rows: [] };
        
        // === CONSULTAS COMPLEJAS SIMPLIFICADAS ===
        
        // Mantenimientos (solo si existe PROGRAMAS_MANT)
        const mantenimientosResult = existingTables.includes('PROGRAMAS_MANT') ?
            await safeExecute(
                `SELECT id_mant, actividad as descripcion, tipo_responsable
                 FROM ${dbConfig.schema}.PROGRAMAS_MANT 
                 ORDER BY actividad`,
                'PROGRAMAS_MANT'
            ) : { rows: [] };

        // Vigilantes (solo si existe)
        const vigilantesResult = existingTables.includes('EMPLEADOS_VIGILANTE_MANT') ?
            await safeExecute(
                `SELECT id_vig_mant, 
                        nombre || ' ' || apellido as nombre_completo,
                        tipo_responsable
                 FROM ${dbConfig.schema}.EMPLEADOS_VIGILANTE_MANT 
                 ORDER BY nombre, apellido`,
                'EMPLEADOS_VIGILANTE_MANT'
            ) : { rows: [] };

        // === LISTAS DE VALORES ÚNICOS PARA DROPDOWNS (SIMPLIFICADAS) ===
        
        // Departamentos (solo si existe COLECCIONES_PERMANENTES)
        const departamentosResult = existingTables.includes('COLECCIONES_PERMANENTES') ?
            await safeExecute(
                `SELECT DISTINCT nombre_depto 
                 FROM ${dbConfig.schema}.COLECCIONES_PERMANENTES 
                 WHERE nombre_depto IS NOT NULL 
                 ORDER BY nombre_depto`,
                'DEPARTAMENTOS'
            ) : { rows: [] };

        // Tipos de obras (solo si existe OBRAS)
        const tiposObraResult = existingTables.includes('OBRAS') ?
            await safeExecute(
                `SELECT DISTINCT tipo_obra 
                 FROM ${dbConfig.schema}.OBRAS 
                 WHERE tipo_obra IS NOT NULL 
                 ORDER BY tipo_obra`,
                'TIPOS_OBRA'
            ) : { rows: [] };

        // Cargos - usando lista predefinida si no existe tabla
        const cargosResult = existingTables.includes('HIST_EMPLEADOS') ?
            await safeExecute(
                `SELECT DISTINCT cargo 
                 FROM ${dbConfig.schema}.HIST_EMPLEADOS 
                 WHERE cargo IS NOT NULL 
                 ORDER BY cargo`,
                'CARGOS'
            ) : { rows: [['DIRECTOR'], ['SUBDIRECTOR'], ['CURADOR'], ['RESTAURADOR'], ['CONSERVADOR'], ['GUÍA']] };

        // Tipos de tickets - usando lista predefinida si no existe tabla
        const tiposTicketResult = existingTables.includes('TIPO_TICKETS') ?
            await safeExecute(
                `SELECT DISTINCT tipo 
                 FROM ${dbConfig.schema}.TIPO_TICKETS 
                 WHERE tipo IS NOT NULL 
                 ORDER BY tipo`,
                'TIPOS_TICKET'
            ) : { rows: [['ADULTO'], ['ESTUDIANTE'], ['NIÑO'], ['TERCERA_EDAD'], ['GRUPO']] };
        
        // === LISTAS PREDEFINIDAS PARA DROPDOWNS BÁSICOS ===
        const tiposAdquisicionResult = { rows: [['COMPRA'], ['DONACIÓN'], ['PRÉSTAMO'], ['INTERCAMBIO']] };
        const tiposResponsableResult = { rows: [['VIGILANTE'], ['MANTENIMIENTO'], ['SEGURIDAD']] };
        const turnosResult = { rows: [['MAÑANA'], ['TARDE'], ['NOCHE'], ['ROTATIVO']] };
        const tiposMantenimientoResult = { rows: [['PREVENTIVO'], ['CORRECTIVO'], ['RESTAURACIÓN'], ['CONSERVACIÓN']] };
        
        // === CONSTRUCCIÓN DEL OBJETO DE RESPUESTA ===
        const supportData = {
            // === ENTIDADES PRINCIPALES CON IDs (para dropdowns con objetos) ===
            museos: museosResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1] 
            })),
            
            empleados: empleadosResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1]
            })),
            
            obras: obrasResult.rows.map(row => ({ 
                id: row[0], 
                titulo: row[1], 
                tipo_obra: row[2]
            })),
            
            colecciones: coleccionesResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1], 
                id_museo: row[2],
                departamento: row[3]
            })),
            
            salas: salasResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1], 
                id_museo: row[2]
            })),
            
            exposiciones: exposicionesResult.rows.map(row => ({ 
                id: row[0], 
                titulo: row[1], 
                id_museo: row[2],
                fecha_inicio: row[3],
                fecha_fin: row[4]
            })),
            
            unidadesOrganizacionales: unidadesOrgResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1], 
                id_museo: row[2],
                tipo: row[3],
                nivel: row[4]
            })),
            
            estructurasFisicas: estructurasFisicasResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1], 
                id_museo: row[2],
                tipo: row[3],
                descripcion: row[4]
            })),
            
            mantenimientos: mantenimientosResult.rows.map(row => ({ 
                id: row[0], 
                descripcion: row[1],
                obra: row[2],
                tipo_responsable: row[3]
            })),
            
            vigilantes: vigilantesResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1],
                tipo_responsable: row[2]
            })),
            
            artistas: artistasResult.rows.map(row => ({ 
                id: row[0], 
                nombre: row[1]
            })),
            
            // === LISTAS DE VALORES ÚNICOS (para dropdowns simples) ===
            departamentos: departamentosResult.rows.map(row => row[0]),
            tiposObra: tiposObraResult.rows.map(row => row[0]),
            tiposAdquisicion: tiposAdquisicionResult.rows.map(row => row[0]),
            cargos: cargosResult.rows.map(row => row[0]),
            tiposResponsable: tiposResponsableResult.rows.map(row => row[0]),
            turnos: turnosResult.rows.map(row => row[0]),
            tiposMantenimiento: tiposMantenimientoResult.rows.map(row => row[0]),
            tiposTicket: tiposTicketResult.rows.map(row => row[0])
        };
        
        // === RESUMEN DE CARGA ===
        const summary = {
            museos: supportData.museos.length,
            empleados: supportData.empleados.length,
            obras: supportData.obras.length,
            colecciones: supportData.colecciones.length,
            salas: supportData.salas.length,
            exposiciones: supportData.exposiciones.length,
            unidadesOrganizacionales: supportData.unidadesOrganizacionales.length,
            estructurasFisicas: supportData.estructurasFisicas.length,
            mantenimientos: supportData.mantenimientos.length,
            vigilantes: supportData.vigilantes.length,
            artistas: supportData.artistas.length
        };
        
        console.log('[SUPPORT-DATA] ✅ Datos cargados exitosamente');
        console.log('[SUPPORT-DATA] 📊 Resumen:', summary);
        console.log(`[SUPPORT-DATA] 📁 Total de fuentes de datos: ${Object.keys(supportData).length}`);
        
        res.json(supportData);
        
    } catch (err) {
        console.error('[SUPPORT-DATA] Error:', err);
        res.status(500).json({ message: 'Error obteniendo datos de apoyo', error: err.message });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error('[SUPPORT-DATA] Error cerrando conexión:', err);
            }
        }
    }
}); 

// === ENDPOINT DE DEBUG SIMPLE PARA DROPDOWNS ===
app.get('/api/debug/simple-data', async (req, res) => {
    let connection;
    try {
        console.log('[DEBUG-SIMPLE] Iniciando verificación simple...');
        connection = await oracledb.getConnection(dbConfig);
        console.log('[DEBUG-SIMPLE] Conexión exitosa');
        
        // Test simple: obtener museos (tabla principal)
        let museosResult;
        try {
            museosResult = await connection.execute(
                `SELECT id_museo, nombre FROM ${dbConfig.schema}.MUSEOS ORDER BY nombre`
            );
            console.log(`[DEBUG-SIMPLE] Museos encontrados: ${museosResult.rows.length}`);
        } catch (err) {
            console.log(`[DEBUG-SIMPLE] Error en MUSEOS: ${err.message}`);
            museosResult = { rows: [] };
        }
        
        // Test de tabla básica
        let tablesResult;
        try {
            tablesResult = await connection.execute(
                `SELECT table_name FROM all_tables WHERE owner = '${dbConfig.schema}' ORDER BY table_name`
            );
            console.log(`[DEBUG-SIMPLE] Tablas en esquema: ${tablesResult.rows.length}`);
        } catch (err) {
            console.log(`[DEBUG-SIMPLE] Error listando tablas: ${err.message}`);
            tablesResult = { rows: [] };
        }
        
        // Respuesta simplificada
        const debugData = {
            schema: dbConfig.schema,
            connection_status: 'OK',
            museos_count: museosResult.rows.length,
            museos_sample: museosResult.rows.slice(0, 3).map(row => ({ id: row[0], nombre: row[1] })),
            tables_count: tablesResult.rows.length,
            tables_sample: tablesResult.rows.slice(0, 10).map(row => row[0]),
            timestamp: new Date().toISOString()
        };
        
        console.log('[DEBUG-SIMPLE] Respuesta:', JSON.stringify(debugData, null, 2));
        res.json(debugData);
        
    } catch (err) {
        console.error('[DEBUG-SIMPLE] Error general:', err);
        res.status(500).json({ 
            error: 'Error de conexión o configuración',
            message: err.message,
            schema: dbConfig.schema,
            timestamp: new Date().toISOString()
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error('[DEBUG-SIMPLE] Error cerrando conexión:', err);
            }
        }
    }
});

// === ENDPOINT SIMPLE SOLO PARA MUSEOS (PARA TESTING RÁPIDO) ===
app.get('/api/museos-simple', async (req, res) => {
    let connection;
    try {
        console.log('[MUSEOS-SIMPLE] Iniciando...');
        connection = await oracledb.getConnection(dbConfig);
        console.log('[MUSEOS-SIMPLE] Conexión exitosa');
        
        const result = await connection.execute(
            `SELECT id_museo, nombre FROM ${dbConfig.schema}.MUSEOS ORDER BY nombre`
        );
        
        const museos = result.rows.map(row => ({
            id: row[0],
            nombre: row[1]
        }));
        
        console.log(`[MUSEOS-SIMPLE] Devolviendo ${museos.length} museos`);
        res.json({
            success: true,
            count: museos.length,
            data: museos
        });
        
    } catch (err) {
        console.error('[MUSEOS-SIMPLE] Error:', err);
        res.status(500).json({
            success: false,
            error: err.message,
            schema: dbConfig.schema
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error('[MUSEOS-SIMPLE] Error cerrando conexión:', err);
            }
        }
    }
});

// Endpoint para obtener datos de apoyo (museos, empleados, etc.)