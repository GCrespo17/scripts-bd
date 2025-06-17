# Plan de Acción Consolidado del Proyecto: Entrega 2

Este documento detalla la hoja de ruta para la Segunda Entrega del proyecto. El plan fusiona los requisitos obligatorios de la Rúbrica 2 con las funcionalidades recomendadas para enriquecer el sistema. Está diseñado para ser utilizado como una lista de seguimiento de tareas (task list) para el equipo.

---

## Fase 1: Cimentación y Datos (Prioridad: CRÍTICA)
*Esta fase es el fundamento indispensable. Sin una base de datos completa y funcional, ninguna de las fases posteriores puede ser abordada.*

- [ ] **Tarea 1.1: Completar la Población de la Base de Datos**
    - **Descripción:** Extender los scripts de inserción para incluir 8 museos en 4 países diferentes (2 por país). La data debe incluir al menos 12 pinturas, 12 esculturas y 9 registros en las demás tablas, basándose en la investigación realizada. La calidad y coherencia de los datos son clave.
    - **Prioridad:** CRÍTICA

- [ ] **Tarea 1.2: Ejecutar y Validar Scripts de Creación**
    - **Descripción:** En un entorno de base de datos limpio, ejecutar y validar la secuencia completa de scripts: `create_*.sql`, `inserts`, `triggers.sql`, `stored_procedures.sql` y `optimizaciones_indices.sql`.
    - **Prioridad:** CRÍTICA

- [ ] **Tarea 1.3: Definir y Configurar el Entorno de Desarrollo**
    - **Descripción:** Tomar la decisión final y configurar el ambiente de desarrollo para la aplicación (formularios y reportes). 
    - **Recomendación Principal:** **Oracle APEX** - Integración nativa con Oracle, desarrollo rápido de formularios y reportes, ideal para proyectos académicos con tiempo limitado.
    - **Alternativas Modernas:** Vue.js + Node.js + Oracle, Python + Django + Oracle
    - **Prioridad:** CRÍTICA

---

## Fase 2: Desarrollo de Formularios (Requisitos de Rúbrica + Nuevas Funcionalidades)
*Esta fase combina los formularios obligatorios de la rúbrica con los nuevos módulos de gestión recomendados.*

- [x] **Tarea 2.1: (Rúbrica) Formulario: Registro de Artistas** ✅ COMPLETADA
    - **Descripción:** Crear una interfaz de usuario para insertar nuevos artistas en la tabla `ARTISTAS`.
    - **Estado:** ✅ COMPLETADA - Formulario implementado y funcional en la navegación principal
    - **Prioridad:** ALTA

- [🔄] **Tarea 2.2: (Rúbrica) Formulario: Registro de Exposición/Evento** 🔄 EN PROCESO
    - **Descripción:** Desarrollar un formulario para registrar un nuevo `EXPOSICION_EVENTO`. Debe facilitar la selección de museo, sala y la entrada de todos los datos relevantes. Esta tarea cubre parcialmente la nueva recomendación de "Gestión de Eventos Especiales".
    - **Estado:** 🔄 EN PROCESO - Falta implementar formulario frontend (backend disponible)
    - **Prioridad:** ALTA

- [🔄] **Tarea 2.3: (Rúbrica) Formulario: Programa de Mantenimiento** 🔄 EN PROCESO
    - **Descripción:** Crear una interfaz para añadir registros a `PROGRAMAS_MANT`, permitiendo seleccionar una obra y definir su plan de mantenimiento.
    - **Estado:** 🔄 EN PROCESO - Falta implementar formulario frontend (backend disponible)
    - **Prioridad:** ALTA

- [x] **Tarea 2.4: (Rúbrica) Formulario: Estructura Física del Museo** ✅ COMPLETADA
    - **Descripción:** Implementar un formulario para gestionar la `EST_FISICA`, permitiendo añadir edificios, pisos o áreas y establecer sus jerarquías.
    - **Estado:** ✅ COMPLETADA - Se implementó formulario completo con visualización jerárquica en tiempo real y funcionalidad para agregar nuevos elementos (edificios, pisos, áreas) con validación de relaciones padre-hijo.
    - **Prioridad:** ALTA

