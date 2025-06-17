<template>
  <div class="test-procedures-container">
    <div class="header">
      <h1 class="title">🧪 Testing de Procedimientos Almacenados</h1>
      <p class="description">
        Herramienta para probar y validar los procedimientos almacenados de la base de datos del sistema de museos.
      </p>
    </div>

    <!-- Selector de Procedimiento -->
    <div class="procedure-selector">
      <label for="procedure-select" class="label">Seleccionar Procedimiento:</label>
      <select 
        id="procedure-select" 
        v-model="selectedProcedure" 
        @change="onProcedureChange"
        class="select"
      >
        <option value="">-- Seleccione un procedimiento --</option>
        <optgroup 
          v-for="(procedures, category) in proceduresByCategory" 
          :key="category" 
          :label="category"
        >
          <option 
            v-for="procedure in procedures" 
            :key="procedure.name" 
            :value="procedure.name"
          >
            {{ procedure.name }} - {{ procedure.description }}
          </option>
        </optgroup>
      </select>
    </div>

    <!-- Formulario Dinámico -->
    <div v-if="currentProcedure" class="procedure-form">
      <div class="procedure-info">
        <h2>{{ currentProcedure.name }}</h2>
        <p>{{ currentProcedure.description }}</p>
        <span class="category-badge">{{ currentProcedure.category }}</span>
      </div>

      <form @submit.prevent="executeProcedure" class="form">
        <div class="input-grid">
          <div 
            v-for="param in currentProcedure.inputParams" 
            :key="param.name"
            class="input-group"
          >
            <label :for="param.name" class="input-label">
              {{ param.label }}
              <span v-if="param.required" class="required">*</span>
            </label>

            <!-- Campo de texto -->
            <input 
              v-if="param.type === 'text'" 
              :id="param.name"
              v-model="formData[param.name]"
              type="text"
              :required="param.required"
              class="input"
              :placeholder="`Ingrese ${param.label.toLowerCase()}`"
            />

            <!-- Campo numérico -->
            <input 
              v-else-if="param.type === 'number'" 
              :id="param.name"
              v-model.number="formData[param.name]"
              type="number"
              :required="param.required"
              class="input"
              :placeholder="`Ingrese ${param.label.toLowerCase()}`"
            />

            <!-- Campo de fecha -->
            <input 
              v-else-if="param.type === 'date'" 
              :id="param.name"
              v-model="formData[param.name]"
              type="date"
              :required="param.required"
              class="input"
            />

            <!-- Campo de selección estática -->
            <select 
              v-else-if="param.type === 'select'" 
              :id="param.name"
              v-model="formData[param.name]"
              :required="param.required"
              class="select"
            >
              <option value="">-- Seleccione una opción --</option>
              <option 
                v-for="option in param.options" 
                :key="option" 
                :value="option"
              >
                {{ option }}
              </option>
            </select>

            <!-- Campo de dropdown dinámico -->
            <select 
              v-else-if="param.type === 'dropdown'" 
              :id="param.name"
              v-model="formData[param.name]"
              :required="param.required"
              :disabled="loadingSupportData"
              class="select"
              @change="onFieldChange(param.name, formData[param.name])"
            >
              <option value="" v-if="loadingSupportData">🔄 Cargando datos...</option>
              <option value="" v-else-if="getDropdownOptions(param).length === 0">⚠️ No hay datos disponibles</option>
              <option value="" v-else>-- Seleccione {{ getDropdownLabel(param) }} --</option>
              <option 
                v-for="item in getDropdownOptions(param)" 
                :key="getOptionKey(item, param)" 
                :value="getOptionValue(item, param)"
              >
                {{ getOptionLabel(item, param) }}
              </option>
            </select>

            <!-- Campo genérico -->
            <input 
              v-else
              :id="param.name"
              v-model="formData[param.name]"
              type="text"
              :required="param.required"
              class="input"
              :placeholder="`Ingrese ${param.label.toLowerCase()}`"
            />
          </div>
        </div>

        <div class="form-actions">
          <button 
            type="button" 
            @click="clearForm"
            class="btn btn-secondary"
            :disabled="loading"
          >
            Limpiar
          </button>
          <button 
            type="submit" 
            class="btn btn-primary"
            :disabled="loading"
          >
            <span v-if="loading">⏳ Ejecutando...</span>
            <span v-else>▶ Ejecutar Procedimiento</span>
          </button>
        </div>
      </form>
    </div>

    <!-- Resultados -->
    <div v-if="lastResult" class="results">
      <h3>📊 Resultados de la Ejecución</h3>
      
      <div class="result-status" :class="lastResult.success ? 'success' : 'error'">
        <div class="status-indicator">
          <span v-if="lastResult.success">✅</span>
          <span v-else>❌</span>
        </div>
        <div class="status-message">
          {{ lastResult.message }}
        </div>
      </div>

      <!-- Parámetros de salida -->
      <div v-if="lastResult.success && lastResult.outParameters && Object.keys(lastResult.outParameters).length > 0" class="output-params">
        <h4>📤 Parámetros de Salida:</h4>
        <div class="param-list">
          <div 
            v-for="(value, key) in lastResult.outParameters" 
            :key="key"
            class="param-item"
          >
            <span class="param-name">{{ key }}:</span>
            <span class="param-value">{{ value }}</span>
          </div>
        </div>
      </div>

      <!-- Información adicional -->
      <div v-if="lastResult.success" class="execution-info">
        <div class="info-item">
          <span class="info-label">Filas afectadas:</span>
          <span class="info-value">{{ lastResult.affectedRows || 0 }}</span>
        </div>
        <div class="info-item">
          <span class="info-label">Tiempo de ejecución:</span>
          <span class="info-value">{{ executionTime }}ms</span>
        </div>
      </div>

      <!-- Error details -->
      <div v-if="!lastResult.success && lastResult.error" class="error-details">
        <h4>🔍 Detalles del Error:</h4>
        <pre>{{ lastResult.error }}</pre>
        <div v-if="lastResult.code" class="error-code">
          Código de error: <code>{{ lastResult.code }}</code>
        </div>
      </div>
    </div>

    <!-- Historial -->
    <div v-if="executionHistory.length > 0" class="history">
      <h3>📚 Historial de Ejecuciones</h3>
      <div class="history-list">
        <div 
          v-for="(execution, index) in executionHistory.slice().reverse()" 
          :key="index"
          class="history-item"
          :class="execution.success ? 'success' : 'error'"
        >
          <div class="history-header">
            <span class="procedure-name">{{ execution.procedureName }}</span>
            <span class="timestamp">{{ formatTime(execution.timestamp) }}</span>
            <span class="status-icon">{{ execution.success ? '✅' : '❌' }}</span>
          </div>
          <div class="history-message">{{ execution.message }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, computed, onMounted } from 'vue'

