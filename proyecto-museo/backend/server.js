const express = require('express');
const cors = require('cors');
const oracledb = require('oracledb');

const app = express();
app.use(cors()); // Habilita CORS
app.use(express.json()); // Permite al servidor entender JSON

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

// Endpoint para registrar un artista (Corregido)
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
        id_lugar 
    } = req.body;
    
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        // Preparar la consulta SQL con los campos correctos
        const sql = `
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
            )
        `;
        
        // Preparar los parámetros
        const params = {
            primer_nombre: primer_nombre || null,
            segundo_nombre: segundo_nombre || null,
            primer_apellido: primer_apellido || null,
            segundo_apellido: segundo_apellido || null,
            fecha_nacimiento: fecha_nacimiento ? new Date(fecha_nacimiento) : null,
            fecha_difuncion: fecha_difuncion ? new Date(fecha_difuncion) : null,
            apodo: apodo || null,
            resumen_caracteristicas: resumen_caracteristicas,
            id_lugar: id_lugar || null
        };
        
        await connection.execute(sql, params, { autoCommit: true });
        res.status(201).json({ message: 'Artista registrado exitosamente' });
        
    } catch (err) {
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
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT id_museo, nombre FROM ${dbConfig.schema}.MUSEOS ORDER BY nombre ASC`
        );
        
        const museos = result.rows.map(row => ({
            id: row[0],
            nombre: row[1]
        }));
        
        res.json(museos);
    } catch (err) {
        console.error('Error al obtener museos:', err);
        res.status(500).json({ message: 'Error al obtener museos' });
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

// Endpoint para registrar un nuevo programa de mantenimiento
app.post('/api/programas-mant', async (req, res) => {
    const {
        id_catalogo,
        id_obra,
        actividad,
        frecuencia,
        tipo_responsable
    } = req.body;
    
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const sql = `
            INSERT INTO ${dbConfig.schema}.PROGRAMAS_MANT (
                id_catalogo, id_obra, actividad, frecuencia, tipo_responsable
            ) VALUES (
                :id_catalogo, :id_obra, :actividad, :frecuencia, :tipo_responsable
            )
        `;
        
        const params = {
            id_catalogo,
            id_obra,
            actividad,
            frecuencia,
            tipo_responsable
        };
        
        await connection.execute(sql, params, { autoCommit: true });
        res.status(201).json({ message: 'Programa de mantenimiento registrado exitosamente' });
        
    } catch (err) {
        console.error('Error al registrar programa de mantenimiento:', err);
        res.status(500).json({ 
            message: 'Error al registrar el programa de mantenimiento',
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
    let connection;

    console.log(`\n🔍 CONSULTANDO ORGANIGRAMA PARA MUSEO ID: ${id_museo}`);

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Obtener todas las unidades organizacionales del museo
        const orgUnitsPromise = connection.execute(
            `SELECT id_est_org, nombre, tipo, nivel, descripcion, id_est_org_padre 
             FROM ${dbConfig.schema}.EST_ORGANIZACIONAL 
             WHERE id_museo = :id_museo
             ORDER BY nivel ASC, nombre ASC`,
            [id_museo]
        );

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
            
            const esJefe = row[6] && (
                row[6].toLowerCase().includes('director') ||
                row[6].toLowerCase().includes('jefe') ||
                row[6].toLowerCase().includes('coordinador') ||
                row[6].toLowerCase().includes('responsable') ||
                row[6].toLowerCase().includes('gerente') ||
                row[6].toLowerCase().includes('administrador') ||
                row[6].toLowerCase().includes('curador') ||
                row[6].toLowerCase().includes('superintendente') ||
                row[6].toLowerCase().includes('supervisor')
            );
            
            empleadosPorUnidad[id_est_org].push({
                id_empleado: row[1],
                nombre_completo: nombreCompleto,
                cargo: row[6],
                fecha_inicio: row[7],
                doc_identidad: row[8],
                // Determinar si es jefe/director de la unidad
                es_jefe: esJefe
            });
            
            // DEBUG: Mostrar clasificación
            console.log(`  -> ${nombreCompleto} en unidad ${id_est_org}: ${esJefe ? 'JEFE' : 'PERSONAL'}`);
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
            
            const nodo = {
                id: row[0],
                nombre: row[1],
                tipo: row[2],
                nivel: row[3],
                descripcion: row[4],
                padre_id: row[5],
                jefes: jefes,
                personal: personal,
                total_empleados: empleados.length,
                children: []
            };
            
            // DEBUG: Mostrar cada nodo creado
            console.log(`\nNodo creado: ${nodo.nombre} (ID: ${nodo.id})`);
            console.log(`  - Jefes: ${nodo.jefes.length}, Personal: ${nodo.personal.length}, Total: ${nodo.total_empleados}`);
            
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

// Endpoint para obtener la ficha detallada de un museo (OPTIMIZADO con SP para Ranking)
app.get('/api/museos/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // --- Consultas en Paralelo ---
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
        const coleccionesPromise = connection.execute(
            `SELECT id_coleccion, nombre, caracteristicas, palabra_clave 
             FROM ${dbConfig.schema}.COLECCIONES_PERMANENTES 
             WHERE id_museo = :id 
             ORDER BY orden_recorrido ASC`,
            [id_museo]
        );

        // --- Llamada al Stored Procedure para el Ranking ---
        const rankingPromise = connection.execute(
            `BEGIN ${dbConfig.schema}.SP_CALCULAR_RANKING_MUSEO(:id, :antiguedad, :tasa, :visitas, :categoria); END;`,
            {
                id: id_museo,
                antiguedad: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT },
                tasa: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT },
                visitas: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT },
                categoria: { type: oracledb.STRING, dir: oracledb.BIND_OUT, maxSize: 100 }
            }
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

        // --- Ensamblaje de la Respuesta ---
        const museoData = {
            id: museoResult.rows[0][0],
            nombre: museoResult.rows[0][1],
            fecha_fundacion: museoResult.rows[0][2],
            mision: museoResult.rows[0][3],
            ranking: {
                antiguedad_promedio_anios: parseFloat((rankingResult.outBinds.antiguedad[0] || 0).toFixed(2)),
                tasa_rotacion_alta_pct: parseFloat((rankingResult.outBinds.tasa[0] || 0).toFixed(2)),
                visitas_ultimo_anio: rankingResult.outBinds.visitas[0] || 0,
                categoria: rankingResult.outBinds.categoria[0]
            },
            historia: historiaResult.rows.map(r => ({ anio: r[0], hecho: r[1] })),
            colecciones: coleccionesResult.rows.map(r => ({
                id: r[0],
                nombre: r[1],
                caracteristicas: r[2],
                palabra_clave: r[3]
            }))
        };
        
        res.json(museoData);

    } catch (err) {
        console.error(`Error al obtener la ficha del museo ${id_museo}:`, err);
        res.status(500).json({ message: 'Error al obtener la ficha del museo' });
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

        // 4. Historial laboral
        const historialPromise = connection.execute(
            `SELECT h.fecha_inicio, h.fecha_fin, h.cargo, e.nombre as unidad_organizativa, m.nombre as museo
             FROM ${dbConfig.schema}.HIST_EMPLEADOS h
             JOIN ${dbConfig.schema}.EST_ORGANIZACIONAL e ON h.id_est_org = e.id_est_org
             JOIN ${dbConfig.schema}.MUSEOS m ON h.id_museo = m.id_museo
             WHERE h.id_empleado_prof = :id
             ORDER BY h.fecha_inicio DESC`,
            [id_empleado]
        );

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
app.post('/api/tickets', async (req, res) => {
    // El id_num_ticket y el precio se calcularán con triggers en la BD.
    const { id_museo, tipo } = req.body;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);
        
        const sql = `
            INSERT INTO ${dbConfig.schema}.TICKETS (id_museo, tipo, fecha_hora_emision) 
            VALUES (:id_museo, :tipo, SYSDATE)
            RETURNING id_num_ticket, precio INTO :out_id, :out_precio
        `;

        const params = {
            id_museo: id_museo,
            tipo: tipo,
            out_id: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT },
            out_precio: { type: oracledb.NUMBER, dir: oracledb.BIND_OUT }
        };

        const result = await connection.execute(sql, params, { autoCommit: true });

        const nuevoTicket = {
            id_num_ticket: result.outBinds.out_id[0],
            id_museo: id_museo,
            tipo: tipo,
            precio: result.outBinds.out_precio[0]
        };

        res.status(201).json({ 
            message: 'Ticket vendido exitosamente',
            ticket: nuevoTicket 
        });
        
    } catch (err) {
        console.error('Error al vender ticket:', err);
        res.status(500).json({ 
            message: 'Error al vender el ticket',
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

// Endpoint para generar el reporte de estructura física
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
                ef.id_est_padre,
                COUNT(se.id_sala) as total_salas
             FROM ${dbConfig.schema}.EST_FISICA ef
             LEFT JOIN ${dbConfig.schema}.SALAS_EXP se ON ef.id_est = se.id_est AND ef.id_museo = se.id_museo
             WHERE ef.id_museo = :id
             GROUP BY ef.id_est, ef.nombre, ef.tipo, ef.descripcion, ef.direccion_edificio, ef.id_est_padre
             ORDER BY ef.tipo DESC, ef.nombre ASC`,
            [id_museo]
        );

        // 3. Salas de exposición con sus colecciones
        const salasColeccionesPromise = connection.execute(
            `SELECT 
                se.id_sala,
                se.nombre as nombre_sala,
                se.descripcion as desc_sala,
                se.id_est,
                cp.nombre as nombre_coleccion,
                cp.caracteristicas as caracteristicas_coleccion,
                sc.orden as orden_coleccion,
                COUNT(hom.id_obra) as total_obras
             FROM ${dbConfig.schema}.SALAS_EXP se
             LEFT JOIN ${dbConfig.schema}.SALAS_COLECCIONES sc ON se.id_sala = sc.id_sala 
                 AND se.id_est = sc.id_est_fisica AND se.id_museo = sc.id_museo
             LEFT JOIN ${dbConfig.schema}.COLECCIONES_PERMANENTES cp ON sc.id_coleccion = cp.id_coleccion 
                 AND sc.id_est_org = cp.id_est_org AND sc.id_museo = cp.id_museo
             LEFT JOIN ${dbConfig.schema}.HIST_OBRAS_MOV hom ON sc.id_coleccion = hom.id_coleccion 
                 AND hom.fecha_salida IS NULL
             WHERE se.id_museo = :id
             GROUP BY se.id_sala, se.nombre, se.descripcion, se.id_est, cp.nombre, cp.caracteristicas, sc.orden
             ORDER BY se.id_est, se.nombre, sc.orden`,
            [id_museo]
        );

        // 4. Exposiciones y eventos actuales/futuros
        const exposicionesPromise = connection.execute(
            `SELECT 
                ee.nombre as nombre_evento,
                ee.fecha_inicio,
                ee.fecha_fin,
                se.nombre as nombre_sala,
                se.id_est,
                ee.costo_persona,
                ee.cant_visitantes
             FROM ${dbConfig.schema}.EXPOSICIONES_EVENTOS ee
             JOIN ${dbConfig.schema}.SALAS_EXP se ON ee.id_sala = se.id_sala 
                 AND ee.id_est = se.id_est AND ee.id_museo = se.id_museo
             WHERE ee.id_museo = :id 
                 AND ee.fecha_fin >= SYSDATE
             ORDER BY ee.fecha_inicio ASC`,
            [id_museo]
        );

        const [museoResult, estructuraResult, salasResult, exposicionesResult] = await Promise.all([
            museoPromise,
            estructuraPromise,
            salasColeccionesPromise,
            exposicionesPromise
        ]);

        if (museoResult.rows.length === 0) {
            return res.status(404).json({ message: 'Museo no encontrado' });
        }

        // Procesar estructura física en formato jerárquico
        const estructura = estructuraResult.rows.map(row => ({
            id: row[0],
            nombre: row[1],
            tipo: row[2],
            descripcion: row[3],
            direccion: row[4],
            padre_id: row[5],
            total_salas: row[6],
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

        // Procesar salas y colecciones
        const salasPorEstructura = {};
        salasResult.rows.forEach(row => {
            const id_est = row[3];
            if (!salasPorEstructura[id_est]) {
                salasPorEstructura[id_est] = [];
            }
            
            const salaExistente = salasPorEstructura[id_est].find(s => s.id_sala === row[0]);
            if (salaExistente) {
                // Agregar colección a sala existente
                if (row[4]) { // nombre_coleccion
                    salaExistente.colecciones.push({
                        nombre: row[4],
                        caracteristicas: row[5],
                        orden: row[6],
                        total_obras: row[7]
                    });
                }
            } else {
                // Nueva sala
                const nuevaSala = {
                    id_sala: row[0],
                    nombre: row[1],
                    descripcion: row[2],
                    colecciones: []
                };
                
                if (row[4]) { // nombre_coleccion
                    nuevaSala.colecciones.push({
                        nombre: row[4],
                        caracteristicas: row[5],
                        orden: row[6],
                        total_obras: row[7]
                    });
                }
                
                salasPorEstructura[id_est].push(nuevaSala);
            }
        });

        // Asignar salas a elementos de estructura
        const asignarSalas = (nodos) => {
            nodos.forEach(nodo => {
                nodo.salas = salasPorEstructura[nodo.id] || [];
                if (nodo.children.length > 0) {
                    asignarSalas(nodo.children);
                }
            });
        };
        asignarSalas(roots);

        // Datos del reporte final
        const reporte = {
            museo: {
                nombre: museoResult.rows[0][0],
                fecha_fundacion: museoResult.rows[0][1],
                mision: museoResult.rows[0][2]
            },
            estructura_fisica: roots,
            exposiciones_actuales: exposicionesResult.rows.map(r => ({
                nombre: r[0],
                fecha_inicio: r[1],
                fecha_fin: r[2],
                sala: r[3],
                id_est: r[4],
                costo_persona: r[5],
                visitantes: r[6]
            })),
            resumen: {
                total_elementos: estructura.length,
                total_edificios: estructura.filter(e => e.tipo === 'EDIFICIO').length,
                total_pisos: estructura.filter(e => e.tipo === 'PISO').length,
                total_areas: estructura.filter(e => e.tipo === 'AREA').length,
                total_salas: Object.values(salasPorEstructura).flat().length,
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

// Endpoint para generar el reporte de estructura física
app.get('/api/reportes/estructura-fisica/:id_museo', async (req, res) => {
    const { id_museo } = req.params;
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Información básica del museo
        const museoResult = await connection.execute(
            `SELECT nombre, fecha_fundacion, mision FROM ${dbConfig.schema}.MUSEOS WHERE id_museo = :id`,
            [id_museo]
        );

        if (museoResult.rows.length === 0) {
            return res.status(404).json({ message: 'Museo no encontrado' });
        }

        const museo = {
            nombre: museoResult.rows[0][0],
            fecha_fundacion: museoResult.rows[0][1],
            mision: museoResult.rows[0][2]
        };

        // 2. Estructura física jerárquica con información detallada
        const estructuraResult = await connection.execute(
            `SELECT 
                ef.id_est, 
                ef.nombre, 
                ef.tipo, 
                ef.descripcion, 
                ef.direccion_edificio,
                ef.id_est_padre,
                CASE 
                    WHEN ef.tipo = 'AREA' THEN 
                        (SELECT COUNT(*) FROM ${dbConfig.schema}.COLECCIONES c WHERE c.id_est_fisica = ef.id_est)
                    ELSE 0
                END as total_colecciones,
                CASE 
                    WHEN ef.tipo = 'AREA' THEN 
                        (SELECT COUNT(*) FROM ${dbConfig.schema}.EVENTOS e WHERE e.id_est_fisica = ef.id_est AND e.fecha_fin >= SYSDATE)
                    ELSE 0
                END as exposiciones_activas
             FROM ${dbConfig.schema}.EST_FISICA ef 
             WHERE ef.id_museo = :id 
             ORDER BY ef.id_est_padre NULLS FIRST, ef.id_est`,
            [id_museo]
        );

        // 3. Resumen ejecutivo
        const resumenResult = await connection.execute(
            `SELECT 
                COUNT(CASE WHEN tipo = 'EDIFICIO' THEN 1 END) as total_edificios,
                COUNT(CASE WHEN tipo = 'PISO' THEN 1 END) as total_pisos,
                COUNT(CASE WHEN tipo = 'AREA' THEN 1 END) as total_areas,
                COUNT(CASE WHEN tipo = 'AREA' AND UPPER(nombre) LIKE '%SALA%' THEN 1 END) as total_salas
             FROM ${dbConfig.schema}.EST_FISICA 
             WHERE id_museo = :id`,
            [id_museo]
        );

        // 4. Exposiciones actuales
        const exposicionesResult = await connection.execute(
            `SELECT 
                e.nombre,
                ef.nombre as sala,
                e.fecha_inicio,
                e.fecha_fin,
                e.costo_persona,
                (SELECT COUNT(*) FROM ${dbConfig.schema}.VENTAS_EVENTO ve WHERE ve.id_evento = e.id_evento) as visitantes
             FROM ${dbConfig.schema}.EVENTOS e
             JOIN ${dbConfig.schema}.EST_FISICA ef ON e.id_est_fisica = ef.id_est
             WHERE ef.id_museo = :id 
             AND e.fecha_fin >= SYSDATE
             ORDER BY e.fecha_inicio`,
            [id_museo]
        );

        // Construir estructura jerárquica
        const estructuraFlat = estructuraResult.rows.map(row => ({
            id: row[0],
            nombre: row[1],
            tipo: row[2],
            descripcion: row[3],
            direccion_edificio: row[4],
            id_est_padre: row[5],
            total_colecciones: row[6],
            exposiciones_activas: row[7],
            children: []
        }));

        const buildTree = (items, parentId = null) => {
            return items
                .filter(item => item.id_est_padre === parentId)
                .map(item => ({
                    ...item,
                    children: buildTree(items, item.id)
                }));
        };

        const estructuraJerarquica = buildTree(estructuraFlat);

        // Preparar datos del reporte
        const reporteData = {
            museo,
            resumen: {
                total_edificios: resumenResult.rows[0][0],
                total_pisos: resumenResult.rows[0][1],
                total_areas: resumenResult.rows[0][2],
                total_salas: resumenResult.rows[0][3],
                total_exposiciones_activas: exposicionesResult.rows.length
            },
            estructura_fisica: estructuraJerarquica,
            exposiciones_actuales: exposicionesResult.rows.map(row => ({
                nombre: row[0],
                sala: row[1],
                fecha_inicio: row[2],
                fecha_fin: row[3],
                costo_persona: row[4],
                visitantes: row[5]
            }))
        };

        res.json(reporteData);

    } catch (error) {
        console.error('Error al generar reporte de estructura física:', error);
        res.status(500).json({ 
            message: 'Error interno del servidor',
            error: error.message 
        });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (closeErr) {
                console.error('Error al cerrar conexión:', closeErr);
            }
        }
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor backend corriendo en el puerto ${PORT}`)); 