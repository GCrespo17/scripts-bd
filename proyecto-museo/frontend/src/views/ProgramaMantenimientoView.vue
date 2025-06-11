<template>
  <div class="programa-mantenimiento">
    <!-- Header con breadcrumb -->
    <div class="page-header">
      <div class="breadcrumb">
        <span class="breadcrumb-item">Sistema</span>
        <span class="breadcrumb-separator">→</span>
        <span class="breadcrumb-item active">Programa de Mantenimiento</span>
      </div>
      <h1 class="page-title">
        <span class="page-icon">🔧</span>
        Crear Programa de Mantenimiento
      </h1>
      <p class="page-description">
        Configure programas automáticos de mantenimiento para obras del museo
      </p>
    </div>

    <!-- Selector de Museo -->
    <div class="form-section">
      <h2 class="section-title">
        <span class="section-icon">🏛️</span>
        Selección de Museo
      </h2>
      <div class="form-group">
        <label for="museo">Museo:</label>
        <select 
          id="museo" 
          v-model="form.id_museo_selected" 
          @change="cargarObrasMuseo"
          :disabled="loading.museos"
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
        <div v-if="loading.museos" class="loading-spinner">Cargando museos...</div>
      </div>
    </div>

    <!-- Formulario Principal -->
    <div v-if="form.id_museo_selected" class="form-section">
      <h2 class="section-title">
        <span class="section-icon">📋</span>
        Configuración del Programa
      </h2>
      
      <!-- Selector de Obra con validación FK -->
      <div class="form-group">
        <label for="obra">Obra a Mantener:</label>
        <select 
          id="obra" 
          v-model="form.obra_seleccionada" 
          @change="cargarDatosObra"
          :disabled="loading.obras || obrasActivas.length === 0"
          class="form-control"
          required
        >
          <option value="">Seleccione una obra...</option>
          <option 
            v-for="obra in obrasActivas" 
            :key="`${obra.id_catalogo}-${obra.id_obra}`" 
            :value="obra"
          >
            {{ obra.nombre }} (Cat: {{ obra.id_catalogo }})
          </option>
        </select>
        <div v-if="loading.obras" class="loading-spinner">Cargando obras activas...</div>
        <div v-if="!loading.obras && obrasActivas.length === 0 && form.id_museo_selected" class="info-message">
          <span class="info-icon">ℹ️</span>
          No hay obras activas en este museo para programar mantenimiento
        </div>
      </div>

      <!-- Información de la obra seleccionada -->
      <div v-if="obraSeleccionadaInfo" class="obra-info-card">
        <h3 class="obra-info-title">
          <span class="obra-icon">🎨</span>
          Información de la Obra
        </h3>
        <div class="obra-details">
          <div class="detail-item">
            <strong>Nombre:</strong> {{ obraSeleccionadaInfo.nombre }}
          </div>
          <div class="detail-item">
            <strong>Tipo:</strong> {{ obraSeleccionadaInfo.tipo_obra }}
          </div>
          <div class="detail-item">
            <strong>Ubicación:</strong> {{ obraSeleccionadaInfo.ubicacion_actual }}
          </div>
          <div class="detail-item">
            <strong>Último Mantenimiento:</strong> 
            <span v-if="obraSeleccionadaInfo.ultimo_mantenimiento">
              {{ formatearUltimoMantenimiento(obraSeleccionadaInfo.ultimo_mantenimiento) }}
            </span>
            <span v-else class="sin-registros">Sin registros previos</span>
          </div>
        </div>
      </div>

      <!-- Descripción de la actividad -->
      <div class="form-group">
        <label for="actividad">Descripción de la Actividad:</label>
        <textarea 
          id="actividad"
          v-model="form.actividad" 
          placeholder="Describa detalladamente la actividad de mantenimiento a realizar..."
          class="form-control textarea-large"
          rows="4"
          required
        ></textarea>
        <div class="field-help">
          Describa específicamente qué tipo de mantenimiento se realizará (limpieza, restauración, revisión, etc.)
        </div>
      </div>

      <!-- Selector de frecuencia -->
      <div class="form-group">
        <label for="frecuencia">Frecuencia de Mantenimiento:</label>
        <select 
          id="frecuencia"
          v-model="form.frecuencia" 
          @change="calcularProximaFecha"
          class="form-control"
          required
        >
          <option value="">Seleccione frecuencia...</option>
          <option value="MENSUAL">Mensual (cada 30 días)</option>
          <option value="TRIMESTRAL">Trimestral (cada 90 días)</option>
          <option value="SEMESTRAL">Semestral (cada 180 días)</option>
          <option value="ANUAL">Anual (cada 365 días)</option>
        </select>
      </div>

      <!-- Tipo de responsable -->
      <div class="form-group">
        <label for="tipo_responsable">Tipo de Responsable:</label>
        <select 
          id="tipo_responsable"
          v-model="form.tipo_responsable" 
          @change="cargarEmpleadosDisponibles"
          class="form-control"
          required
        >
          <option value="">Seleccione tipo de responsable...</option>
          <option value="RESTAURADOR">Restaurador</option>
          <option value="CURADOR">Curador</option>
        </select>
        <div class="field-help">
          El sistema asignará automáticamente a un empleado disponible del tipo seleccionado
        </div>
      </div>

      <!-- Información de empleados disponibles -->
      <div v-if="empleadosDisponibles.length > 0" class="empleados-info-card">
        <h3 class="empleados-info-title">
          <span class="empleados-icon">👥</span>
          Seleccionar Empleado Responsable ({{ empleadosDisponibles.length }} disponibles)
        </h3>
        <div class="empleados-list">
          <div 
            v-for="empleado in empleadosDisponibles" 
            :key="empleado.id"
            class="empleado-item"
            :class="{ 'selected': form.empleado_seleccionado && form.empleado_seleccionado.id === empleado.id }"
            @click="seleccionarEmpleado(empleado)"
          >
            <div class="empleado-info">
              <span class="empleado-name">{{ empleado.nombre }}</span>
              <span class="empleado-cargo">{{ empleado.cargo }}</span>
              <span class="empleado-antiguedad">{{ empleado.antiguedad_años }} años de experiencia</span>
            </div>
            <div class="empleado-selection-indicator">
              <span v-if="form.empleado_seleccionado && form.empleado_seleccionado.id === empleado.id" class="selected-icon">✓</span>
              <span v-else class="select-icon">○</span>
            </div>
          </div>
        </div>
        <div class="selection-help">
          💡 <strong>Tip:</strong> Haz clic en un empleado para seleccionarlo como responsable del mantenimiento
        </div>
      </div>

      <!-- Alertas de validación -->
      <div v-if="form.tipo_responsable && empleadosDisponibles.length === 0" class="alert alert-warning">
        <span class="alert-icon">⚠️</span>
        <strong>Atención:</strong> No hay empleados del tipo "{{ form.tipo_responsable }}" disponibles en este museo.
        El programa se creará pero no se podrá ejecutar automáticamente hasta que haya personal disponible.
      </div>
      
      <div v-if="form.tipo_responsable && empleadosDisponibles.length > 0 && !form.empleado_seleccionado" class="alert alert-info">
        <span class="alert-icon">ℹ️</span>
        <strong>Selección requerida:</strong> Por favor, selecciona un empleado de la lista para continuar.
      </div>
    </div>

    <!-- Panel de vista previa de automatización -->
    <div v-if="form.frecuencia && form.obra_seleccionada" class="preview-section">
      <h2 class="section-title">
        <span class="section-icon">📅</span>
        Vista Previa de Automatización
      </h2>
      
      <div class="automation-preview-card">
        <div class="preview-grid">
          <div class="preview-item">
            <div class="preview-label">Próximo Mantenimiento</div>
            <div class="preview-value">{{ proximaFecha }}</div>
          </div>
          <div class="preview-item">
            <div class="preview-label">Responsable Sugerido</div>
            <div class="preview-value">{{ responsableSugerido }}</div>
          </div>
          <div class="preview-item">
            <div class="preview-label">Frecuencia</div>
            <div class="preview-value">{{ form.frecuencia }}</div>
          </div>
          <div class="preview-item">
            <div class="preview-label">Automatización</div>
            <div class="preview-value success">
              <span class="automation-icon">🤖</span>
              Activada
            </div>
          </div>
        </div>
        
        <div class="automation-explanation">
          <h4>¿Cómo funciona la automatización?</h4>
          <ul>
            <li>El sistema ejecutará <code>SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO</code> diariamente</li>
            <li>Cuando se cumpla la frecuencia, se creará automáticamente un registro en <code>MANTENIMIENTOS_OBRAS_REALIZADOS</code></li>
            <li>El <code>TRG_MANEJAR_MANTENIMIENTOS_OBRAS</code> cerrará mantenimientos anteriores automáticamente</li>
            <li>Se notificará al empleado asignado para ejecutar el mantenimiento</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Botones de acción -->
    <div class="form-actions">
      <button 
        type="button"
        @click="limpiarFormulario" 
        class="btn btn-secondary"
        :disabled="loading.saving"
      >
        <span class="btn-icon">🔄</span>
        Limpiar
      </button>
      
      <button 
        type="button"
        @click="guardarPrograma" 
        :disabled="!validacionCompleta || loading.saving"
        class="btn btn-primary"
      >
        <span v-if="loading.saving" class="btn-icon spinner">⏳</span>
        <span v-else class="btn-icon">💾</span>
        {{ loading.saving ? 'Guardando...' : 'Crear Programa de Mantenimiento' }}
      </button>
    </div>

    <!-- Alertas de resultado -->
    <div v-if="alertas.success" class="alert alert-success">
      <span class="alert-icon">✅</span>
      <strong>¡Éxito!</strong> {{ alertas.success }}
    </div>
    
    <div v-if="alertas.error" class="alert alert-error">
      <span class="alert-icon">❌</span>
      <strong>Error:</strong> {{ alertas.error }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProgramaMantenimientoView',
  data() {
    return {
      museos: [],
      obrasActivas: [],
      empleadosDisponibles: [],
      obraSeleccionadaInfo: null,
      form: {
        id_museo_selected: '',
        obra_seleccionada: null,
        actividad: '',
        frecuencia: '',
        tipo_responsable: '',
        empleado_seleccionado: null
      },
      loading: {
        museos: true,
        obras: false,
        saving: false
      },
      alertas: {
        success: '',
        error: ''
      },
      proximaFecha: '',
      responsableSugerido: ''
    }
  },
  computed: {
    validacionCompleta() {
      return (
        this.form.id_museo_selected &&
        this.form.obra_seleccionada &&
        this.form.actividad.trim().length >= 10 &&
        this.form.frecuencia &&
        this.form.tipo_responsable &&
        this.form.empleado_seleccionado
      )
    }
  },
  async mounted() {
    await this.cargarMuseos()
  },
  methods: {
    async cargarMuseos() {
      try {
        const response = await fetch('/api/museos')
        if (!response.ok) {
          const errorText = await response.text()
          throw new Error(`Error ${response.status}: ${errorText}`)
        }
        
        const data = await response.json()
        this.museos = data
        
        if (this.museos.length === 0) {
          this.alertas.error = 'No se encontraron museos en la base de datos'
        }
      } catch (error) {
        console.error('Error cargando museos:', error)
        this.alertas.error = `Error al cargar la lista de museos: ${error.message}`
      } finally {
        this.loading.museos = false
      }
    },

    async cargarObrasMuseo() {
      if (!this.form.id_museo_selected) {
        this.obrasActivas = []
        return
      }

      this.loading.obras = true
      this.obrasActivas = []
      this.form.obra_seleccionada = null
      this.obraSeleccionadaInfo = null

      try {
        const response = await fetch(`/api/obras-activas/museo/${this.form.id_museo_selected}`)
        if (!response.ok) throw new Error('Error al cargar obras')
        this.obrasActivas = await response.json()
      } catch (error) {
        console.error('Error cargando obras:', error)
        this.alertas.error = 'Error al cargar las obras del museo'
      } finally {
        this.loading.obras = false
      }
    },

    async cargarDatosObra() {
      if (!this.form.obra_seleccionada) {
        this.obraSeleccionadaInfo = null
        return
      }

      try {
        const response = await fetch(
          `/api/obras/${this.form.obra_seleccionada.id_obra}/detalles-mantenimiento`
        )
        if (!response.ok) throw new Error('Error al cargar detalles de obra')
        this.obraSeleccionadaInfo = await response.json()
        
        // Sugerir tipo de responsable basado en el tipo de obra
        if (this.obraSeleccionadaInfo.tipo_obra === 'PINTURA') {
          this.form.tipo_responsable = 'RESTAURADOR'
        } else if (this.obraSeleccionadaInfo.tipo_obra === 'ESCULTURA') {
          this.form.tipo_responsable = 'CURADOR'
        }
        
        if (this.form.tipo_responsable) {
          await this.cargarEmpleadosDisponibles()
        }
      } catch (error) {
        console.error('Error cargando detalles de obra:', error)
        this.alertas.error = 'Error al cargar los detalles de la obra'
      }
    },

    async cargarEmpleadosDisponibles() {
      if (!this.form.tipo_responsable || !this.form.id_museo_selected) {
        this.empleadosDisponibles = []
        return
      }

      try {
        const endpoint = this.form.tipo_responsable === 'RESTAURADOR' ? 'restauradores' : 'curadores'
        const response = await fetch(`/api/empleados/${endpoint}/${this.form.id_museo_selected}`)
        if (!response.ok) throw new Error('Error al cargar empleados')
        this.empleadosDisponibles = await response.json()
        
        // Limpiar selección previa al cambiar tipo de responsable
        this.form.empleado_seleccionado = null
        this.responsableSugerido = 'Seleccione un empleado'
      } catch (error) {
        console.error('Error cargando empleados:', error)
        this.empleadosDisponibles = []
        this.responsableSugerido = 'Error al cargar'
      }
    },

    seleccionarEmpleado(empleado) {
      this.form.empleado_seleccionado = empleado
      this.responsableSugerido = `${empleado.nombre} (${empleado.cargo})`
    },

    calcularProximaFecha() {
      if (!this.form.frecuencia) {
        this.proximaFecha = ''
        return
      }

      const hoy = new Date()
      let proximaFecha = new Date(hoy)

      switch (this.form.frecuencia) {
        case 'MENSUAL':
          proximaFecha.setDate(proximaFecha.getDate() + 30)
          break
        case 'TRIMESTRAL':
          proximaFecha.setDate(proximaFecha.getDate() + 90)
          break
        case 'SEMESTRAL':
          proximaFecha.setDate(proximaFecha.getDate() + 180)
          break
        case 'ANUAL':
          proximaFecha.setFullYear(proximaFecha.getFullYear() + 1)
          break
      }

      this.proximaFecha = proximaFecha.toLocaleDateString('es-ES', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      })
    },

    async guardarPrograma() {
      this.limpiarAlertas()
      this.loading.saving = true

      try {
        const payload = {
          id_catalogo: this.form.obra_seleccionada.id_catalogo,
          id_obra: this.form.obra_seleccionada.id_obra,
          id_museo: this.form.id_museo_selected,
          actividad: this.form.actividad.trim(),
          frecuencia: this.form.frecuencia,
          tipo_responsable: this.form.tipo_responsable,
          id_empleado_responsable: this.form.empleado_seleccionado.id
        }

        const response = await fetch('/api/programas-mant', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(payload)
        })

        const result = await response.json()

        if (!response.ok) {
          throw new Error(result.error || result.message || 'Error desconocido')
        }

        this.alertas.success = result.message + 
          (result.automatizacion_activada ? ' Automatización iniciada inmediatamente.' : '')
        
        // Limpiar formulario después del éxito
        setTimeout(() => {
          this.limpiarFormulario()
        }, 3000)

      } catch (error) {
        console.error('Error guardando programa:', error)
        this.alertas.error = error.message
      } finally {
        this.loading.saving = false
      }
    },

    limpiarFormulario() {
      this.form = {
        id_museo_selected: '',
        obra_seleccionada: null,
        actividad: '',
        frecuencia: '',
        tipo_responsable: '',
        empleado_seleccionado: null
      }
      this.obrasActivas = []
      this.empleadosDisponibles = []
      this.obraSeleccionadaInfo = null
      this.proximaFecha = ''
      this.responsableSugerido = ''
      this.limpiarAlertas()
    },

    limpiarAlertas() {
      this.alertas.success = ''
      this.alertas.error = ''
    },

    formatearUltimoMantenimiento(ultimoMant) {
      if (!ultimoMant) return 'Sin registros previos'
      
      const fecha = new Date(ultimoMant.fecha).toLocaleDateString('es-ES', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      })
      
      let resultado = `${fecha} por ${ultimoMant.responsable}`
      
      if (ultimoMant.observaciones) {
        resultado += ` - ${ultimoMant.observaciones}`
      }
      
      return resultado
    }
  }
}
</script>

