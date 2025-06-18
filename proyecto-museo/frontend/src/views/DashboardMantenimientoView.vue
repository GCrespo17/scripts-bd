<template>
  <div class="dashboard-mantenimiento">
    <!-- Header -->
    <div class="page-header">
      <div class="breadcrumb">
        <span class="breadcrumb-item">Sistema</span>
        <span class="breadcrumb-separator">→</span>
        <span class="breadcrumb-item">Mantenimiento</span>
        <span class="breadcrumb-separator">→</span>
        <span class="breadcrumb-item active">Dashboard</span>
      </div>
      <h1 class="page-title">
        <span class="page-icon">📊</span>
        Dashboard de Mantenimiento
      </h1>
      <p class="page-description">
        Monitor en tiempo real del sistema automatizado de mantenimiento de obras
      </p>
    </div>

    <!-- Selector de Museo -->
    <div class="control-section">
      <div class="museo-selector">
        <label for="museo">Museo:</label>
        <select 
          id="museo" 
          v-model="museoSeleccionado" 
          @change="cargarDashboard"
          class="form-control"
        >
          <option value="">Seleccione un museo...</option>
          <option 
            v-for="museo in museos" 
            :key="museo.id" 
            :value="museo.id"
          >
            {{ museo.nombre }}
          </option>
        </select>
      </div>

      <div class="dashboard-controls">
        <button 
          @click="cargarDashboard" 
          :disabled="!museoSeleccionado || loading"
          class="btn btn-primary"
        >
          <span class="btn-icon">🔄</span>
          Actualizar
        </button>
        
        <button 
          @click="exportarReporte" 
          :disabled="!museoSeleccionado || loading"
          class="btn btn-secondary"
        >
          <span class="btn-icon">📋</span>
          Exportar
        </button>
      </div>
    </div>

    <!-- Dashboard Principal -->
    <div v-if="dashboardData && !loading" class="dashboard-content">
      
      <!-- KPIs Principales -->
      <div class="kpis-section">
        <h2 class="section-title">
          <span class="section-icon">📈</span>
          Métricas Principales
        </h2>
        
        <div class="kpis-grid">
          <div class="kpi-card">
            <div class="kpi-icon">🔧</div>
            <div class="kpi-content">
              <div class="kpi-value">{{ dashboardData.estadisticas.total_programas }}</div>
              <div class="kpi-label">Programas Activos</div>
            </div>
          </div>
          
          <div class="kpi-card">
            <div class="kpi-icon">⚡</div>
            <div class="kpi-content">
              <div class="kpi-value">{{ dashboardData.estadisticas.mantenimientos_activos }}</div>
              <div class="kpi-label">En Ejecución</div>
            </div>
          </div>
          
          <div class="kpi-card">
            <div class="kpi-icon">✅</div>
            <div class="kpi-content">
              <div class="kpi-value">{{ dashboardData.estadisticas.mantenimientos_completados }}</div>
              <div class="kpi-label">Completados</div>
            </div>
          </div>
          
          <div class="kpi-card">
            <div class="kpi-icon">⏱️</div>
            <div class="kpi-content">
              <div class="kpi-value">{{ dashboardData.estadisticas.duracion_promedio_dias }}d</div>
              <div class="kpi-label">Duración Promedio</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Sección de Automatizaciones Inteligentes -->
      <div class="automatizaciones-section">
        <h2 class="section-title">
          <span class="section-icon">🤖</span>
          Automatizaciones Inteligentes
        </h2>
        <p class="section-description">
          Demuestra las capacidades proactivas y reactivas del sistema de museos
        </p>
        
        <div class="automatizaciones-grid">
          <!-- Demo 1: Viaje en el Tiempo -->
          <div class="auto-card">
            <div class="auto-header">
              <div class="auto-icon">⏰</div>
              <div class="auto-info">
                <h3 class="auto-title">Consolidación Diaria</h3>
                <p class="auto-subtitle">El "Viaje en el Tiempo" - Automatización Proactiva</p>
              </div>
            </div>
            <div class="auto-content">
              <p class="auto-description">
                Simula la ejecución automática nocturna que detecta mantenimientos pendientes y programa tareas futuras.
              </p>
              <div class="auto-controls">
                <button 
                  @click="runDailyConsolidation" 
                  :disabled="!museoSeleccionado || consolidationLoading"
                  class="btn btn-automation"
                >
                  <span class="btn-icon">🚀</span>
                  {{ consolidationLoading ? 'Ejecutando...' : 'Ejecutar Consolidación Diaria' }}
                </button>
              </div>
              <div v-if="consolidationResult" class="auto-result">
                <h4>Resultado de la Consolidación:</h4>
                <pre class="result-summary">{{ consolidationResult }}</pre>
              </div>
            </div>
          </div>

          <!-- Demo 2: Reacción en Cadena -->
          <div class="auto-card">
            <div class="auto-header">
              <div class="auto-icon">🔗</div>
              <div class="auto-info">
                <h3 class="auto-title">Reacción en Cadena</h3>
                <p class="auto-subtitle">Movimiento de Obras - Automatización Reactiva</p>
              </div>
            </div>
            <div class="auto-content">
              <p class="auto-description">
                Demuestra cómo mover una obra desencadena actualizaciones automáticas en la cadena de custodia.
              </p>
              
              <!-- Paso 1: Seleccionar obra a mover -->
              <div class="demo-step" v-if="!obraSeleccionada">
                <h4>Paso 1: Seleccionar Obra a Mover</h4>
                <div class="form-group">
                  <label>Obra:</label>
                  <select v-model="obraParaMover" class="form-control-small">
                    <option value="">Seleccione una obra...</option>
                    <option 
                      v-for="obra in obrasDisponibles" 
                      :key="obra.id"
                      :value="obra"
                    >
                      {{ obra.nombre }} ({{ obra.ubicacion_actual }})
                    </option>
                  </select>
                </div>
                <button 
                  @click="mostrarEstadoInicial" 
                  :disabled="!obraParaMover || chainLoading"
                  class="btn btn-automation-small"
                >
                  🔍 Ver Estado Inicial
                </button>
              </div>

              <!-- Paso 2: Mostrar estado inicial y formulario de movimiento -->
              <div class="demo-step" v-if="obraSeleccionada && !movimientoEjecutado">
                <h4>Estado Inicial de la Obra</h4>
                <div class="estado-obra">
                  <div class="obra-info">
                    <strong>{{ obraSeleccionada.nombre }}</strong>
                    <br>Ubicación actual: {{ obraSeleccionada.ubicacion_actual }}
                    <br>ID Histórico: {{ obraSeleccionada.id_historico }}
                  </div>
                </div>

                <h4>Paso 2: Mover a Nueva Ubicación</h4>
                <div class="form-group">
                  <label>Nueva Sala:</label>
                  <select v-model="nuevaSala" class="form-control-small">
                    <option value="">Seleccione nueva sala...</option>
                    <option 
                      v-for="sala in salasDisponibles" 
                      :key="sala.id"
                      :value="sala.id"
                    >
                      {{ sala.nombre }} ({{ sala.museo }})
                    </option>
                  </select>
                </div>
                <div class="auto-controls">
                  <button 
                    @click="ejecutarMovimiento" 
                    :disabled="!nuevaSala || chainLoading"
                    class="btn btn-automation"
                  >
                    <span class="btn-icon">🚀</span>
                    {{ chainLoading ? 'Moviendo...' : 'Ejecutar Movimiento' }}
                  </button>
                  <button 
                    @click="resetearDemo" 
                    class="btn btn-secondary-small"
                  >
                    🔄 Reiniciar Demo
                  </button>
                </div>
              </div>

              <!-- Paso 3: Mostrar resultado de la reacción en cadena -->
              <div class="demo-step" v-if="movimientoEjecutado">
                <h4>🎉 Reacción en Cadena Completada</h4>
                <div class="chain-result">
                  <div class="evidencia">
                    <h5>📊 Evidencia 1: Registro Anterior Cerrado</h5>
                    <div class="evidencia-content">
                      ✅ El registro histórico anterior ahora tiene <strong>fecha_salida</strong> automáticamente
                      <br>🤖 <em>Hecho por el trigger TRG_HIST_OBRAS_MOV_FECHAS</em>
                    </div>
                  </div>
                  <div class="evidencia">
                    <h5>📊 Evidencia 2: Nuevo Registro Creado</h5>
                    <div class="evidencia-content">
                      ✅ Nuevo registro histórico creado para la nueva ubicación
                      <br>🛠️ <em>Hecho por el procedimiento SP_MOVER_OBRA</em>
                    </div>
                  </div>
                  <div class="evidencia">
                    <h5>🔗 Resultado de la Cadena</h5>
                    <div class="evidencia-content">
                      <strong>Una sola acción → Múltiples actualizaciones automáticas</strong>
                      <br>Sin intervención manual adicional
                    </div>
                  </div>
                </div>
                <button 
                  @click="resetearDemo" 
                  class="btn btn-automation"
                >
                  🔄 Ejecutar Otra Demo
                </button>
              </div>

              <!-- Resultado de error -->
              <div v-if="chainError" class="auto-result error-result">
                <h4>Error en Movimiento:</h4>
                <pre class="result-summary error">{{ chainError }}</pre>
                <button 
                  @click="resetearDemo" 
                  class="btn btn-secondary-small"
                >
                  🔄 Reintentar
                </button>
              </div>
            </div>
          </div>

          <!-- Demo 3: Guardián de Precios -->
          <div class="auto-card">
            <div class="auto-header">
              <div class="auto-icon">🛡️</div>
              <div class="auto-info">
                <h3 class="auto-title">Guardián de Precios</h3>
                <p class="auto-subtitle">Integridad Financiera - Automatización Preventiva</p>
              </div>
            </div>
            <div class="auto-content">
              <p class="auto-description">
                Demuestra cómo el sistema actúa como "guardián" previniendo precios inconsistentes automáticamente.
              </p>
              
              <!-- Paso 1: Mostrar estado inicial de precios -->
              <div class="demo-step" v-if="!precioActualVisible">
                <h4>Paso 1: Ver Estado Actual de Precios</h4>
                <div class="form-group">
                  <label>Museo:</label>
                  <select v-model="museoGuardian" class="form-control-small">
                    <option value="">Seleccione un museo...</option>
                    <option 
                      v-for="museo in museos" 
                      :key="museo.id_museo"
                      :value="museo.id_museo"
                    >
                      {{ museo.nombre }}
                    </option>
                  </select>
                </div>
                <div class="form-group">
                  <label>Tipo de Ticket:</label>
                  <select v-model="tipoTicketGuardian" class="form-control-small">
                    <option value="">Seleccione tipo de ticket...</option>
                    <option value="ADULTO">ADULTO</option>
                    <option value="ESTUDIANTE">ESTUDIANTE</option>
                    <option value="INFANTIL">INFANTIL</option>
                  </select>
                </div>
                <button 
                  @click="mostrarPrecioActual" 
                  :disabled="!museoGuardian || !tipoTicketGuardian || guardianLoading"
                  class="btn btn-automation-small"
                >
                  🔍 Ver Precio Actual
                </button>
              </div>

              <!-- Paso 2: Mostrar precio actual y formulario para nuevo precio -->
              <div class="demo-step" v-if="precioActualVisible && !guardianEjecutado">
                <h4>Estado Actual del Precio</h4>
                <div class="precio-actual" v-if="precioActual">
                  <div class="precio-info">
                    <strong>{{ tipoTicketGuardian }}</strong> en {{ nombreMuseoSeleccionado }}
                    <br>Precio actual: <span class="precio-valor">${{ precioActual.precio }}</span>
                    <br>Vigente desde: {{ formatearFecha(precioActual.fecha_inicio) }}
                    <br>Estado: <span class="estado-activo">ACTIVO (fecha_fin = NULL)</span>
                  </div>
                </div>

                <h4>Paso 2: Crear Nueva Tarifa (El Guardián en Acción)</h4>
                <div class="form-group">
                  <label>Nuevo Precio:</label>
                  <input 
                    v-model.number="nuevoPrecio" 
                    type="number" 
                    step="0.01" 
                    min="0"
                    class="form-control-small"
                    placeholder="Ej: 15.00"
                  >
                </div>
                <div class="form-group">
                  <label>Fecha de Inicio:</label>
                  <input 
                    v-model="fechaInicioPrecio" 
                    type="date"
                    class="form-control-small"
                  >
                </div>
                <div class="auto-controls">
                  <button 
                    @click="ejecutarGuardianPrecios" 
                    :disabled="!nuevoPrecio || !fechaInicioPrecio || guardianLoading"
                    class="btn btn-automation"
                  >
                    <span class="btn-icon">🛡️</span>
                    {{ guardianLoading ? 'Ejecutando Guardián...' : 'Activar Guardián de Precios' }}
                  </button>
                  <button 
                    @click="resetearGuardian" 
                    class="btn btn-secondary-small"
                  >
                    🔄 Reiniciar Demo
                  </button>
                </div>
              </div>

              <!-- Paso 3: Mostrar resultado del guardián -->
              <div class="demo-step" v-if="guardianEjecutado">
                <h4>🛡️ El Guardián de Precios Ha Actuado</h4>
                <div class="guardian-result">
                  <div class="evidencia">
                    <h5>📊 Evidencia 1: Precio Anterior Cerrado Automáticamente</h5>
                    <div class="evidencia-content">
                      ✅ El precio anterior de ${{ precioActual.precio }} ahora tiene <strong>fecha_fin</strong> automáticamente
                      <br>🤖 <em>Hecho por el trigger TRG_GESTIONAR_HISTORIAL_PRECIOS</em>
                      <br>📅 Fecha de cierre: {{ fechaInicioPrecio ? formatearFecha(new Date(fechaInicioPrecio + 'T00:00:00').getTime() - 86400000) : 'Un día antes del nuevo precio' }}
                    </div>
                  </div>
                  <div class="evidencia">
                    <h5>📊 Evidencia 2: Nuevo Precio Registrado</h5>
                    <div class="evidencia-content">
                      ✅ Nuevo precio de ${{ nuevoPrecio }} registrado exitosamente
                      <br>📅 Vigente desde: {{ formatearFecha(fechaInicioPrecio) }}
                      <br>🎯 <em>Sin solapamientos ni inconsistencias</em>
                    </div>
                  </div>
                  <div class="evidencia">
                    <h5>🛡️ Resultado del Guardián</h5>
                    <div class="evidencia-content">
                      <strong>Prevención automática de errores financieros</strong>
                      <br>El sistema garantiza historial de precios consistente
                      <br>Sin intervención manual adicional requerida
                    </div>
                  </div>
                </div>
                <button 
                  @click="resetearGuardian" 
                  class="btn btn-automation"
                >
                  🔄 Ejecutar Otra Demo
                </button>
              </div>

              <!-- Resultado de error -->
              <div v-if="guardianError" class="auto-result error-result">
                <h4>Error en Guardián de Precios:</h4>
                <pre class="result-summary error">{{ guardianError }}</pre>
                <button 
                  @click="resetearGuardian" 
                  class="btn btn-secondary-small"
                >
                  🔄 Reintentar
                </button>
              </div>
            </div>
          </div>

          <!-- Demo 4: Retroalimentación Analítica (placeholder para después) -->
          <div class="auto-card auto-disabled">
            <div class="auto-header">
              <div class="auto-icon">📊</div>
              <div class="auto-info">
                <h3 class="auto-title">Retroalimentación Analítica</h3>
                <p class="auto-subtitle">Ciclo de Vida de Ingresos - BI en Tiempo Real</p>
              </div>
            </div>
            <div class="auto-content">
              <p class="auto-description">
                Próximamente: Muestra cómo las transacciones impactan inmediatamente en las métricas del museo.
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Grid de Contenido -->
      <div class="dashboard-grid">
        
        <!-- Mantenimientos Pendientes -->
        <div class="dashboard-card">
          <div class="card-header">
            <h3 class="card-title">
              <span class="card-icon">⏳</span>
              Mantenimientos Pendientes
            </h3>
            <span class="card-badge">{{ dashboardData.mantenimientos_pendientes.length }}</span>
          </div>
          
          <div class="card-content">
            <div v-if="dashboardData.mantenimientos_pendientes.length === 0" class="empty-state">
              <span class="empty-icon">🎉</span>
              <p>¡Excelente! No hay mantenimientos pendientes</p>
            </div>
            
            <div v-else class="mantenimientos-list">
              <div 
                v-for="mant in dashboardData.mantenimientos_pendientes.slice(0, 5)" 
                :key="mant.id"
                class="mantenimiento-item"
                :class="getEstadoClass(mant.estado)"
              >
                <div class="mant-header">
                  <div class="mant-obra">{{ mant.obra }}</div>
                  <div class="mant-estado" :class="mant.estado.toLowerCase()">
                    {{ mant.estado }}
                  </div>
                </div>
                <div class="mant-details">
                  <div class="mant-actividad">{{ mant.actividad }}</div>
                  <div class="mant-meta">
                    <span class="mant-responsable">👤 {{ mant.responsable }}</span>
                    <span class="mant-fecha">📅 {{ formatearFecha(mant.fecha_inicio) }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Programas Activos -->
        <div class="dashboard-card">
          <div class="card-header">
            <h3 class="card-title">
              <span class="card-icon">🔄</span>
              Programas Activos
            </h3>
            <span class="card-badge">{{ dashboardData.programas_activos.length }}</span>
          </div>
          
          <div class="card-content">
            <div v-if="dashboardData.programas_activos.length === 0" class="empty-state">
              <span class="empty-icon">📝</span>
              <p>No hay programas de mantenimiento configurados</p>
            </div>
            
            <div v-else class="programas-list">
              <div 
                v-for="programa in dashboardData.programas_activos.slice(0, 5)" 
                :key="programa.id"
                class="programa-item"
              >
                <div class="programa-header">
                  <div class="programa-obra">{{ programa.obra }}</div>
                  <div class="programa-frecuencia">{{ programa.frecuencia }}</div>
                </div>
                <div class="programa-details">
                  <div class="programa-actividad">{{ programa.actividad }}</div>
                  <div class="programa-meta">
                    <span class="programa-responsable">👨‍🔧 {{ programa.tipo_responsable }}</span>
                    <span class="programa-contador">🔢 {{ programa.mantenimientos_realizados }} realizados</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Mantenimientos en Curso -->
        <div class="dashboard-card">
          <div class="card-header">
            <h3 class="card-title">
              <span class="card-icon">🔧</span>
              En Ejecución
            </h3>
            <span class="card-badge">{{ dashboardData.mantenimientos_en_curso.length }}</span>
          </div>
          
          <div class="card-content">
            <div v-if="dashboardData.mantenimientos_en_curso.length === 0" class="empty-state">
              <span class="empty-icon">💤</span>
              <p>No hay mantenimientos en ejecución actualmente</p>
            </div>
            
            <div v-else class="en-curso-list">
              <div 
                v-for="mant in dashboardData.mantenimientos_en_curso" 
                :key="mant.id"
                class="en-curso-item"
              >
                <div class="en-curso-header">
                  <div class="en-curso-obra">{{ mant.obra }}</div>
                  <div class="en-curso-dias">{{ mant.dias_transcurridos }} días</div>
                </div>
                <div class="en-curso-details">
                  <div class="en-curso-actividad">{{ mant.actividad }}</div>
                  <div class="en-curso-meta">
                    <span class="en-curso-responsable">👤 {{ mant.responsable }}</span>
                    <span class="en-curso-inicio">🚀 {{ formatearFecha(mant.fecha_inicio) }}</span>
                  </div>
                </div>
                <div class="progreso-tiempo">
                  <div class="progreso-bar" :style="calcularProgreso(mant.dias_transcurridos)"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Reporte de Eficiencia -->
        <div class="dashboard-card eficiencia-card">
          <div class="card-header">
            <h3 class="card-title">
              <span class="card-icon">📊</span>
              Reporte de Eficiencia
            </h3>
            <select v-model="periodoSeleccionado" @change="cargarReporteEficiencia" class="periodo-selector">
              <option value="mensual">Mensual</option>
              <option value="trimestral">Trimestral</option>
              <option value="anual">Anual</option>
            </select>
          </div>
          
          <div class="card-content">
            <div v-if="reporteEficiencia" class="eficiencia-content">
              <div class="eficiencia-kpis">
                <div class="eficiencia-kpi">
                  <div class="eficiencia-valor">{{ reporteEficiencia.kpis.porcentaje_completados_a_tiempo }}%</div>
                  <div class="eficiencia-label">Completados a Tiempo</div>
                </div>
                <div class="eficiencia-kpi">
                  <div class="eficiencia-valor">{{ reporteEficiencia.kpis.obras_con_mantenimiento_vencido }}</div>
                  <div class="eficiencia-label">Vencidos</div>
                </div>
                <div class="eficiencia-kpi">
                  <div class="eficiencia-valor">{{ reporteEficiencia.kpis.carga_promedio_por_empleado }}</div>
                  <div class="eficiencia-label">Carga por Empleado</div>
                </div>
              </div>
              
              <div class="empleados-rendimiento">
                <h4>Top Empleados</h4>
                <div 
                  v-for="empleado in reporteEficiencia.detalle_empleados.slice(0, 3)" 
                  :key="empleado.empleado"
                  class="empleado-rendimiento"
                >
                  <div class="empleado-info">
                    <div class="empleado-nombre">{{ empleado.empleado }}</div>
                    <div class="empleado-cargo">{{ empleado.cargo }}</div>
                  </div>
                  <div class="empleado-stats">
                    <div class="empleado-eficiencia">{{ empleado.eficiencia_porcentaje }}%</div>
                    <div class="empleado-asignados">{{ empleado.completados }}/{{ empleado.total_asignados }}</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Estados de carga y error -->
    <div v-if="loading" class="loading-state">
      <div class="loading-spinner">⏳</div>
      <p>Cargando dashboard de mantenimiento...</p>
    </div>

    <div v-if="error" class="error-state">
      <div class="error-icon">❌</div>
      <p>{{ error }}</p>
      <button @click="cargarDashboard" class="btn btn-primary">Reintentar</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DashboardMantenimientoView',
  data() {
    return {
      museos: [],
      museoSeleccionado: '',
      dashboardData: null,
      reporteEficiencia: null,
      periodoSeleccionado: 'trimestral',
      loading: false,
      error: null,
      // Variables para las automatizaciones
      consolidationLoading: false,
      consolidationResult: null,
      // Variables para Demo 2: Reacción en Cadena
      chainLoading: false,
      chainError: null,
      obraParaMover: null,
      obraSeleccionada: null,
      nuevaSala: null,
      movimientoEjecutado: false,
      obrasDisponibles: [],
      salasDisponibles: [],
      // Variables para Demo 3: Guardián de Precios
      guardianLoading: false,
      guardianError: null,
      museoGuardian: null,
      tipoTicketGuardian: null,
      precioActualVisible: false,
      precioActual: null,
      nombreMuseoSeleccionado: '',
      nuevoPrecio: null,
      fechaInicioPrecio: null,
      guardianEjecutado: false
    }
  },
  async mounted() {
    await this.cargarMuseos()
  },
  methods: {
    async cargarMuseos() {
      try {
        const response = await fetch('/api/museos')
        if (!response.ok) throw new Error('Error al cargar museos')
        this.museos = await response.json()
      } catch (error) {
        console.error('Error cargando museos:', error)
        this.error = 'Error al cargar la lista de museos'
      }
    },

    async cargarDashboard() {
      if (!this.museoSeleccionado) return

      this.loading = true
      this.error = null

      try {
        // Cargar dashboard principal
        const dashboardResponse = await fetch(`/api/dashboard/mantenimientos/${this.museoSeleccionado}`)
        if (!dashboardResponse.ok) throw new Error('Error al cargar dashboard')
        this.dashboardData = await dashboardResponse.json()

        // Cargar reporte de eficiencia
        await this.cargarReporteEficiencia()

        // Cargar datos para Demo 2: obras y salas disponibles
        await this.cargarObrasYSalas()

      } catch (error) {
        console.error('Error cargando dashboard:', error)
        this.error = error.message
      } finally {
        this.loading = false
      }
    },

    async cargarReporteEficiencia() {
      if (!this.museoSeleccionado) return

      try {
        const response = await fetch(
          `/api/reportes/eficiencia-mantenimiento/${this.museoSeleccionado}?periodo=${this.periodoSeleccionado}`
        )
        if (!response.ok) throw new Error('Error al cargar reporte de eficiencia')
        this.reporteEficiencia = await response.json()
      } catch (error) {
        console.error('Error cargando reporte de eficiencia:', error)
        // No mostrar error crítico, solo log
      }
    },

    formatearFecha(fecha) {
      if (!fecha) return 'Sin fecha'
      return new Date(fecha).toLocaleDateString('es-ES', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
      })
    },

    getEstadoClass(estado) {
      return {
        'estado-vencido': estado === 'VENCIDO',
        'estado-urgente': estado === 'URGENTE',
        'estado-pendiente': estado === 'PENDIENTE'
      }
    },

    calcularProgreso(dias) {
      // Estimamos que un mantenimiento típico dura 7 días
      const porcentaje = Math.min((dias / 7) * 100, 100)
      const color = dias > 7 ? '#ef4444' : dias > 5 ? '#f59e0b' : '#10b981'
      return {
        width: `${porcentaje}%`,
        backgroundColor: color
      }
    },

    async exportarReporte() {
      if (!this.dashboardData) return

      const reporte = {
        museo: this.museos.find(m => m.id == this.museoSeleccionado)?.nombre,
        fecha_generacion: new Date().toISOString(),
        estadisticas: this.dashboardData.estadisticas,
        programas_activos: this.dashboardData.programas_activos.length,
        mantenimientos_pendientes: this.dashboardData.mantenimientos_pendientes.length,
        mantenimientos_en_curso: this.dashboardData.mantenimientos_en_curso.length,
        eficiencia: this.reporteEficiencia?.kpis
      }

      // Crear y descargar archivo JSON
      const blob = new Blob([JSON.stringify(reporte, null, 2)], { type: 'application/json' })
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = `dashboard-mantenimiento-${this.museoSeleccionado}-${new Date().toISOString().split('T')[0]}.json`
      document.body.appendChild(a)
      a.click()
      document.body.removeChild(a)
      URL.revokeObjectURL(url)
    },

    // ============ MÉTODOS DE AUTOMATIZACIÓN ============
    async runDailyConsolidation() {
      if (!this.museoSeleccionado) {
        alert('Por favor seleccione un museo primero')
        return
      }

      this.consolidationLoading = true
      this.consolidationResult = null

      try {
        // Llama al backend, que a su vez ejecuta el Stored Procedure
        const response = await fetch('/api/run-consolidation', { 
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            museoId: this.museoSeleccionado,
            ejecutarAcciones: 'SI' // o 'NO' para solo reporte
          })
        })

        if (!response.ok) {
          throw new Error(`Error ${response.status}: ${response.statusText}`)
        }

        const data = await response.json()
        
        // Mostrar el resumen de la operación
        this.consolidationResult = data.summary || data.resumen_operaciones || 'Consolidación ejecutada exitosamente'
        
        // Refrescar el dashboard para ver los cambios
        await this.cargarDashboard()

      } catch (error) {
        console.error('Error ejecutando consolidación:', error)
        this.consolidationResult = `Error al ejecutar la consolidación: ${error.message}`
      } finally {
        this.consolidationLoading = false
      }
    },

    refreshDashboard() {
      // Alias para cargarDashboard para mantener compatibilidad con el doc de automatizaciones
      return this.cargarDashboard()
    },

    // ============ MÉTODOS PARA DEMO 3: GUARDIÁN DE PRECIOS ============
    async mostrarPrecioActual() {
      if (!this.museoGuardian || !this.tipoTicketGuardian) return

      this.guardianLoading = true
      this.guardianError = null

      try {
        console.log('[GUARDIAN] Obteniendo precio actual...')
        
        // Obtener nombre del museo seleccionado
        const museoSeleccionado = this.museos.find(m => m.id_museo == this.museoGuardian)
        this.nombreMuseoSeleccionado = museoSeleccionado ? museoSeleccionado.nombre : 'Museo desconocido'

        const response = await fetch(`/api/precio-actual/${this.museoGuardian}/${this.tipoTicketGuardian}`)
        
        if (response.ok) {
          const data = await response.json()
          this.precioActual = data.precio
          this.precioActualVisible = true
          
          // Establecer fecha de inicio por defecto (mañana)
          const mañana = new Date()
          mañana.setDate(mañana.getDate() + 1)
          this.fechaInicioPrecio = mañana.toISOString().split('T')[0]
          
          console.log('[GUARDIAN] Precio actual obtenido:', this.precioActual)
        } else {
          const errorData = await response.json()
          this.guardianError = errorData.error || 'Error obteniendo precio actual'
        }
      } catch (error) {
        console.error('[GUARDIAN] Error:', error)
        this.guardianError = 'Error de comunicación con el servidor'
      } finally {
        this.guardianLoading = false
      }
    },

    async ejecutarGuardianPrecios() {
      if (!this.museoGuardian || !this.tipoTicketGuardian || !this.nuevoPrecio || !this.fechaInicioPrecio) return

      this.guardianLoading = true
      this.guardianError = null

      try {
        console.log('[GUARDIAN] Ejecutando guardián de precios...')
        
        const response = await fetch('/api/guardian-precios', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            museoId: this.museoGuardian,
            tipoTicket: this.tipoTicketGuardian,
            nuevoPrecio: this.nuevoPrecio,
            fechaInicio: this.fechaInicioPrecio
          })
        })

        if (response.ok) {
          const data = await response.json()
          console.log('[GUARDIAN] Guardián ejecutado exitosamente:', data)
          this.guardianEjecutado = true
        } else {
          const errorData = await response.json()
          this.guardianError = errorData.error || 'Error ejecutando guardián de precios'
        }
      } catch (error) {
        console.error('[GUARDIAN] Error:', error)
        this.guardianError = 'Error de comunicación con el servidor'
      } finally {
        this.guardianLoading = false
      }
    },

    resetearGuardian() {
      this.museoGuardian = null
      this.tipoTicketGuardian = null
      this.precioActualVisible = false
      this.precioActual = null
      this.nombreMuseoSeleccionado = ''
      this.nuevoPrecio = null
      this.fechaInicioPrecio = null
      this.guardianEjecutado = false
      this.guardianError = null
      this.guardianLoading = false
    },

    formatearFecha(fecha) {
      if (!fecha) return 'N/A'
      
      if (typeof fecha === 'string') {
        return new Date(fecha).toLocaleDateString('es-ES')
      } else if (typeof fecha === 'number') {
        return new Date(fecha).toLocaleDateString('es-ES')
      } else if (fecha instanceof Date) {
        return fecha.toLocaleDateString('es-ES')
      }
      
      return fecha.toString()
    },

    // ============ MÉTODOS PARA DEMO 2: REACCIÓN EN CADENA ============
    async cargarObrasYSalas() {
      if (!this.museoSeleccionado) return

      try {
        // Cargar obras disponibles para mover
        const obrasResponse = await fetch(`/api/obras-disponibles/${this.museoSeleccionado}`)
        if (obrasResponse.ok) {
          this.obrasDisponibles = await obrasResponse.json()
        }

        // Cargar salas disponibles para destino
        const salasResponse = await fetch(`/api/salas-disponibles/${this.museoSeleccionado}`)
        if (salasResponse.ok) {
          this.salasDisponibles = await salasResponse.json()
        }
      } catch (error) {
        console.error('Error cargando obras y salas:', error)
      }
    },

    async mostrarEstadoInicial() {
      if (!this.obraParaMover) return

      this.chainLoading = true
      this.chainError = null

      try {
        // Obtener estado detallado de la obra seleccionada
        const response = await fetch(`/api/artworks/${this.obraParaMover.id}/status`)
        
        if (!response.ok) {
          throw new Error(`Error ${response.status}: ${response.statusText}`)
        }

        const estadoDetallado = await response.json()
        
        this.obraSeleccionada = {
          ...this.obraParaMover,
          id_historico: estadoDetallado.id_historico,
          ubicacion_actual: estadoDetallado.ubicacion_actual,
          estado_inicial: estadoDetallado
        }

        // Cargar salas disponibles si no están cargadas
        if (this.salasDisponibles.length === 0) {
          await this.cargarObrasYSalas()
        }

      } catch (error) {
        console.error('Error obteniendo estado inicial:', error)
        this.chainError = `Error al obtener estado inicial: ${error.message}`
      } finally {
        this.chainLoading = false
      }
    },

    async ejecutarMovimiento() {
      if (!this.obraSeleccionada || !this.nuevaSala) return

      this.chainLoading = true
      this.chainError = null

      try {
        // Ejecutar el movimiento de la obra (según el doc de automatizaciones)
        const response = await fetch(`/api/artworks/${this.obraSeleccionada.id}/move`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            newRoomId: this.nuevaSala
          })
        })

        if (!response.ok) {
          throw new Error(`Error ${response.status}: ${response.statusText}`)
        }

        const resultado = await response.json()
        
        // Marcar como ejecutado para mostrar los resultados
        this.movimientoEjecutado = true

        console.log('Movimiento ejecutado exitosamente:', resultado)

      } catch (error) {
        console.error('Error ejecutando movimiento:', error)
        this.chainError = `Error al mover la obra: ${error.message}`
      } finally {
        this.chainLoading = false
      }
    },

    resetearDemo() {
      // Resetear todas las variables de Demo 2
      this.obraParaMover = null
      this.obraSeleccionada = null
      this.nuevaSala = null
      this.movimientoEjecutado = false
      this.chainError = null
      this.chainLoading = false
    }
  }
}
</script>