export default {
  name: 'TestProceduresView',
  setup() {
    const procedures = ref({})
    const supportData = ref({
      museos: [],
      empleados: [],
      obras: [],
      colecciones: [],
      salas: [],
      exposiciones: [],
      unidadesOrganizacionales: [],
      estructurasFisicas: [],
      mantenimientos: [],
      vigilantes: [],
      artistas: [],
      departamentos: [],
      tiposObra: [],
      tiposAdquisicion: [],
      cargos: [],
      tiposResponsable: [],
      turnos: [],
      tiposMantenimiento: [],
      tiposTicket: []
    })
    const selectedProcedure = ref('')
    const formData = reactive({})
    const loading = ref(false)
    const loadingSupportData = ref(true)
    const lastResult = ref(null)
    const executionHistory = ref([])
    const executionTime = ref(0)

    const currentProcedure = computed(() => {
      return procedures.value[selectedProcedure.value] || null
    })

    const proceduresByCategory = computed(() => {
      const categories = {}
      Object.values(procedures.value).forEach(procedure => {
        if (!categories[procedure.category]) {
          categories[procedure.category] = []
        }
        categories[procedure.category].push(procedure)
      })
      return categories
    })

    const loadProcedures = async () => {
      try {
        const response = await fetch('/api/procedures')
        if (!response.ok) throw new Error('Error cargando procedimientos')
        procedures.value = await response.json()
      } catch (error) {
        console.error('Error cargando procedimientos:', error)
      }
    }

    const loadSupportData = async () => {
      try {
        console.log('[FRONTEND] Iniciando carga de datos de apoyo...')
        
        // Primero probar endpoint simple
        try {
          const testResponse = await fetch('/api/museos-simple')
          console.log('[FRONTEND] Test response status:', testResponse.status)
          if (testResponse.ok) {
            const testData = await testResponse.json()
            console.log('[FRONTEND] Test data:', testData)
          }
        } catch (testError) {
          console.error('[FRONTEND] Error en test endpoint:', testError)
        }
        
        // Luego cargar datos completos
        const response = await fetch('/api/support-data')
        console.log('[FRONTEND] Support-data response status:', response.status)
        
        if (!response.ok) {
          const errorText = await response.text()
          console.error('[FRONTEND] Error response:', errorText)
          throw new Error(`Error cargando datos de apoyo: ${response.status} - ${errorText}`)
        }
        
        const data = await response.json()
        console.log('[FRONTEND] Datos cargados:', data)
        console.log('[FRONTEND] Museos encontrados:', data.museos?.length || 0)
        
        supportData.value = data
        
        // Verificar que los museos se cargaron
        if (data.museos && data.museos.length > 0) {
          console.log('[FRONTEND] ✅ Museos cargados correctamente:', data.museos.slice(0, 3))
        } else {
          console.warn('[FRONTEND] ⚠️ No se encontraron museos')
        }
        
      } catch (error) {
        console.error('[FRONTEND] Error cargando datos de apoyo:', error)
        // Inicializar con datos vacíos para evitar errores
        supportData.value = {
          museos: [],
          empleados: [],
          obras: [],
          colecciones: [],
          salas: [],
          exposiciones: [],
          unidadesOrganizacionales: [],
          estructurasFisicas: [],
          mantenimientos: [],
          vigilantes: [],
          artistas: [],
          departamentos: [],
          tiposObra: [],
          tiposAdquisicion: [],
          cargos: [],
          tiposResponsable: [],
          turnos: [],
          tiposMantenimiento: [],
          tiposTicket: []
        }
      } finally {
        loadingSupportData.value = false
      }
    }

    const onProcedureChange = () => {
      clearForm()
      lastResult.value = null
    }

    const clearForm = () => {
      Object.keys(formData).forEach(key => {
        delete formData[key]
      })
    }

    // Función para limpiar campos dependientes cuando cambia un campo padre
    const onFieldChange = (paramName, value) => {
      console.log(`[FIELD-CHANGE] ${paramName} cambió a:`, value)
      
      // Si cambió el museo, limpiar todos los campos dependientes
      const esCampoMuseo = paramName.includes('museo') || paramName.includes('id_museo') 
      if (esCampoMuseo) {
        console.log('[FIELD-CHANGE] Campo de museo cambió, limpiando campos dependientes...')
        
        // Lista de campos que dependen del museo
        const camposDependientes = [
          'p_nombre_unidad_org', 'n_nombre_unidad_org', 'n_id_est_org',
          'p_id_coleccion', 'n_id_coleccion', 'p_id_coleccion_destino',
          'p_id_sala', 'n_id_sala', 'p_id_sala_destino', 'n_id_sala',
          'p_id_empleado_responsable', 'n_id_empleado', 'p_id_empleado_destino',
          'n_id_est', 'p_id_expo'
        ]
        
        // Limpiar campos dependientes (pero no el campo que cambió)
        camposDependientes.forEach(campo => {
          if (formData[campo] && campo !== paramName) {
            console.log(`[FIELD-CHANGE] Limpiando ${campo}`)
            formData[campo] = ''
          }
        })
      }
    }

    const executeProcedure = async () => {
      if (!selectedProcedure.value) return

      loading.value = true
      const startTime = Date.now()

      try {
        const response = await fetch('/api/test-procedure', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            procedureName: selectedProcedure.value,
            parameters: { ...formData }
          })
        })

        const result = await response.json()
        executionTime.value = Date.now() - startTime
        lastResult.value = result

        // Agregar al historial
        executionHistory.value.push({
          procedureName: selectedProcedure.value,
          timestamp: new Date(),
          success: result.success,
          message: result.message,
          parameters: { ...formData }
        })

        // Mantener solo los últimos 10 resultados
        if (executionHistory.value.length > 10) {
          executionHistory.value = executionHistory.value.slice(-10)
        }

      } catch (error) {
        console.error('Error ejecutando procedimiento:', error)
        lastResult.value = {
          success: false,
          message: 'Error de comunicación con el servidor',
          error: error.message
        }
        executionTime.value = Date.now() - startTime
      } finally {
        loading.value = false
      }
    }

    const formatTime = (date) => {
      return date.toLocaleTimeString('es-ES', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      })
    }

    // Funciones auxiliares para dropdowns dinámicos
    const getDropdownOptions = (param) => {
      console.log(`[DROPDOWN] Obteniendo opciones para ${param.name}, dataSource: ${param.dataSource}`)
      
      if (!param.dataSource) {
        console.warn(`[DROPDOWN] No dataSource para ${param.name}`)
        return []
      }
      
      if (!supportData.value[param.dataSource]) {
        console.warn(`[DROPDOWN] No existe supportData.${param.dataSource}`)
        console.log('[DROPDOWN] supportData disponible:', Object.keys(supportData.value))
        return []
      }
      
      let options = supportData.value[param.dataSource]
      
      // === FILTRADO REACTIVO BASADO EN OTROS CAMPOS ===
      
      // Detectar el ID de museo seleccionado (puede tener diferentes nombres según el procedimiento)
      const museoSeleccionado = formData.p_id_museo || formData.n_id_museo || formData.id_museo
      
      if (museoSeleccionado) {
        console.log(`[DROPDOWN] Museo seleccionado: ${museoSeleccionado}`)
        
        // Si es unidades organizacionales, filtrar por museo
        if (param.dataSource === 'unidadesOrganizacionales') {
          console.log(`[DROPDOWN] Filtrando unidades organizacionales para museo: ${museoSeleccionado}`)
          options = options.filter(unidad => unidad.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Unidades filtradas: ${options.length}`)
        }
        
        // Si son salas, filtrar por museo
        if (param.dataSource === 'salas') {
          console.log(`[DROPDOWN] Filtrando salas para museo: ${museoSeleccionado}`)
          options = options.filter(sala => sala.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Salas filtradas: ${options.length}`)
        }
        
        // Si son colecciones, filtrar por museo
        if (param.dataSource === 'colecciones') {
          console.log(`[DROPDOWN] Filtrando colecciones para museo: ${museoSeleccionado}`)
          options = options.filter(coleccion => coleccion.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Colecciones filtradas: ${options.length}`)
        }
        
        // Si son estructuras físicas, filtrar por museo
        if (param.dataSource === 'estructurasFisicas') {
          console.log(`[DROPDOWN] Filtrando estructuras físicas para museo: ${museoSeleccionado}`)
          options = options.filter(estructura => estructura.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Estructuras físicas filtradas: ${options.length}`)
        }
        
        // Si son empleados, filtrar por museo (si está disponible)
        if (param.dataSource === 'empleados' && options.length > 0 && options[0].id_museo) {
          console.log(`[DROPDOWN] Filtrando empleados para museo: ${museoSeleccionado}`)
          options = options.filter(empleado => empleado.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Empleados filtrados: ${options.length}`)
        }
        
        // Si son exposiciones, filtrar por museo
        if (param.dataSource === 'exposiciones') {
          console.log(`[DROPDOWN] Filtrando exposiciones para museo: ${museoSeleccionado}`)
          options = options.filter(exposicion => exposicion.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Exposiciones filtradas: ${options.length}`)
        }
      }
      
      console.log(`[DROPDOWN] ${param.dataSource} devolviendo ${options.length} opciones finales`)
      return options
    }

    const getDropdownLabel = (param) => {
      const labels = {
        museos: 'un museo',
        empleados: 'un empleado',
        obras: 'una obra',
        colecciones: 'una colección',
        salas: 'una sala',
        exposiciones: 'una exposición',
        unidadesOrganizacionales: 'una unidad organizacional',
        estructurasFisicas: 'una estructura física',
        mantenimientos: 'un mantenimiento',
        vigilantes: 'un vigilante',
        artistas: 'un artista',
        departamentos: 'un departamento',
        tiposObra: 'un tipo de obra',
        tiposAdquisicion: 'un tipo de adquisición',
        cargos: 'un cargo',
        tiposResponsable: 'un tipo de responsable',
        turnos: 'un turno',
        tiposMantenimiento: 'un tipo de mantenimiento',
        tiposTicket: 'un tipo de ticket'
      }
      return labels[param.dataSource] || 'una opción'
    }

    const getOptionKey = (item, param) => {
      if (typeof item === 'object') {
        return item.id || item.nombre || item
      }
      return item
    }

    const getOptionValue = (item, param) => {
      if (typeof item === 'object') {
        // Para campos que esperan el nombre en lugar del ID
        if (param.displayField && param.displayField !== 'id') {
          return item[param.displayField] || item.nombre || item.id
        }
        return item.id
      }
      return item
    }

    const getOptionLabel = (item, param) => {
      if (typeof item === 'object') {
        if (item.id && (item.nombre || item.titulo)) {
          return `${item.id} - ${item.nombre || item.titulo}`
        }
        return item.nombre || item.titulo || item.tipo || item
      }
      return item
    }

    onMounted(() => {
      loadProcedures()
      loadSupportData()
    })

    return {
      procedures,
      supportData,
      selectedProcedure,
      currentProcedure,
      proceduresByCategory,
      formData,
      loading,
      loadingSupportData,
      lastResult,
      executionHistory,
      executionTime,
      onProcedureChange,
      clearForm,
      onFieldChange,
      executeProcedure,
      formatTime,
      getDropdownOptions,
      getDropdownLabel,
      getOptionKey,
      getOptionValue,
      getOptionLabel
    }
  }
}
</script>