<style scoped>
.programa-mantenimiento {
  max-width: 1200px;
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

/* Sections */
.form-section {
  background: white;
  border-radius: 12px;
  padding: 2rem;
  margin-bottom: 2rem;
  box-shadow: var(--shadow-md);
  border: 1px solid var(--gray-200);
}

.preview-section {
  background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
  border-radius: 12px;
  padding: 2rem;
  margin-bottom: 2rem;
  border: 2px solid var(--primary-color);
}

.section-title {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-900);
  margin-bottom: 1.5rem;
}

.section-icon {
  font-size: 1.75rem;
}

/* Form Controls */
.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: var(--gray-700);
}

.form-control {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 2px solid var(--gray-300);
  border-radius: 8px;
  font-size: 1rem;
  transition: all 0.2s ease;
}

.form-control:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.form-control:disabled {
  background-color: var(--gray-100);
  color: var(--gray-500);
  cursor: not-allowed;
}

.textarea-large {
  min-height: 120px;
  resize: vertical;
}

.field-help {
  margin-top: 0.25rem;
  font-size: 0.875rem;
  color: var(--gray-500);
}

/* Info Cards */
.obra-info-card,
.empleados-info-card {
  background: var(--gray-50);
  border: 1px solid var(--gray-200);
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
}

.obra-info-title,
.empleados-info-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--gray-800);
  margin-bottom: 1rem;
}