<style scoped>
.dashboard-mantenimiento {
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem;
}

/* Header */
.page-header {
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 2px solid var(--gray-200);
}

.breadcrumb {
  display: flex;
  align-items: center;
  margin-bottom: 1rem;
  font-size: 0.875rem;
  color: var(--gray-600);
}

.breadcrumb-item.active {
  color: var(--primary-color);
  font-weight: 600;
}

.breadcrumb-separator {
  margin: 0 0.5rem;
  color: var(--gray-400);
}

.page-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 2rem;
  font-weight: 700;
  color: var(--gray-900);
  margin-bottom: 0.5rem;
}

.page-icon {
  font-size: 2.5rem;
}

.page-description {
  color: var(--gray-600);
  font-size: 1.125rem;
}

/* Controls */
.control-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: white;
  border-radius: 12px;
  box-shadow: var(--shadow-md);
  border: 1px solid var(--gray-200);
}

.museo-selector {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.museo-selector label {
  font-weight: 600;
  color: var(--gray-700);
}

.form-control {
  padding: 0.5rem 1rem;
  border: 2px solid var(--gray-300);
  border-radius: 6px;
  font-size: 1rem;
  min-width: 300px;
}

.dashboard-controls {
  display: flex;
  gap: 1rem;
}

.btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-primary {
  background: var(--primary-color);
  color: white;
}

.btn-secondary {
  background: var(--gray-200);
  color: var(--gray-700);
}

/* KPIs */
.kpis-section {
  margin-bottom: 2rem;
}

.section-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 1.5rem;
}

