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
      error: null
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