<style scoped>
.test-procedures-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.header {
  text-align: center;
  margin-bottom: 30px;
}

.title {
  font-size: 2.5rem;
  color: #2c3e50;
  margin-bottom: 10px;
}

.description {
  font-size: 1.1rem;
  color: #7f8c8d;
  max-width: 600px;
  margin: 0 auto;
}

.procedure-selector {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  margin-bottom: 30px;
}

.label {
  display: block;
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 10px;
  font-size: 1.1rem;
}

.select, .input {
  width: 100%;
  padding: 12px;
  border: 2px solid #e9ecef;
  border-radius: 6px;
  font-size: 1rem;
  transition: border-color 0.3s;
}

.select:focus, .input:focus {
  outline: none;
  border-color: #3498db;
}

.procedure-form {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  margin-bottom: 30px;
}

.procedure-info {
  margin-bottom: 25px;
  padding-bottom: 20px;
  border-bottom: 2px solid #ecf0f1;
}

.procedure-info h2 {
  color: #2c3e50;
  margin-bottom: 10px;
}

.category-badge {
  background: #3498db;
  color: white;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
}

.input-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.input-group {
  display: flex;
  flex-direction: column;
}

.input-label {
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 8px;
  font-size: 0.95rem;
}

.required {
  color: #e74c3c;
  margin-left: 4px;
}