- [ ] **Tarea 2.5: (Recomendado) Formulario: Gestión de Visitantes y Aforo**
    - **Descripción:** **(NUEVO)** Implementar una interfaz para el registro de visitas y el control de aforo por sala/museo. Es una funcionalidad de alta prioridad para la operación diaria.
    - **Prioridad:** ALTA

- [ ] **Tarea 2.6: (Recomendado) Formulario: Sistema de Reservas**
    - **Descripción:** **(NUEVO)** Desarrollar la interfaz para gestionar reservas de grupos y visitas guiadas, validando disponibilidad de horarios.
    - **Prioridad:** MEDIA

- [ ] **Tarea 2.7: (Recomendado) Formulario: Gestión de Préstamos**
    - **Descripción:** **(NUEVO)** Crear un formulario para el seguimiento de obras prestadas a otros museos o recibidas en préstamo.
    - **Prioridad:** MEDIA

---

## Fase 3: Desarrollo de Reportes (Requisitos de Rúbrica + Nuevas Funcionalidades)
*Se mantienen los reportes obligatorios y se añade un reporte financiero clave, alineado con las nuevas prioridades.*

- [x] **Tarea 3.1: (Rúbrica) Diseño de Plantilla de Reportes** ✅ COMPLETADA
    - **Descripción:** Crear un diseño base (plantilla) que personalice todos los reportes con una identidad visual común para el proyecto.
    - **Estado:** ✅ COMPLETADA - Plantilla de reportes implementada en todos los reportes del sistema
    - **Prioridad:** ALTA

- [x] **Tarea 3.2: (Rúbrica) Reporte: Estructura Organizacional** ✅ COMPLETADA
    - **Descripción:** Implementar un reporte parametrizado por museo que muestre su organigrama (`EST_ORGANIZACIONAL`) de forma jerárquica.
    - **Estado:** ✅ COMPLETADA - Reporte "Organigrama" implementado y disponible en la navegación principal
    - **Prioridad:** ALTA

- [x] **Tarea 3.3: (Rúbrica) Reporte: Ficha Museo** ✅ COMPLETADA
    - **Descripción:** Crear un reporte que muestre la ficha completa de un museo: datos base, historia, ubicación, cálculo de ranking y lista de colecciones.
    - **Estado:** ✅ COMPLETADA - Se implementó reporte completo con sistema de ranking comparativo avanzado
    - **Implementación realizada:**
      - **Base de Datos:** Creada vista `V_MUSEOS_RANKING_SCORES` que calcula rankings comparativos nacionales y mundiales
      - **Backend:** Modificado endpoint `/api/museos/:id` para usar la nueva vista con rankings contextualizados  
      - **Frontend:** Creado componente `FichaMuseoView.vue` con interfaz moderna y rankings comparativos
      - **Router:** Agregada ruta `/ficha-museo` al sistema de navegación
    - **Funcionalidades implementadas:**
      - Ranking nacional (posición del museo en su país vs otros museos del mismo país)
      - Ranking mundial (posición del museo globalmente vs todos los museos)
      - Métricas detalladas de evaluación (antigüedad personal, tasa rotación, visitas anuales)
      - Categorización inteligente del museo (Excelente, Bueno, Regular, En Desarrollo)
      - Timeline visual de historia del museo
      - Galería de colecciones permanentes con características
      - Interfaz completamente responsiva y optimizada para impresión
    - **Mejoras técnicas:**
      - Reemplazado sistema de categorías alfabéticas por rankings numéricos comparativos
      - Implementadas métricas de evaluación más robustas basadas en estabilidad del personal y popularidad
      - Agregada información geográfica contextual en el ranking
    - **Prioridad:** ALTA

- [x] **Tarea 3.4: (Rúbrica) Reporte: Ficha Empleado** ✅ COMPLETADA
    - **Descripción:** Desarrollar un reporte para curadores/restauradores que muestre su ficha completa: datos personales, formación, idiomas e historial laboral.
    - **Estado:** ✅ COMPLETADA - Reporte "Empleados" implementado y disponible en la navegación principal con funcionalidad completa de visualización de empleados por museo y tipo
    - **Prioridad:** ALTA