.kpis-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
}

.kpi-card {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  border: 1px solid var(--gray-200);
  box-shadow: var(--shadow-md);
  display: flex;
  align-items: center;
  gap: 1rem;
}

.kpi-icon {
  font-size: 2.5rem;
  opacity: 0.8;
}

.kpi-value {
  font-size: 1.75rem;
  font-weight: 700;
  color: var(--gray-900);
}

.kpi-label {
  font-size: 0.875rem;
  color: var(--gray-600);
  font-weight: 500;
}

/* Dashboard Grid */
.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.dashboard-card {
  background: white;
  border-radius: 12px;
  border: 1px solid var(--gray-200);
  box-shadow: var(--shadow-md);
  overflow: hidden;
}

.eficiencia-card {
  grid-column: span 2;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem;
  border-bottom: 1px solid var(--gray-200);
  background: var(--gray-50);
}

.card-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--gray-900);
  margin: 0;
}

.card-badge {
  background: var(--primary-color);
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.875rem;
  font-weight: 600;
}

.periodo-selector {
  padding: 0.25rem 0.5rem;
  border: 1px solid var(--gray-300);
  border-radius: 4px;
  font-size: 0.875rem;
}

.card-content {
  padding: 1.5rem;
  max-height: 400px;
  overflow-y: auto;
}