.form-actions {
  display: flex;
  gap: 15px;
  justify-content: flex-end;
}

.btn {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-primary {
  background: #3498db;
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background: #2980b9;
}

.btn-secondary {
  background: #95a5a6;
  color: white;
}

.btn-secondary:hover:not(:disabled) {
  background: #7f8c8d;
}

.results {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  margin-bottom: 30px;
}

.results h3 {
  color: #2c3e50;
  margin-bottom: 20px;
}

.result-status {
  display: flex;
  align-items: center;
  padding: 15px;
  border-radius: 6px;
  margin-bottom: 20px;
}

.result-status.success {
  background: #d5edda;
  border: 1px solid #c3e6cb;
  color: #155724;
}

.result-status.error {
  background: #f8d7da;
  border: 1px solid #f5c6cb;
  color: #721c24;
}

.status-indicator {
  font-size: 1.5rem;
  margin-right: 15px;
}

.status-message {
  font-weight: 600;
}

.output-params, .execution-info, .error-details {
  margin-top: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 6px;
}

.output-params h4, .error-details h4 {
  color: #2c3e50;
  margin-bottom: 15px;
}

.param-list {
  display: grid;
  gap: 10px;
}

.param-item {
  display: flex;
  justify-content: space-between;
  padding: 8px 12px;
  background: white;
  border-radius: 4px;
}

.param-name {
  font-weight: 600;
  color: #2c3e50;
}

.param-value {
  color: #27ae60;
  font-family: monospace;
}

.execution-info {
  display: flex;
  gap: 30px;
}

.info-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.info-label {
  font-size: 0.9rem;
  color: #7f8c8d;
  margin-bottom: 5px;
}

.info-value {
  font-weight: 600;
  color: #2c3e50;
  font-size: 1.1rem;
}

.error-details pre {
  background: #ffffff;
  padding: 10px;
  border-radius: 4px;
  font-size: 0.9rem;
  overflow-x: auto;
}

.error-code {
  margin-top: 10px;
  font-weight: 600;
}

.history {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.history h3 {
  color: #2c3e50;
  margin-bottom: 20px;
}

.history-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.history-item {
  padding: 12px 15px;
  border-radius: 6px;
  border-left: 4px solid transparent;
}

.history-item.success {
  background: #f8fff9;
  border-left-color: #27ae60;
}

.history-item.error {
  background: #fff8f8;
  border-left-color: #e74c3c;
}

.history-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 5px;
}

.procedure-name {
  font-weight: 600;
  color: #2c3e50;
}

.timestamp {
  font-size: 0.9rem;
  color: #7f8c8d;
}

.status-icon {
  font-size: 1.2rem;
}

.history-message {
  font-size: 0.9rem;
  color: #555;
}

@media (max-width: 768px) {
  .input-grid {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .execution-info {
    flex-direction: column;
    gap: 15px;
  }
  
  .history-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 5px;
  }
}
</style> 