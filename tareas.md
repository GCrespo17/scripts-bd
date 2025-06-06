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

- [ ] **Tarea 2.1: (Rúbrica) Formulario: Registro de Artistas**
    - **Descripción:** Crear una interfaz de usuario para insertar nuevos artistas en la tabla `ARTISTAS`.
    - **Prioridad:** ALTA

- [ ] **Tarea 2.2: (Rúbrica) Formulario: Registro de Exposición/Evento**
    - **Descripción:** Desarrollar un formulario para registrar un nuevo `EXPOSICION_EVENTO`. Debe facilitar la selección de museo, sala y la entrada de todos los datos relevantes. Esta tarea cubre parcialmente la nueva recomendación de "Gestión de Eventos Especiales".
    - **Prioridad:** ALTA

- [ ] **Tarea 2.3: (Rúbrica) Formulario: Programa de Mantenimiento**
    - **Descripción:** Crear una interfaz para añadir registros a `PROGRAMAS_MANT`, permitiendo seleccionar una obra y definir su plan de mantenimiento.
    - **Prioridad:** ALTA

- [ ] **Tarea 2.4: (Rúbrica) Formulario: Estructura Física del Museo**
    - **Descripción:** Implementar un formulario para gestionar la `EST_FISICA`, permitiendo añadir edificios, pisos o áreas y establecer sus jerarquías.
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

- [ ] **Tarea 3.1: (Rúbrica) Diseño de Plantilla de Reportes**
    - **Descripción:** Crear un diseño base (plantilla) que personalice todos los reportes con una identidad visual común para el proyecto.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.2: (Rúbrica) Reporte: Estructura Organizacional**
    - **Descripción:** Implementar un reporte parametrizado por museo que muestre su organigrama (`EST_ORGANIZACIONAL`) de forma jerárquica.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.3: (Rúbrica) Reporte: Ficha Museo**
    - **Descripción:** Crear un reporte que muestre la ficha completa de un museo: datos base, historia, ubicación, cálculo de ranking y lista de colecciones.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.4: (Rúbrica) Reporte: Ficha Empleado**
    - **Descripción:** Desarrollar un reporte para curadores/restauradores que muestre su ficha completa: datos personales, formación, idiomas e historial laboral.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.5: (Rúbrica) Reporte: Estructura Física**
    - **Descripción:** Implementar un reporte que muestre la estructura física de un museo, detallando edificios, plantas y la ubicación de las colecciones.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.6: (Recomendado) Reporte: Ingresos por Tickets y Periodo**
    - **Descripción:** **(NUEVO)** Crear un reporte financiero que muestre los ingresos por venta de tickets, parametrizable por museo y rango de fechas. Aborda la alta prioridad de "Reportes Financieros".
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