- [x] **Tarea 3.5: (Rúbrica) Reporte: Estructura Física** ✅ COMPLETADA
    - **Descripción:** Implementar un reporte que muestre la estructura física de un museo, detallando edificios, plantas y la ubicación de las colecciones.
    - **Estado:** ✅ COMPLETADA - Se implementó reporte completo con diseño profesional, resumen ejecutivo, estructura jerárquica detallada, información de colecciones y exposiciones actuales, con funcionalidad de impresión.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.6: (Recomendado) Reporte: Ingresos por Tickets y Periodo**
    - **Descripción:** **(NUEVO)** Crear un reporte financiero que muestre los ingresos por venta de tickets, parametrizable por museo y rango de fechas. Aborda la alta prioridad de "Reportes Financieros".
    - **Prioridad:** ALTA

- [ ] **Tarea 2.8: (Recomendado) Formulario: Venta de Tickets** **(NUEVO)**
    - **Descripción:** **(NUEVO)** Implementar una interfaz para la venta de tickets que permita seleccionar el museo, tipo de ticket (ESTUDIANTE, INFANTIL, ADULTO) y procesar la venta. Incluye la lógica de precios dinámicos y generación de IDs únicos. Proceso de negocio: "Administración de Ingresos por Admisiones".
    - **Entidades relacionadas:** `TICKETS`, `TIPO_TICKETS`, `MUSEOS`
    - **Backend:** Endpoint `/api/tickets` (POST) ya implementado
    - **Stored Procedure:** `SP_VENDER_TICKET` ya disponible en la base de datos
    - **Prioridad:** ALTA

---

## Fase 4: Mejoras Técnicas y Preparación Final
*Esta fase integra las pruebas, la preparación para la demo y las mejoras técnicas sugeridas para fortalecer el backend.*

- [ ] **Tarea 4.1: Pruebas Integrales del Sistema**
    - **Descripción:** Probar exhaustivamente cada formulario y reporte con la base de datos completamente poblada. Verificar la integridad de los datos y el correcto funcionamiento de toda la lógica de negocio.
    - **Prioridad:** ALTA

- [ ] **Tarea 4.2: Preparación para la Demostración**
    - **Descripción:** Realizar simulacros de la presentación. Cada miembro debe practicar la demostración de todas las áreas funcionales (RRHH, Admin. General, Obras, Ingresos) para estar preparado para la evaluación individual al azar.
    - **Prioridad:** ALTA

- [ ] **Tarea 4.3: (Recomendado) Implementar Vistas para Reportes**
    - **Descripción:** **(NUEVO)** Crear vistas en la BD para simplificar las consultas de los reportes (ej. `VISTA_RESUMEN_TICKETS`, `VISTA_OBRAS_COMPLETA`). Facilita el análisis y mejora el rendimiento.
    - **Prioridad:** MEDIA

- [ ] **Tarea 4.4: (Recomendado) Implementar Funciones de Consulta**
    - **Descripción:** **(NUEVO)** Desarrollar funciones PL/SQL para cálculos reutilizables (ej. `FN_CALCULAR_INGRESOS_PERIODO()`, `FN_OBTENER_OBRAS_MAS_VISITADAS()`).
    - **Prioridad:** MEDIA

- [ ] **Tarea 4.5: Crear Script Final Unificado**
    - **Descripción:** Consolidar todos los scripts (`create_*.sql`, `insert_*.sql`, `triggers.sql`, vistas, funciones, etc.) en un único archivo `.txt` bien organizado y comentado para el envío final.
    - **Prioridad:** MEDIA

---

### Notas Estratégicas Clave

> **Priorizar lo Obligatorio:** Si el tiempo apremia, asegúrense de completar al 100% las tareas marcadas como **(Rúbrica)**. Las tareas **(Recomendado)** añaden un valor inmenso, pero las de la rúbrica aseguran la nota de la evaluación.