.obra-details {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 0.75rem;
}

.detail-item {
  color: var(--gray-700);
}

.sin-registros {
  color: var(--gray-500);
  font-style: italic;
}

.empleados-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.empleado-item {
  background: white;
  padding: 1rem;
  border-radius: 8px;
  border: 2px solid var(--gray-300);
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
  overflow: hidden;
}

.empleado-item:hover {
  border-color: var(--primary-color);
  transform: translateY(-1px);
  box-shadow: var(--shadow-md);
}

.empleado-item.selected {
  border-color: var(--primary-color);
  background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
}

.empleado-item.selected::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 4px;
  background: var(--primary-color);
}

.empleado-info {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.empleado-name {
  font-weight: 600;
  color: var(--gray-800);
  font-size: 1rem;
}

.empleado-cargo {
  font-size: 0.875rem;
  color: var(--gray-600);
  font-weight: 500;
}

.empleado-antiguedad {
  font-size: 0.75rem;
  color: var(--gray-500);
}

.empleado-selection-indicator {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  transition: all 0.2s ease;
}

.selected-icon {
  color: var(--primary-color);
  font-size: 1.125rem;
  font-weight: bold;
}

.select-icon {
  color: var(--gray-400);
  font-size: 1.125rem;
  border: 2px solid var(--gray-300);
  border-radius: 50%;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.empleado-item:hover .select-icon {
  border-color: var(--primary-color);
  color: var(--primary-color);
}

.selection-help {
  margin-top: 1rem;
  padding: 0.75rem;
  background: var(--gray-100);
  border-radius: 6px;
  font-size: 0.875rem;
  color: var(--gray-600);
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

/* Preview Card */
.automation-preview-card {
  background: white;
  border-radius: 12px;
  padding: 2rem;
  border: 1px solid var(--primary-color);
}

.preview-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.preview-item {
  text-align: center;
  padding: 1rem;
  background: var(--gray-50);
  border-radius: 8px;
  border: 1px solid var(--gray-200);
}

.preview-label {
  font-size: 0.875rem;
  color: var(--gray-600);
  margin-bottom: 0.5rem;
  font-weight: 500;
}

.preview-value {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--gray-900);
}

.preview-value.success {
  color: var(--success-color);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.automation-explanation {
  background: var(--gray-50);
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid var(--primary-color);
}

.automation-explanation h4 {
  margin-bottom: 1rem;
  color: var(--gray-800);
}

.automation-explanation ul {
  list-style: none;
  padding: 0;
}

.automation-explanation li {
  margin-bottom: 0.5rem;
  padding-left: 1rem;
  position: relative;
}

.automation-explanation li::before {
  content: "→";
  position: absolute;
  left: 0;
  color: var(--primary-color);
  font-weight: bold;
}

.automation-explanation code {
  background: var(--gray-200);
  padding: 0.125rem 0.25rem;
  border-radius: 3px;
  font-family: 'Courier New', monospace;
  font-size: 0.875rem;
}

/* Buttons */
.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 1px solid var(--gray-200);
}

.btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-primary {
  background: var(--primary-color);
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background: var(--primary-dark);
  transform: translateY(-1px);
  box-shadow: var(--shadow-md);
}

.btn-secondary {
  background: var(--gray-200);
  color: var(--gray-700);
}

.btn-secondary:hover:not(:disabled) {
  background: var(--gray-300);
}

.btn-icon {
  font-size: 1.125rem;
}

.spinner {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* Alerts */
.alert {
  padding: 1rem 1.5rem;
  border-radius: 8px;
  margin-top: 1rem;
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.alert-success {
  background: #ecfdf5;
  border: 1px solid #86efac;
  color: #047857;
}

.alert-error {
  background: #fef2f2;
  border: 1px solid #fca5a5;
  color: #dc2626;
}

.alert-warning {
  background: #fffbeb;
  border: 1px solid #fed7aa;
  color: #d97706;
}

.alert-info {
  background: #f0f9ff;
  border: 1px solid #93c5fd;
  color: #1d4ed8;
}

.alert-icon {
  font-size: 1.25rem;
  flex-shrink: 0;
}

.info-message {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem;
  background: var(--gray-50);
  border: 1px solid var(--gray-200);
  border-radius: 6px;
  color: var(--gray-600);
  font-size: 0.875rem;
  margin-top: 0.5rem;
}

.loading-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  color: var(--gray-500);
  font-style: italic;
}

/* Responsive */
@media (max-width: 768px) {
  .programa-mantenimiento {
    padding: 1rem;
  }
  
  .form-section,
  .preview-section {
    padding: 1.5rem;
  }
  
  .preview-grid {
    grid-template-columns: 1fr;
  }
  
  .obra-details {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .btn {
    justify-content: center;
  }
}
</style>