/* Empty States */
.empty-state {
  text-align: center;
  padding: 2rem;
  color: var(--gray-500);
}

.empty-icon {
  font-size: 3rem;
  display: block;
  margin-bottom: 1rem;
}

/* Mantenimientos */
.mantenimientos-list,
.programas-list,
.en-curso-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.mantenimiento-item,
.programa-item,
.en-curso-item {
  padding: 1rem;
  border: 1px solid var(--gray-200);
  border-radius: 8px;
  background: var(--gray-50);
}

.estado-vencido {
  border-left: 4px solid var(--error-color);
}

.estado-urgente {
  border-left: 4px solid var(--warning-color);
}

.estado-pendiente {
  border-left: 4px solid var(--primary-color);
}

.mant-header,
.programa-header,
.en-curso-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.mant-obra,
.programa-obra,
.en-curso-obra {
  font-weight: 600;
  color: var(--gray-900);
}

.mant-estado {
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
}

.mant-estado.vencido {
  background: var(--error-color);
  color: white;
}

.mant-estado.urgente {
  background: var(--warning-color);
  color: white;
}

.mant-estado.pendiente {
  background: var(--primary-color);
  color: white;
}

.programa-frecuencia,
.en-curso-dias {
  background: var(--primary-color);
  color: white;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
}