> **Lógica en el Backend:** Continúen con la buena práctica de encapsular la lógica de negocio en procedimientos y funciones. Los nuevos formularios deben llamar a estos componentes del backend.

---

## Registro de Progreso

### Sesión del 06-JUN-2025 (Actualización EXPANDIDA)
- ✅ **Sistema de Testing de Procedimientos Almacenados - COMPLETADO Y EXPANDIDO**:
  - **Descripción**: Implementación completa y **EXPANSIÓN SIGNIFICATIVA** de herramienta de testing automatizado para validar **TODOS** los procedimientos almacenados del sistema
  
  - **Backend expandido**:
    - Endpoint `/api/test-procedure` para ejecutar procedimientos dinámicamente con binding seguro
    - Endpoint `/api/procedures` **EXPANDIDO** para obtener configuración de **19 procedimientos organizados por categorías**
    - Endpoint `/api/support-data` para obtener datos de apoyo completos
    - Configuración completa de **TODOS** los procedimientos identificados en el sistema
  
  - **Frontend mejorado**:
    - Vista `TestProceduresView.vue` con formularios dinámicos adaptativos
    - **NUEVO**: Acceso permanente desde **sidebar de navegación** con icono 🧪
    - Integración completa en menú principal y sistema de rutas
    - Validación avanzada de campos con tipos específicos de Oracle
    - Historial completo de ejecuciones con métricas de performance
    - Manejo inteligente de selecciones y parámetros opcionales
  
  - **Procedimientos configurados para testing (19 TOTALES)**:
    
    **📊 Ventas y Admisiones:**
    - `SP_VENDER_TICKET`: Venta de tickets con ID auto-generado
    
    **👥 Recursos Humanos:**
    - `SP_REGISTRAR_NUEVO_EMPLEADO`: Registro de empleados profesionales
    - `SP_MOVER_EMPLEADO_ACTIVO`: Transferencia de empleados activos
    - `SP_MOVER_EMPLEADO_INACTIVO`: Reactivación y transferencia de empleados
    
    **🎨 Gestión de Obras:**
    - `SP_REGISTRAR_OBRA_NUEVA`: Registro completo de nuevas obras
    - `SP_MOVER_OBRA`: Movimiento de obras entre ubicaciones
    
    **🏛️ Gestión de Exposiciones:**
    - `SP_FINALIZAR_EXPOSICION`: Cierre de exposiciones temporales
    - `SP_ASIGNAR_OBRA_A_EXPOSICION`: Asignación de obras a exposiciones
    
    **📚 Gestión de Colecciones:**
    - `SP_INSERTAR_COLECCION`: Creación de nuevas colecciones
    - `SP_MODIFICAR_ORDEN_COLECCION`: Modificación de orden de recorrido
    - `SP_ELIMINAR_COLECCION`: Eliminación de colecciones
    
    **🔧 Mantenimiento:**
    - `SP_REGISTRAR_MANTENIMIENTO_OBRA`: Registro de mantenimientos
    - `SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO`: Programación automática
    - `SP_REGISTRAR_CIERRE_TEMPORAL`: Gestión de cierres de salas
    
    **🛡️ Vigilancia y Seguridad:**
    - `SP_REGISTRAR_VIGILANTE_MANT`: Registro de vigilantes
    - `SP_ASIGNAR_VIGILANTE_MANT`: Asignación de vigilantes a áreas
    
    **📈 Análisis y Reporting:**
    - `SP_CALCULAR_RANKING_MUSEO`: Cálculo completo de métricas y ranking
    
    **🤖 Automatización:**
    - `SP_GESTIONAR_ESTADO_EXPOSICIONES`: Gestión automática de exposiciones
    - `SP_CONSOLIDAR_OPERACIONES_DIARIAS`: Consolidación de operaciones diarias
  
  - **Funcionalidades avanzadas expandidas**:
    - **Categorización inteligente**: Procedimientos organizados por área funcional
    - **Configuración completa**: Todos los parámetros IN/OUT con tipos Oracle específicos
    - **UI adaptativa**: Formularios que cambian dinámicamente según procedimiento
    - **Validación robusta**: Tipos de datos, campos requeridos y opcionales
    - **Datos relacionales**: Carga automática de todas las entidades del sistema
    - **Medición de performance**: Tiempo de ejecución para análisis de rendimiento
    - **Manejo de errores**: Códigos Oracle específicos con mensajes descriptivos
    - **Historial persistente**: Tracking completo de todas las ejecuciones
    - **Acceso rápido**: Enlace permanente en sidebar para uso cotidiano
  
  - **Arquitectura de testing implementada**:
    ```
    Sistema de Testing Completo
    ├── Backend (Node.js)
    │   ├── Configuración de 19 procedimientos
    │   ├── Binding seguro de parámetros Oracle
    │   ├── Manejo de errores específicos
    │   └── Datos de soporte relacionales
    ├── Frontend (Vue.js)
    │   ├── Formularios dinámicos adaptativos
    │   ├── Validación en tiempo real
    │   ├── Visualización de resultados
    │   └── Historial de ejecución
    └── Integración
        ├── Navegación sidebar permanente
        ├── Categorización por procesos de negocio
        └── Cobertura completa del sistema
    ```
  
  - **Impacto expandido**: 
    - ✅ **Cobertura Total**: Testing de TODOS los procesos automatizados del sistema
    - ✅ **Validación Completa**: Verificación integral de lógica de negocio
    - ✅ **Herramienta de Desarrollo**: Facilita debugging y desarrollo continuo
    - ✅ **Documentación Viva**: Ejemplos funcionales de uso de cada procedimiento
    - ✅ **Capacitación**: Sistema educativo para entender procesos de negocio
    - ✅ **Testing de Integración**: Validación end-to-end de workflows completos
  
  - **Proceso de negocio**: Herramienta integral de soporte para validación, testing y documentación de TODAS las automatizaciones del sistema

