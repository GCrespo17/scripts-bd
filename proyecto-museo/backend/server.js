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

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor backend corriendo en el puerto ${PORT}`)); 