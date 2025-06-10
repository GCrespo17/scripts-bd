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

    try {
        connection = await oracledb.getConnection(dbConfig);

        // 1. Obtener todas las unidades organizacionales del museo
        const orgUnitsPromise = connection.execute(
            `SELECT id_est_org, nombre, tipo, nivel, descripcion, id_est_org_padre 
             FROM ${dbConfig.schema}.EST_ORGANIZACIONAL 
             WHERE id_museo = :id_museo`,
            [id_museo]
        );

        // 2. Obtener todos los empleados actualmente asignados en ese museo
        const empleadosPromise = connection.execute(
            `SELECT
                he.id_est_org,
                ep.id_empleado,
                ep.primer_nombre,
                ep.primer_apellido,
                he.cargo
             FROM ${dbConfig.schema}.HIST_EMPLEADOS he
             JOIN ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
             WHERE he.id_museo = :id_museo AND he.fecha_fin IS NULL`,
            [id_museo]
        );

        const [orgUnitsResult, empleadosResult] = await Promise.all([orgUnitsPromise, empleadosPromise]);

        // Mapear empleados a su unidad organizacional
        const empleadosPorUnidad = {};
        empleadosResult.rows.forEach(row => {
            const id_est_org = row[0];
            if (!empleadosPorUnidad[id_est_org]) {
                empleadosPorUnidad[id_est_org] = [];
            }
            empleadosPorUnidad[id_est_org].push({
                id_empleado: row[1],
                nombre: `${row[2]} ${row[3]}`,
                cargo: row[4]
            });
        });

        // Construir la lista de nodos del árbol
        const list = orgUnitsResult.rows.map(row => ({
            id: row[0],
            nombre: row[1],
            tipo: row[2],
            nivel: row[3],
            descripcion: row[4],
            padre_id: row[5],
            empleados: empleadosPorUnidad[row[0]] || [], // Añadir empleados
            children: []
        }));

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




//Endpoint para obtener la lista de curadores
app.get('/api/empleados/curadores/:id_museo', async (req, res)=>{
    let connection;
    try{
        const idMuseo = req.params.id_museo;
        connection = await oracledb.getConnection(dbConfig);

        const query = 
        `SELECT ep.id_empleado, ep.primer_nombre, ep.primer_apellido, ep.doc_identidad, he.cargo
            FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
            JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON he.id_empleado_prof = ep.id_empleado
            WHERE
                he.id_museo = :idMuseo 
                AND he.cargo = 'CURADOR'
                AND he.fecha_fin IS NULL
        `;

        const result = await connection.execute(
            query,
            {idMuseo: idMuseo}
        );

        const empleados = result.rows.map(row => ({
            id: row[0],
            nombre: `${row[1]} ${row[2]}`,
            doc_identidad: row[3],
            cargo: row[4]
        }));
        res.json(empleados);
    }catch(err){
        console.error('Error al obtener empleados: ', err);
        res.status(500).json({message: 'Error al obtener a los curadores'});
    }finally{
         if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

//Endpoint para obtener la lista de restauradores
app.get('/api/empleados/restauradores/:id_museo', async (req, res)=>{
    let connection;
    try{
        const idMuseo = req.params.id_museo;
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT ep.id_empleado, ep.primer_nombre, ep.primer_apellido, ep.doc_identidad, he.cargo
            FROM ${dbConfig.schema}.EMPLEADOS_PROFESIONALES ep
            JOIN ${dbConfig.schema}.HIST_EMPLEADOS he ON he.id_empleado_prof = ep.id_empleado
            WHERE
            he.id_museo = :idMuseo AND
            he.cargo = 'RESTAURADOR' AND 
            he.fecha_fin IS NULL`,
            {idMuseo: idMuseo}
        );
        const empleados=result.rows.map(row=>({
            id: row[0],
            nombre: `${row[1]} ${row[2]}`,
            doc_identidad: row[3],
            cargo: row[4]
        }));
        res.json(empleados);
    }catch(err){
        console.error('Error al obtener empleados: ', err);
        res.status(500).json({message: 'Error al obtener a los restauradores'});
    }finally{
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

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor backend corriendo en el puerto ${PORT}`)); 