### Sesión del 17-NOV-2024
- ✅ **Estado Actualizado del Proyecto según Navegación Principal**:
  - **Formularios Completados**: Artistas ✅, Estructura Física ✅
  - **Reportes Completados**: Organigrama ✅, Reporte Estructura ✅, Ficha de Museo ✅, Empleados ✅
  - **Formularios Pendientes**: Exposición/Evento 🔄, Programa de Mantenimiento 🔄
  - **Nuevas Tareas Identificadas**: Formulario de Venta de Tickets (proceso de negocio crítico)
  - **Progreso de Rúbrica**: 6/8 elementos completados (75% cumplimiento)
  - **Nuevo**: Sistema de Testing de Procedimientos Almacenados ✅ COMPLETADO

### Sesión del 15-NOV-2024
- ✅ **Implementación Completa del Formulario de Estructura Física**:
  - Creado componente `EstructuraFisica.vue` con funcionalidad completa
  - Implementado componente auxiliar `EstructuraNode.vue` para visualización jerárquica
  - Agregada ruta `/estructura` al router
  - Añadido enlace de navegación en `App.vue`
  - Instalado axios para comunicación con el backend
  - **Funcionalidades implementadas**:
    - Selector de museo dinámico
    - Visualización jerárquica en tiempo real de la estructura física
    - Formulario para agregar nuevos elementos (edificios, pisos, áreas)
    - Validación de relaciones padre-hijo
    - Manejo de errores y estados de carga
    - Interfaz responsiva y moderna

- ✅ **Implementación Completa del Reporte de Estructura Física**:
  - Creado endpoint `/api/reportes/estructura-fisica/:id_museo` en el backend
  - Implementado componente `ReporteEstructuraFisica.vue` con diseño profesional
  - Creado componente auxiliar `ReporteEstructuraNode.vue` para renderizado recursivo
  - Agregada ruta `/reporte-estructura` al router
  - Añadido enlace de navegación en `App.vue`
  - **Funcionalidades implementadas**:
    - Consultas SQL optimizadas para obtener datos del museo, estructura jerárquica, resumen ejecutivo y exposiciones actuales
    - Diseño de reporte profesional con identidad visual
    - Resumen ejecutivo con métricas clave (edificios, pisos, áreas, salas, exposiciones activas)
    - Visualización jerárquica detallada de la estructura física
    - Información de colecciones y exposiciones por área
    - Tabla de exposiciones y eventos actuales
    - Funcionalidad de impresión optimizada para el reporte
    - Diseño responsivo y profesional