.mant-details,
.programa-details,
.en-curso-details {
  margin-bottom: 0.5rem;
}

.mant-actividad,
.programa-actividad,
.en-curso-actividad {
  font-size: 0.875rem;
  color: var(--gray-700);
  margin-bottom: 0.5rem;
}

.mant-meta,
.programa-meta,
.en-curso-meta {
  display: flex;
  gap: 1rem;
  font-size: 0.75rem;
  color: var(--gray-500);
}

.progreso-tiempo {
  height: 4px;
  background: var(--gray-200);
  border-radius: 2px;
  overflow: hidden;
}

.progreso-bar {
  height: 100%;
  transition: width 0.3s ease;
}

/* Eficiencia */
.eficiencia-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.eficiencia-kpis {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.eficiencia-kpi {
  text-align: center;
  padding: 1rem;
  background: var(--gray-50);
  border-radius: 8px;
}

.eficiencia-valor {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--primary-color);
}

.eficiencia-label {
  font-size: 0.875rem;
  color: var(--gray-600);
}

.empleados-rendimiento h4 {
  margin-bottom: 1rem;
  color: var(--gray-900);
}

.empleado-rendimiento {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem;
  background: var(--gray-50);
  border-radius: 6px;
  margin-bottom: 0.5rem;
}

.empleado-nombre {
  font-weight: 600;
  color: var(--gray-900);
}

