# Sistema de Gestión de Museos de Arte

Este proyecto implementa un sistema integral de gestión para museos de arte, desarrollado con Vue.js (frontend), Express.js (backend) y Oracle Database XE.

## 🏗️ Arquitectura del Sistema

- **Frontend**: Vue.js con Vite
- **Backend**: Node.js con Express.js
- **Base de Datos**: Oracle Database XE 21c
- **Contenedores**: Docker y Docker Compose

## 📋 Requisitos Previos

- **[Docker](https://docs.docker.com/get-docker/)** y **[Docker Compose](https://docs.docker.com/compose/install/)** instalados
- Al menos 4GB de RAM disponible (Oracle XE requiere recursos considerables)
- Puertos 1525, 3000 y 5173 disponibles
- **[Git](https://git-scm.com/downloads)** para clonar el repositorio

### Herramientas recomendadas para desarrollo:
- **[Visual Studio Code](https://code.visualstudio.com/)** con extensiones de Vue.js y PL/SQL
- **[Oracle SQL Developer](https://www.oracle.com/database/sqldeveloper/)** o **[DBeaver](https://dbeaver.io/download/)** para gestión de base de datos
- **[Node.js](https://nodejs.org/)** (si planeas desarrollo local sin Docker)

### Github con interfaz grafica:
- **[GitHub Desktop](https://desktop.github.com/)** - Interfaz gráfica para Git (recomendado para usuarios sin experiencia en línea de comandos)
- **[GitHub Desktop Setup Guide](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/setting-up-github-desktop)** - Guía oficial de configuración

## 🚀 Instalación y Configuración

### 1. Clonar el Repositorio

#### Github (línea de comandos):
```bash
git clone <url-del-repositorio>
cd scripts-bd
```

#### Github (interfaz gráfica):
1. **Instalar GitHub Desktop**: Descargar desde **[GitHub Desktop](https://desktop.github.com/)**
2. **Abrir GitHub Desktop** y hacer clic en "Clone a repository from the Internet"
3. **Pegar la URL** del repositorio en el campo correspondiente
4. **Elegir la carpeta** donde quieres guardar el proyecto
5. **Hacer clic en "Clone"** para descargar el proyecto

> **💡 Tip**: GitHub Desktop te permitirá ver cambios, hacer commits y sincronizar con el repositorio sin usar comandos. Consulta la [guía oficial de configuración](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/setting-up-github-desktop) para más detalles.

### 2. Levantar los Servicios con Docker

```bash
# Construir y levantar todos los servicios
docker-compose up -d

# Verificar que todos los contenedores estén corriendo
docker-compose ps
```

**Nota**: El primer arranque puede tomar varios minutos ya que Oracle necesita inicializarse completamente.

### 3. Configuración de la Base de Datos

#### Conexión a Oracle Database

Una vez que el contenedor de Oracle esté en funcionamiento, puedes conectarte usando:

**Credenciales de conexión:**
- **Host**: localhost
- **Puerto**: 1525
- **SID/Service**: XE
- **Usuario**: SYSTEM
- **Contraseña**: admin

#### Herramientas de conexión recomendadas:
- **SQL Developer**: Herramienta oficial de Oracle
- **DBeaver**: Cliente universal gratuito
- **SQL*Plus**: Cliente de línea de comandos

#### Conexión vía SQL*Plus (dentro del contenedor):

```bash
# Entrar al contenedor de Oracle
docker exec -it scripts-bd-oracle-db-1 bash

# Conectarse con SQL*Plus
sqlplus SYSTEM/admin@XE
```

### 4. Ejecución de Scripts de Base de Datos

**IMPORTANTE**: Los scripts deben ejecutarse en el siguiente orden:

```bash
# 1. Crear secuencias
@create_sequence.sql

# 2. Crear tablas
@create_table.sql

# 3. Crear procedimientos almacenados
@stored_procedures.sql

# 4. Crear triggers (ANTES de los inserts - algunos triggers asignan IDs automáticamente)
@triggers.sql

# 5. Insertar datos de prueba (DESPUÉS de triggers y procedures)
@insert_alemania.sql
@insert_francia.sql

# 6. Crear índices y optimizaciones
@optimizaciones_indices.sql
```

> **Nota crítica**: Los inserts deben ejecutarse **después** de los triggers y procedimientos porque algunos registros (como los tickets) dependen de triggers que asignan IDs automáticamente o validan datos.

#### Ejecutar scripts desde fuera del contenedor:

```bash
# Copiar scripts al contenedor
docker cp create_sequence.sql scripts-bd-oracle-db-1:/tmp/
docker cp create_table.sql scripts-bd-oracle-db-1:/tmp/
docker cp stored_procedures.sql scripts-bd-oracle-db-1:/tmp/
docker cp triggers.sql scripts-bd-oracle-db-1:/tmp/
docker cp insert_alemania.sql scripts-bd-oracle-db-1:/tmp/
docker cp insert_francia.sql scripts-bd-oracle-db-1:/tmp/
docker cp optimizaciones_indices.sql scripts-bd-oracle-db-1:/tmp/

# Ejecutar cada script EN EL ORDEN CORRECTO
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/create_sequence.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/create_table.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/stored_procedures.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/triggers.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/insert_alemania.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/insert_francia.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/optimizaciones_indices.sql
```

## 🌐 Acceso a la Aplicación

### Frontend (Vue.js)
- **URL**: http://localhost:5173
- **Características**: Interfaz moderna y responsiva para gestión de museos

### Backend API (Express.js)
- **URL**: http://localhost:3000
- **Endpoint de prueba**: http://localhost:3000/api/test
- **Documentación API**: Los endpoints están documentados en el código del backend

### Base de Datos (Oracle XE)
- **Puerto**: 1525
- **String de conexión**: localhost:1525/XE
- **Usuario**: SYSTEM
- **Contraseña**: admin

## 📊 Funcionalidades Principales

### Gestión de Artistas
- Registro de nuevos artistas
- Información biográfica completa
- Vinculación con lugares de origen

### Gestión de Museos
- Administración de información institucional
- Cálculo de ranking basado en métricas
- Histórico institucional

### Gestión de Exposiciones y Eventos
- Programación de exposiciones temporales
- Gestión de eventos educativos
- Control de fechas y costos

### Administración de Recursos Humanos
- Registro de empleados profesionales
- Gestión de formación académica
- Historial laboral detallado

### Gestión de Tickets e Ingresos
- Venta automatizada de tickets
- Cálculo de precios con triggers
- Reportes de ingresos

## 🛠️ Desarrollo

### Metodología de Desarrollo

Este proyecto sigue las mejores prácticas de desarrollo full-stack, implementando un enfoque **front → back → middle** como recomienda [FreeCodeCamp](https://www.freecodecamp.org/news/how-to-build-a-full-stack-application-from-start-to-finish/):

1. **Frontend primero**: Diseño de interfaces con datos mockeados
2. **Base de datos**: Modelado de datos basado en requisitos del frontend  
3. **Backend API**: Conexión entre frontend y base de datos

### Estructura del Proyecto

```
scripts-bd/
├── proyecto-museo/
│   ├── frontend/          # Aplicación Vue.js
│   ├── backend/           # API Express.js
│   └── docker-compose.yml # Configuración de servicios
├── docs/                  # Documentación del proyecto
├── create_sequence.sql    # Secuencias de la BD
├── create_table.sql       # Script de creación de tablas
├── stored_procedures.sql  # Procedimientos almacenados
├── triggers.sql          # Triggers de la BD
├── insert_*.sql          # Datos de prueba
├── optimizaciones_indices.sql # Índices para rendimiento
└── README.md             # Este archivo
```

### Comandos Útiles para Desarrollo

```bash
# Ver logs de todos los servicios
docker-compose logs

# Ver logs específicos del backend
docker-compose logs backend

# Seguir logs en tiempo real
docker-compose logs -f

# Reiniciar un servicio específico
docker-compose restart backend

# Entrar al contenedor de Oracle para debugging
docker exec -it scripts-bd-oracle-db-1 bash

# Verificar estado de la base de datos
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE -S @/opt/oracle/product/19c/dbhome_1/rdbms/admin/utlsampl.sql

# Parar todos los servicios
docker-compose down

# Limpiar completamente (incluyendo volúmenes)
docker-compose down -v

# Reconstruir contenedores después de cambios
docker-compose up --build
```

### Script de Configuración Automatizada

Para automatizar la configuración inicial, puedes crear un script que ejecute todos los pasos:

```bash
# crear_bd.sh (Linux/Mac) o crear_bd.bat (Windows)
#!/bin/bash
echo "Configurando base de datos del museo..."

# Copiar todos los scripts
docker cp create_sequence.sql scripts-bd-oracle-db-1:/tmp/
docker cp create_table.sql scripts-bd-oracle-db-1:/tmp/
docker cp stored_procedures.sql scripts-bd-oracle-db-1:/tmp/
docker cp triggers.sql scripts-bd-oracle-db-1:/tmp/
docker cp insert_alemania.sql scripts-bd-oracle-db-1:/tmp/
docker cp insert_francia.sql scripts-bd-oracle-db-1:/tmp/
docker cp optimizaciones_indices.sql scripts-bd-oracle-db-1:/tmp/

# Ejecutar en orden
echo "1/6 Creando secuencias..."
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/create_sequence.sql

echo "2/6 Creando tablas..."
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/create_table.sql

echo "3/6 Creando procedimientos..."
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/stored_procedures.sql

echo "4/6 Creando triggers..."
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/triggers.sql

echo "5/6 Insertando datos..."
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/insert_alemania.sql
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/insert_francia.sql

echo "6/6 Optimizando con índices..."
docker exec scripts-bd-oracle-db-1 sqlplus SYSTEM/admin@XE @/tmp/optimizaciones_indices.sql

echo "¡Base de datos configurada exitosamente!"
```

## 🔧 Solución de Problemas

### Oracle no arranca
- Verificar que tienes suficiente memoria RAM (mínimo 4GB)
- Esperar más tiempo (el primer arranque puede tomar 5-10 minutos)
- Revisar logs: `docker-compose logs oracle-db`

### Error de conexión del backend a Oracle
- Verificar que Oracle esté completamente inicializado
- Comprobar que las tablas estén creadas
- Revisar las credenciales en `backend/server.js`

### Frontend no carga
- Verificar que el backend esté funcionando
- Comprobar que no hay conflictos de puertos
- Revisar logs del frontend: `docker-compose logs frontend`

## 📝 Notas Importantes

1. **Primer Arranque**: El contenedor de Oracle necesita tiempo para inicializarse completamente
2. **Persistencia**: Los datos se mantienen en el volumen `oracle-data` de Docker
3. **Desarrollo**: Los cambios en el código se reflejan automáticamente gracias a los volúmenes montados
4. **Producción**: En un entorno productivo, cambiar las credenciales por defecto y usar Docker Secrets

## 📚 Documentación Adicional

- **Procesos de Negocio**: Ver `docs/procesos-de-negocio.md`
- **Tareas del Proyecto**: Ver `tareas.md`
- **Lógica de Base de Datos**: Ver `docs/database_logic.md` (si existe)

## 👥 Contribución

### Para desarrolladores:
1. Seguir las directivas de desarrollo establecidas
2. Documentar cambios en `tareas.md`
3. Mantener la estructura modular del código
4. Probar thoroughly antes de hacer commit

### Para no desarrolladores:
1. **Usar GitHub Desktop** para gestionar cambios de forma visual
2. **Hacer commits descriptivos** explicando qué cambios realizaste
3. **Crear Pull Requests** desde GitHub Desktop para revisar cambios
4. **Documentar** en `tareas.md` cualquier modificación importante

#### Flujo básico con GitHub Desktop:
1. **Fetch origin** para obtener los últimos cambios
2. **Realizar modificaciones** en archivos (documentación, datos, etc.)
3. **Ver cambios** en la pestaña "Changes" de GitHub Desktop
4. **Escribir un mensaje** descriptivo del commit
5. **Commit to main** para guardar cambios localmente
6. **Push origin** para subir cambios al repositorio

> **Recursos útiles**: La [documentación oficial de GitHub Desktop](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop) contiene guías detalladas para usuarios principiantes.