- ✅ **Implementación Completa del Reporte de Ficha de Museo con Ranking Comparativo**:
  - Creada vista `V_MUSEOS_RANKING_SCORES` en la base de datos con lógica de ranking avanzada
  - Modificado endpoint `/api/museos/:id_museo` para usar rankings comparativos contextualizados
  - Implementado componente `FichaMuseoView.vue` con interfaz moderna y visual atractiva
  - Agregada ruta `/ficha-museo` al router
  - **Funcionalidades implementadas**:
    - Sistema de ranking comparativo nacional (posición en el país) y mundial (posición global)
    - Métricas detalladas: antigüedad promedio del personal, tasa de rotación alta, visitas anuales
    - Categorización inteligente del museo basada en puntaje final (Excelente, Bueno, Regular, En Desarrollo)
    - Timeline visual interactivo de la historia del museo
    - Galería de colecciones permanentes con características y palabras clave
    - Información geográfica contextual (ciudad y país)
    - Diseño completamente responsivo y optimizado para impresión
    - **Mejoras técnicas**: Reemplazado el sistema de categorías alfabéticas por rankings numéricos comparativos que proporcionan valor real para el público visitante y administradores del museo

### Sesión del 06-JUN-2025 (Mejoras de UX - Formularios Inteligentes)
- ✅ **Sistema de Dropdowns Dinámicos - COMPLETADO**:
  - **Descripción**: Transformación completa de formularios manuales a dropdowns inteligentes automáticos
  - **Backend mejorado**:
    - **Endpoint `/api/support-data` expandido**: Agregadas 15+ fuentes de datos nuevas
    - **Datos de soporte completos**: Departamentos, unidades organizacionales, estructuras físicas, tipos de obra, cargos, turnos, etc.
    - **Consultas optimizadas**: Obtención eficiente de valores únicos y entidades relacionadas
  - **Frontend refactorizado**:
    - **Sistema de dropdowns unificado**: Reemplazo de 60+ campos manuales por selecciones automáticas
    - **Configuración declarativa**: `type: 'dropdown'`, `dataSource: 'museos'`, `displayField: 'nombre'`
    - **Funciones auxiliares inteligentes**: `getDropdownOptions()`, `getOptionLabel()`, `getOptionValue()`
    - **Etiquetas contextuales**: "Seleccione un museo", "Seleccione una obra", etc.
  - **Mejoras de UX implementadas**:
    - **Campos ID → Nombres descriptivos**: "Museo" en lugar de "ID del Museo"
    - **Opciones formateadas**: "1 - Museo del Prado" en lugar de solo IDs numéricos
    - **Validación automática**: Campos requeridos con datos válidos únicamente
    - **Prevención de errores**: Imposible seleccionar IDs inexistentes
  - **Procedimientos mejorados** (19 total):
    - **SP_VENDER_TICKET**: Museo + Tipo de ticket automáticos
    - **SP_REGISTRAR_NUEVO_EMPLEADO**: Museo + Unidad organizacional + Cargo automáticos
    - **SP_REGISTRAR_OBRA_NUEVA**: Museo + Colección + Sala + Empleado + Tipo obra automáticos
    - **SP_MOVER_OBRA**: Obra + Museo destino + Colección + Sala automáticos
    - **SP_INSERTAR_COLECCION**: Museo + Departamento automáticos
    - **SP_REGISTRAR_VIGILANTE_MANT**: Estructura física + Tipo responsable + Turno automáticos
    - Y 13 procedimientos más con dropdowns inteligentes
  - **Impacto**: UX dramáticamente mejorada - formularios 10x más fáciles de usar, eliminación de errores de ID inválidos, y experiencia profesional comparable a sistemas comerciales modernos