.empleado-cargo {
  font-size: 0.75rem;
  color: var(--gray-500);
}

.empleado-eficiencia {
  font-weight: 600;
  color: var(--success-color);
}

.empleado-asignados {
  font-size: 0.75rem;
  color: var(--gray-500);
}

/* ============ ESTILOS PARA AUTOMATIZACIONES ============ */
.automatizaciones-section {
  margin-bottom: 3rem;
  padding: 2rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  color: white;
  box-shadow: var(--shadow-xl);
}

.automatizaciones-section .section-title {
  color: white;
  margin-bottom: 0.5rem;
}

.section-description {
  color: rgba(255, 255, 255, 0.9);
  font-size: 1.125rem;
  margin-bottom: 2rem;
}

.automatizaciones-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.auto-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  padding: 1.5rem;
  color: var(--gray-900);
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;
}

.auto-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-xl);
}

.auto-card.auto-disabled {
  opacity: 0.6;
  background: rgba(255, 255, 255, 0.7);
}

.auto-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

.auto-icon {
  font-size: 2.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
  border-radius: 12px;
  color: white;
}

.auto-info {
  flex: 1;
}

.auto-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--gray-900);
  margin-bottom: 0.25rem;
}

.auto-subtitle {
  font-size: 0.875rem;
  color: var(--gray-600);
  font-style: italic;
}

