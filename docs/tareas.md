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

- [x] **Tarea 2.1: (Rúbrica) Formulario: Registro de Artistas**
    - **Descripción:** Crear una interfaz de usuario para insertar nuevos artistas en la tabla `ARTISTAS`.
    - **Prioridad:** ALTA

- [ ] **Tarea 2.2: (Rúbrica) Formulario: Registro de Exposición/Evento**
    - **Descripción:** Desarrollar un formulario para registrar un nuevo `EXPOSICION_EVENTO`. Debe facilitar la selección de museo, sala y la entrada de todos los datos relevantes. Esta tarea cubre parcialmente la nueva recomendación de "Gestión de Eventos Especiales".
    - **Prioridad:** ALTA

- [ ] **Tarea 2.3: (Rúbrica) Formulario: Programa de Mantenimiento**
    - **Descripción:** Crear una interfaz para añadir registros a `PROGRAMAS_MANT`, permitiendo seleccionar una obra y definir su plan de mantenimiento.
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

- [ ] **Tarea 3.1: (Rúbrica) Diseño de Plantilla de Reportes**
    - **Descripción:** Crear un diseño base (plantilla) que personalice todos los reportes con una identidad visual común para el proyecto.
    - **Prioridad:** ALTA

- [ ] **Tarea 3.2: (Rúbrica) Reporte: Estructura Organizacional**
    - **Descripción:** Implementar un reporte parametrizado por museo que muestre su organigrama (`EST_ORGANIZACIONAL`) de forma jerárquica.
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

- [ ] **Tarea 3.4: (Rúbrica) Reporte: Ficha Empleado**
    - **Descripción:** Desarrollar un reporte para curadores/restauradores que muestre su ficha completa: datos personales, formación, idiomas e historial laboral.
    - **Prioridad:** ALTA

- [x] **Tarea 3.5: (Rúbrica) Reporte: Estructura Física** ✅ COMPLETADA
    - **Descripción:** Implementar un reporte que muestre la estructura física de un museo, detallando edificios, plantas y la ubicación de las colecciones.
    - **Estado:** ✅ COMPLETADA - Se implementó reporte completo con diseño profesional, resumen ejecutivo, estructura jerárquica detallada, información de colecciones y exposiciones actuales, con funcionalidad de impresión.
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

---

## Registro de Progreso

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