.auto-description {
  color: var(--gray-700);
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.auto-controls {
  margin-bottom: 1rem;
}

.btn-automation {
  background: linear-gradient(135deg, #10b981, #059669);
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  transition: all 0.3s ease;
  cursor: pointer;
  font-size: 0.875rem;
}

.btn-automation:hover:not(:disabled) {
  background: linear-gradient(135deg, #059669, #047857);
  transform: translateY(-1px);
  box-shadow: var(--shadow-md);
}

.btn-automation:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.auto-result {
  background: var(--gray-50);
  border-radius: 8px;
  padding: 1rem;
  border-left: 4px solid var(--success-color);
}

.auto-result h4 {
  color: var(--gray-900);
  font-size: 0.875rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.result-summary {
  background: var(--gray-900);
  color: #10b981;
  padding: 1rem;
  border-radius: 6px;
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  font-size: 0.75rem;
  line-height: 1.4;
  white-space: pre-wrap;
  margin: 0;
  max-height: 200px;
  overflow-y: auto;
}

.result-summary.error {
  color: #ff6b6b;
  background: #2d1b1b;
}

/* ============ ESTILOS PARA DEMO 2: REACCIÓN EN CADENA ============ */
.demo-step {
  margin-bottom: 1.5rem;
  padding: 1rem;
  background: var(--gray-50);
  border-radius: 8px;
  border-left: 4px solid var(--primary-color);
}

.demo-step h4 {
  color: var(--gray-900);
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 1rem;
}

.form-group {
  margin-bottom: 1rem;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: var(--gray-700);
  margin-bottom: 0.5rem;
  font-size: 0.875rem;
}

.form-control-small {
  width: 100%;
  padding: 0.5rem;
  border: 2px solid var(--gray-300);
  border-radius: 6px;
  font-size: 0.875rem;
  transition: border-color 0.3s ease;
}

.form-control-small:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.btn-automation-small {
  background: linear-gradient(135deg, #3b82f6, #1d4ed8);
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  font-weight: 600;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-automation-small:hover:not(:disabled) {
  background: linear-gradient(135deg, #1d4ed8, #1e3a8a);
  transform: translateY(-1px);
}

.btn-automation-small:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-secondary-small {
  background: var(--gray-200);
  color: var(--gray-700);
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  font-weight: 600;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-secondary-small:hover {
  background: var(--gray-300);
}

.estado-obra {
  background: white;
  padding: 1rem;
  border-radius: 6px;
  border: 1px solid var(--gray-200);
  margin-bottom: 1rem;
}

.obra-info {
  font-size: 0.875rem;
  line-height: 1.6;
  color: var(--gray-700);
}

.obra-info strong {
  color: var(--gray-900);
  font-size: 1rem;
}

.chain-result {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.evidencia {
  background: white;
  padding: 1rem;
  border-radius: 8px;
  border-left: 4px solid var(--success-color);
}

.evidencia h5 {
  color: var(--gray-900);
  font-size: 0.875rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.evidencia-content {
  font-size: 0.875rem;
  line-height: 1.6;
  color: var(--gray-700);
}

.evidencia-content strong {
  color: var(--gray-900);
}

.error-result {
  border-left-color: var(--error-color);
}

.error-result h4 {
  color: var(--error-color);
}

/* ============ ESTILOS PARA DEMO 3: GUARDIÁN DE PRECIOS ============ */
.precio-actual {
  background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
  border: 2px solid #0ea5e9;
  border-radius: 12px;
  padding: 1.5rem;
  margin: 1rem 0;
  position: relative;
}

.precio-actual::before {
  content: '💰';
  position: absolute;
  top: -10px;
  right: 15px;
  background: white;
  padding: 5px 10px;
  border-radius: 20px;
  font-size: 1.2rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.precio-info {
  font-size: 1rem;
  line-height: 1.6;
  color: #0c4a6e;
}

.precio-valor {
  font-size: 1.4rem;
  font-weight: bold;
  color: #059669;
  background: rgba(16, 185, 129, 0.1);
  padding: 2px 8px;
  border-radius: 6px;
}

.estado-activo {
  color: #dc2626;
  font-weight: 600;
  background: rgba(220, 38, 38, 0.1);
  padding: 2px 8px;
  border-radius: 6px;
}

.guardian-result {
  background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
  border: 2px solid #22c55e;
  border-radius: 12px;
  padding: 1.5rem;
  margin-top: 1rem;
}

.guardian-result .evidencia {
  background: white;
  border-radius: 8px;
  padding: 1rem;
  margin-bottom: 1rem;
  border-left: 4px solid #22c55e;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.guardian-result .evidencia:last-child {
  margin-bottom: 0;
}

.guardian-result .evidencia h5 {
  color: #166534;
  margin-bottom: 0.75rem;
  font-size: 1rem;
  font-weight: 600;
}

.guardian-result .evidencia-content {
  color: #374151;
  line-height: 1.5;
  font-size: 0.9rem;
}

/* Loading & Error States */
.loading-state,
.error-state {
  text-align: center;
  padding: 4rem;
  color: var(--gray-500);
}

.loading-spinner,
.error-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  display: block;
}

/* Responsive */
@media (max-width: 768px) {
  .dashboard-mantenimiento {
    padding: 1rem;
  }
  
  .control-section {
    flex-direction: column;
    gap: 1rem;
    align-items: stretch;
  }
  
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
  
  .eficiencia-card {
    grid-column: span 1;
  }
  
  .eficiencia-content {
    grid-template-columns: 1fr;
  }
  
  .kpis-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>