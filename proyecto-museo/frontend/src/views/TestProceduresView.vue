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
        
        <!-- Ayuda específica para SP_MOVER_EMPLEADO_ACTIVO -->
        <div v-if="currentProcedure.name === 'SP_MOVER_EMPLEADO_ACTIVO'" class="procedure-help">
          <h4>💡 Lógica de Validación:</h4>
          <ul>
            <li><strong>Empleado:</strong> Siempre obligatorio</li>
            <li><strong>Solo cambio de cargo/estructura:</strong> No es necesario seleccionar museo (se asume el mismo)</li>
            <li><strong>Cambio de museo:</strong> Requiere seleccionar estructura organizacional Y cargo del museo destino</li>
            <li><strong>Debe especificar al menos un cambio:</strong> Museo, estructura organizacional, o cargo</li>
          </ul>
        </div>

        <!-- Ayuda específica para SP_MOVER_EMPLEADO_INACTIVO -->
        <div v-if="currentProcedure.name === 'SP_MOVER_EMPLEADO_INACTIVO'" class="procedure-help">
          <h4>🔄 Lógica de Reactivación:</h4>
          <ul>
            <li><strong>Empleado Inactivo:</strong> Siempre obligatorio</li>
            <li><strong>Reactivación Completa:</strong> Se requieren TODOS los campos para reactivar</li>
            <li><strong>Museo Destino:</strong> Obligatorio - donde será reactivado el empleado</li>
            <li><strong>Estructura Organizacional:</strong> Obligatoria - nueva unidad organizacional</li>
            <li><strong>Cargo:</strong> Obligatorio - nuevo cargo en el museo destino</li>
            <li><strong>Nota:</strong> Los campos se filtran automáticamente según el museo seleccionado</li>
          </ul>
        </div>

        <!-- Ayuda específica para SP_REGISTRAR_OBRA_NUEVA -->
        <div v-if="currentProcedure.name === 'SP_REGISTRAR_OBRA_NUEVA'" class="procedure-help">
          <h4>🎨 Registro de Nueva Obra:</h4>
          <ul>
            <li><strong>Datos de la Obra:</strong> Todos los campos básicos son obligatorios (título, fecha, tipo, dimensiones, etc.)</li>
            <li><strong>Ubicación:</strong> Debe seleccionar museo, colección y sala donde se ubicará la obra</li>
            <li><strong>Empleado Responsable:</strong> Solo se muestran empleados con cargo "Restaurador" o "Curador" del museo seleccionado</li>
            <li><strong>Obra Destacada:</strong> Si marca "SI", el orden de recorrido se vuelve <strong>obligatorio</strong></li>
            <li><strong>Orden de Recorrido:</strong> Las obras destacadas tienen prioridad sobre las no destacadas</li>
            <li><strong>Historial:</strong> Se crea automáticamente un registro en hist_obras_mov con fecha actual</li>
            <li><strong>Filtros Reactivos:</strong> Las opciones se filtran según el museo seleccionado</li>
          </ul>
        </div>

        <!-- Ayuda específica para SP_ASIGNAR_VIGILANTE_MANT -->
        <div v-if="currentProcedure.name === 'SP_ASIGNAR_VIGILANTE_MANT'" class="procedure-help">
          <h4>🛡️ Asignación de Vigilante a Estructura:</h4>
          <ul>
            <li><strong>Vigilante:</strong> Obligatorio - seleccione el vigilante a asignar</li>
            <li><strong>Filtrado Inteligente:</strong> Las estructuras físicas se filtran automáticamente para mostrar <strong>solo</strong> las del museo donde trabaja actualmente el vigilante seleccionado</li>
            <li><strong>Estructura Física:</strong> Obligatoria - solo aparecen las estructuras del museo del vigilante</li>
            <li><strong>Turno:</strong> Obligatorio - especifique el turno de trabajo</li>
            <li><strong>Lógica de Negocio:</strong> Un vigilante solo puede ser asignado a estructuras del museo donde ya trabaja</li>
            <li><strong>Sin Vigilante = Sin Estructuras:</strong> Si no se selecciona vigilante, no aparecerán estructuras disponibles</li>
          </ul>
        </div>

        <!-- Ayuda específica para SP_MOVER_OBRA -->
        <div v-if="currentProcedure.name === 'SP_MOVER_OBRA'" class="procedure-help">
          <h4>🚚 Movimiento de Obras:</h4>
          <ul>
            <li><strong>Obra a Mover:</strong> Seleccione la obra que desea trasladar (obligatorio)</li>
            <li><strong>Campos Opcionales:</strong> Solo complete los campos que desea cambiar</li>
            <li><strong>Museo Destino:</strong> Si selecciona un museo diferente, se realiza un traslado completo</li>
            <li><strong>Filtros Reactivos:</strong> Al seleccionar museo destino, las colecciones, salas y empleados se filtran automáticamente</li>
            <li><strong>Mantenimiento de Programas:</strong> Si se mueve dentro del mismo museo, se mantienen los programas de mantenimiento</li>
            <li><strong>Orden de Recorrido:</strong> Se recalcula automáticamente según las obras destacadas</li>
            <li><strong>Histórico:</strong> Se cierra el registro anterior y se crea uno nuevo con los nuevos datos</li>
          </ul>
        </div>

        <!-- Ayuda específica para SP_REGISTRAR_MANTENIMIENTO_OBRA -->
        <div v-if="currentProcedure.name === 'SP_REGISTRAR_MANTENIMIENTO_OBRA'" class="procedure-help">
          <h4>🔧 Registro de Mantenimiento:</h4>
          <ul>
            <li><strong>Mantenimiento Programado:</strong> Seleccione el mantenimiento a registrar (obligatorio)</li>
            <li><strong>Filtrado Inteligente:</strong> Los empleados responsables se filtran automáticamente según el museo donde está ubicada la obra</li>
            <li><strong>Solo Especialistas:</strong> Solo se muestran empleados con cargo de "Curador" o "Restaurador"</li>
            <li><strong>Lógica de Negocio:</strong> Un empleado solo puede responsabilizarse de mantenimientos de obras en su mismo museo</li>
            <li><strong>Observaciones:</strong> Campo obligatorio para documentar el trabajo realizado</li>
            <li><strong>Fecha de Finalización:</strong> Campo opcional - si no se especifica, se usa la fecha actual</li>
            <li><strong>Sin Mantenimiento = Sin Empleados:</strong> Si no se selecciona mantenimiento, no aparecerán empleados disponibles</li>
          </ul>
        </div>
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
      tiposTicket: [],
      idiomas: []
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
          tiposTicket: [],
          idiomas: []
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

    // Función para manejar cambios en campos con lógica específica por procedimiento
    const onFieldChange = (paramName, value) => {
      console.log(`[FIELD-CHANGE] ${paramName} cambió a:`, value)
      
      // === LÓGICA ESPECÍFICA PARA SP_MOVER_EMPLEADO_ACTIVO ===
      if (selectedProcedure.value === 'SP_MOVER_EMPLEADO_ACTIVO') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_MOVER_EMPLEADO_ACTIVO')
        
        // Si cambió el empleado, NO limpiar otros campos
        if (paramName === 'n_id_empleado' && value) {
          console.log('[FIELD-CHANGE] Empleado seleccionado, manteniendo otros campos')
          return // No hacer nada más
        }
        
        // Si cambió el museo destino, limpiar SOLO los campos que dependen del museo
        if (paramName === 'n_id_museo' && value) {
          console.log('[FIELD-CHANGE] Museo destino cambió, limpiando campos dependientes del museo')
          
          // Para SP_MOVER_EMPLEADO_ACTIVO: si selecciona museo, requiere est_org y cargo
          const camposDependientesMuseo = ['n_id_est_org', 'n_cargo']
          
          camposDependientesMuseo.forEach(campo => {
            if (formData[campo]) {
              console.log(`[FIELD-CHANGE] Limpiando ${campo} porque cambió el museo`)
              formData[campo] = ''
            }
          })
          return
        }
        
        // Si cambió estructura organizacional o cargo, NO requerir museo
        if ((paramName === 'n_id_est_org' || paramName === 'n_cargo') && value) {
          console.log('[FIELD-CHANGE] Estructura org o cargo cambió, no requiere museo')
          return
        }
        
        return // Salir para SP_MOVER_EMPLEADO_ACTIVO
      }
      
      // === LÓGICA ESPECÍFICA PARA SP_MOVER_EMPLEADO_INACTIVO ===
      if (selectedProcedure.value === 'SP_MOVER_EMPLEADO_INACTIVO') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_MOVER_EMPLEADO_INACTIVO')
        
        // Si cambió el empleado inactivo, NO limpiar otros campos
        if (paramName === 'n_id_empleado' && value) {
          console.log('[FIELD-CHANGE] Empleado inactivo seleccionado, manteniendo otros campos')
          return // No hacer nada más
        }
        
        // Si cambió el museo destino, limpiar campos que dependen del museo
        if (paramName === 'n_id_museo' && value) {
          console.log('[FIELD-CHANGE] Museo destino cambió, limpiando campos dependientes del museo')
          
          // Para SP_MOVER_EMPLEADO_INACTIVO: al cambiar museo, limpiar estructura y cargo
          const camposDependientesMuseo = ['n_id_est_org', 'n_cargo']
          
          camposDependientesMuseo.forEach(campo => {
            if (formData[campo]) {
              console.log(`[FIELD-CHANGE] Limpiando ${campo} porque cambió el museo`)
              formData[campo] = ''
            }
          })
          return
        }
        
        // Para estructura organizacional y cargo, mantener consistencia
        if ((paramName === 'n_id_est_org' || paramName === 'n_cargo') && value) {
          console.log('[FIELD-CHANGE] Estructura org o cargo cambió para empleado inactivo')
          return
        }
        
        return // Salir para SP_MOVER_EMPLEADO_INACTIVO
      }

      // === LÓGICA ESPECÍFICA PARA SP_REGISTRAR_OBRA_NUEVA ===
      if (selectedProcedure.value === 'SP_REGISTRAR_OBRA_NUEVA') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_REGISTRAR_OBRA_NUEVA')
        
        // Si cambió el museo, limpiar campos dependientes del museo
        if (paramName === 'n_id_museo' && value) {
          console.log('[FIELD-CHANGE] Museo cambió, limpiando campos dependientes del museo')
          
          const camposDependientesMuseo = ['n_id_coleccion', 'n_id_sala', 'n_id_empleado']
          
          camposDependientesMuseo.forEach(campo => {
            if (formData[campo]) {
              console.log(`[FIELD-CHANGE] Limpiando ${campo} porque cambió el museo`)
              formData[campo] = ''
            }
          })
          return
        }
        
        // Si cambió el campo "destacada", limpiar orden de recorrido si cambió a "NO"
        if (paramName === 'n_destacada' && value) {
          console.log('[FIELD-CHANGE] Campo destacada cambió a:', value)
          
          if (value === 'NO') {
            // Si cambió a NO, limpiar orden de recorrido (ya que ahora es opcional)
            if (formData.n_orden_recorrido) {
              console.log('[FIELD-CHANGE] Obra no destacada, limpiando orden de recorrido')
              formData.n_orden_recorrido = ''
            }
          }
          return
        }
        
        return // Salir para SP_REGISTRAR_OBRA_NUEVA
      }

      // === LÓGICA ESPECÍFICA PARA SP_INSERTAR_COLECCION ===
      if (selectedProcedure.value === 'SP_INSERTAR_COLECCION') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_INSERTAR_COLECCION')
        
        // Si cambió el museo, limpiar el departamento porque debe filtrarse por el nuevo museo
        if (paramName === 'n_nombre_museo' && value) {
          console.log('[FIELD-CHANGE] Museo cambió para SP_INSERTAR_COLECCION, limpiando departamento')
          
          // Limpiar departamento porque debe filtrarse por el nuevo museo
          if (formData.n_nombre_depto) {
            console.log('[FIELD-CHANGE] Limpiando n_nombre_depto porque cambió el museo')
            formData.n_nombre_depto = ''
          }
          return
        }
        
        return // Salir para SP_INSERTAR_COLECCION
      }

      // === LÓGICA ESPECÍFICA PARA SP_MOVER_OBRA ===
      if (selectedProcedure.value === 'SP_MOVER_OBRA') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_MOVER_OBRA')
        
        // Si cambió el museo destino, limpiar campos dependientes del museo
        if (paramName === 'p_id_museo_destino' && value) {
          console.log('[FIELD-CHANGE] Museo destino cambió para SP_MOVER_OBRA, limpiando campos dependientes')
          
          // Limpiar campos que dependen del museo destino
          const camposDependientesMuseo = ['p_id_coleccion_destino', 'p_id_sala_destino', 'p_id_empleado_destino']
          
          camposDependientesMuseo.forEach(campo => {
            if (formData[campo]) {
              console.log(`[FIELD-CHANGE] Limpiando ${campo} porque cambió el museo destino`)
              formData[campo] = ''
            }
          })
          return
        }
        
        return // Salir para SP_MOVER_OBRA
      }
      
      // === LÓGICA ESPECÍFICA PARA SP_REGISTRAR_MANTENIMIENTO_OBRA ===
      if (selectedProcedure.value === 'SP_REGISTRAR_MANTENIMIENTO_OBRA') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_REGISTRAR_MANTENIMIENTO_OBRA')
        
        // Si cambió el mantenimiento, limpiar el empleado responsable para refiltrado
        if (paramName === 'n_id_mant' && value) {
          console.log('[FIELD-CHANGE] Mantenimiento cambió, limpiando empleado responsable para refiltrado')
          
          // Limpiar empleado responsable porque debe filtrarse por el museo de la nueva obra
          if (formData.n_id_empleado) {
            console.log('[FIELD-CHANGE] Limpiando n_id_empleado porque cambió el mantenimiento')
            formData.n_id_empleado = ''
          }
          return
        }
        
        return // Salir para SP_REGISTRAR_MANTENIMIENTO_OBRA
      }
      
      // === LÓGICA ESPECÍFICA PARA SP_ASIGNAR_VIGILANTE_MANT ===
      if (selectedProcedure.value === 'SP_ASIGNAR_VIGILANTE_MANT') {
        console.log('[FIELD-CHANGE] Lógica específica para SP_ASIGNAR_VIGILANTE_MANT')
        
        // Si cambió el vigilante, limpiar la estructura física porque debe filtrarse por el museo del vigilante
        if (paramName === 'n_id_vig_mant' && value) {
          console.log('[FIELD-CHANGE] Vigilante cambió, limpiando estructura física para refiltrado')
          
          // Limpiar estructura física porque debe filtrarse por el nuevo vigilante
          if (formData.n_id_est) {
            console.log('[FIELD-CHANGE] Limpiando n_id_est porque cambió el vigilante')
            formData.n_id_est = ''
          }
          return
        }
        
        return // Salir para SP_ASIGNAR_VIGILANTE_MANT
      }
      
      // === LÓGICA GENERAL PARA OTROS PROCEDIMIENTOS ===
      
      // Si cambió el museo, limpiar todos los campos dependientes (excepto SP_MOVER_EMPLEADO_ACTIVO)
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

      // === VALIDACIÓN ESPECIAL PARA SP_MOVER_EMPLEADO_ACTIVO ===
      if (selectedProcedure.value === 'SP_MOVER_EMPLEADO_ACTIVO') {
        const empleado = formData.n_id_empleado
        const museo = formData.n_id_museo
        const estOrg = formData.n_id_est_org
        const cargo = formData.n_cargo

        // Validar que al menos se seleccionó un empleado
        if (!empleado) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Debe seleccionar un empleado',
            error: 'Empleado es obligatorio'
          }
          return
        }

        // Validar lógica de negocio:
        // Si selecciona museo, requiere estructura organizacional Y cargo
        if (museo && (!estOrg || !cargo)) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Si selecciona museo destino, debe seleccionar también estructura organizacional y cargo',
            error: 'Museo destino requiere estructura organizacional y cargo'
          }
          return
        }

        // Validar que al menos se haya seleccionado algo para cambiar
        if (!museo && !estOrg && !cargo) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Debe seleccionar al menos un campo para modificar (museo, estructura organizacional, o cargo)',
            error: 'No hay cambios especificados'
          }
          return
        }

        console.log('[VALIDATION] SP_MOVER_EMPLEADO_ACTIVO validado correctamente')
      }

      // === VALIDACIÓN ESPECIAL PARA SP_MOVER_EMPLEADO_INACTIVO ===
      if (selectedProcedure.value === 'SP_MOVER_EMPLEADO_INACTIVO') {
        const empleado = formData.n_id_empleado
        const museo = formData.n_id_museo
        const estOrg = formData.n_id_est_org
        const cargo = formData.n_cargo

        // Validar que se seleccionó un empleado inactivo
        if (!empleado) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Debe seleccionar un empleado inactivo',
            error: 'Empleado inactivo es obligatorio'
          }
          return
        }

        // Para empleados inactivos, TODOS los campos son requeridos (reactivación completa)
        if (!museo) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Museo destino es obligatorio para reactivar un empleado inactivo',
            error: 'Museo destino es obligatorio'
          }
          return
        }

        if (!estOrg) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Estructura organizacional es obligatoria para reactivar un empleado inactivo',
            error: 'Estructura organizacional es obligatoria'
          }
          return
        }

        if (!cargo) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Cargo es obligatorio para reactivar un empleado inactivo',
            error: 'Cargo es obligatorio'
          }
          return
        }

        console.log('[VALIDATION] SP_MOVER_EMPLEADO_INACTIVO validado correctamente')
      }

      // === VALIDACIÓN ESPECIAL PARA SP_REGISTRAR_OBRA_NUEVA ===
      if (selectedProcedure.value === 'SP_REGISTRAR_OBRA_NUEVA') {
        console.log('[VALIDATION] Validando SP_REGISTRAR_OBRA_NUEVA')
        
        // Validar campos obligatorios básicos
        const camposObligatorios = [
          'n_nombre', 'n_fecha_periodo', 'n_tipo_obra', 'n_dimensiones', 
          'n_desc_mat_tec', 'n_desc_estilos', 'n_id_museo', 'n_id_coleccion', 
          'n_id_sala', 'n_id_empleado', 'n_tipo_adq', 'n_destacada'
        ]
        
        for (const campo of camposObligatorios) {
          if (!formData[campo]) {
            const etiquetas = {
              'n_nombre': 'Título de la Obra',
              'n_fecha_periodo': 'Fecha/Período',
              'n_tipo_obra': 'Tipo de Obra',
              'n_dimensiones': 'Dimensiones',
              'n_desc_mat_tec': 'Materiales y Técnicas',
              'n_desc_estilos': 'Estilos y Géneros',
              'n_id_museo': 'Museo',
              'n_id_coleccion': 'Colección',
              'n_id_sala': 'Sala',
              'n_id_empleado': 'Empleado Responsable',
              'n_tipo_adq': 'Tipo de Adquisición',
              'n_destacada': '¿Es Obra Destacada?'
            }
            
            lastResult.value = {
              success: false,
              message: `Error de validación: El campo "${etiquetas[campo]}" es obligatorio`,
              error: `Campo ${campo} es requerido`
            }
            return
          }
        }
        
        // Validación especial: Si es destacada, orden de recorrido es obligatorio
        if (formData.n_destacada === 'SI' && (!formData.n_orden_recorrido || formData.n_orden_recorrido <= 0)) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: Para obras destacadas, el orden de recorrido es obligatorio y debe ser mayor a 0',
            error: 'Orden de recorrido requerido para obras destacadas'
          }
          return
        }
        
        // Validación de valor monetario (debe ser positivo si se proporciona)
        if (formData.n_valor_monetario && formData.n_valor_monetario <= 0) {
          lastResult.value = {
            success: false,
            message: 'Error de validación: El valor monetario debe ser mayor a 0',
            error: 'Valor monetario inválido'
          }
          return
        }
        
        console.log('[VALIDATION] SP_REGISTRAR_OBRA_NUEVA validado correctamente')
      }

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
      
      // === FILTRADO ESPECÍFICO PARA SP_ASIGNAR_VIGILANTE_MANT ===
      if (selectedProcedure.value === 'SP_ASIGNAR_VIGILANTE_MANT' && param.dataSource === 'estructurasFisicas') {
        console.log(`[DROPDOWN] Filtrado específico para SP_ASIGNAR_VIGILANTE_MANT - estructuras físicas`)
        console.log(`[DROPDOWN] Total estructuras físicas disponibles: ${options.length}`)
        console.log(`[DROPDOWN] Vigilantes disponibles: ${supportData.value.vigilantes.length}`)
        
        const vigilanteSeleccionado = formData.n_id_vig_mant
        if (vigilanteSeleccionado) {
          console.log(`[DROPDOWN] Vigilante seleccionado: ${vigilanteSeleccionado}`)
          
          // Buscar el vigilante en los datos de apoyo para obtener su museo actual
          const vigilante = supportData.value.vigilantes.find(v => v.id == vigilanteSeleccionado)
          console.log(`[DROPDOWN] Vigilante encontrado:`, vigilante)
          
          if (vigilante && vigilante.id_museo) {
            console.log(`[DROPDOWN] Vigilante trabaja en museo ID: ${vigilante.id_museo} (${vigilante.nombre_museo})`)
            
            // DEBUG: Mostrar todas las estructuras físicas antes del filtro
            console.log(`[DROPDOWN] Estructuras físicas antes del filtro:`, options.slice(0, 3))
            
            // Filtrar estructuras físicas solo del museo donde trabaja el vigilante
            // Usar comparación más robusta para evitar problemas de tipos
            options = options.filter(estructura => {
              const match = String(estructura.id_museo) === String(vigilante.id_museo)
              if (!match) {
                console.log(`[DROPDOWN] Descartando estructura ${estructura.nombre} (museo ${estructura.id_museo}) no coincide con vigilante (museo ${vigilante.id_museo})`)
              }
              return match
            })
            console.log(`[DROPDOWN] Estructuras físicas filtradas para museo del vigilante: ${options.length}`)
            
            // DEBUG: Mostrar las estructuras filtradas
            if (options.length > 0) {
              console.log(`[DROPDOWN] Estructuras físicas después del filtro:`, options.slice(0, 3))
            } else {
              console.warn(`[DROPDOWN] ⚠️ No se encontraron estructuras físicas para el museo ${vigilante.id_museo}`)
              console.log(`[DROPDOWN] Verificando si existen estructuras físicas para ese museo...`)
              const todasEstructuras = supportData.value.estructurasFisicas || []
              const estructurasDelMuseo = todasEstructuras.filter(e => String(e.id_museo) === String(vigilante.id_museo))
              console.log(`[DROPDOWN] Estructuras del museo ${vigilante.id_museo} en datos de apoyo:`, estructurasDelMuseo.length)
            }
          } else {
            console.warn(`[DROPDOWN] No se encontró museo para vigilante ID: ${vigilanteSeleccionado}`)
            console.log(`[DROPDOWN] Datos del vigilante:`, vigilante)
            
            // Si no tiene museo asignado, mostrar todas las estructuras como fallback
            console.log(`[DROPDOWN] FALLBACK: Mostrando todas las estructuras físicas`)
            // No filtrar, mantener todas las opciones
          }
        } else {
          // Si no hay vigilante seleccionado, no mostrar estructuras
          console.log(`[DROPDOWN] No hay vigilante seleccionado, sin estructuras disponibles`)
          options = []
        }
        
        console.log(`[DROPDOWN] ${param.dataSource} devolviendo ${options.length} opciones finales`)
        return options
      }
      
      // === FILTRADO ESPECÍFICO PARA SP_REGISTRAR_MANTENIMIENTO_OBRA ===
      if (selectedProcedure.value === 'SP_REGISTRAR_MANTENIMIENTO_OBRA' && param.dataSource === 'empleados') {
        console.log(`[DROPDOWN] Filtrado específico para SP_REGISTRAR_MANTENIMIENTO_OBRA - empleados responsables`)
        
        const mantenimientoSeleccionado = formData.n_id_mant
        if (mantenimientoSeleccionado) {
          console.log(`[DROPDOWN] Mantenimiento seleccionado: ${mantenimientoSeleccionado}`)
          
          // Buscar el mantenimiento en los datos de apoyo para obtener el museo de la obra
          const mantenimiento = supportData.value.mantenimientos.find(m => m.id == mantenimientoSeleccionado)
          console.log(`[DROPDOWN] Mantenimiento encontrado:`, mantenimiento)
          
          if (mantenimiento && mantenimiento.id_museo) {
            console.log(`[DROPDOWN] Obra del mantenimiento está en museo ID: ${mantenimiento.id_museo}`)
            
            // Filtrar empleados solo del museo donde está la obra
            options = options.filter(empleado => {
              const matchMuseo = String(empleado.id_museo) === String(mantenimiento.id_museo)
              
              // También filtrar por cargo: solo curadores y restauradores
              const cargo = empleado.cargo ? empleado.cargo.toLowerCase() : ''
              const esCuradorORestaurador = cargo.includes('curador') || cargo.includes('restaurador')
              
              const cumpleCondiciones = matchMuseo && esCuradorORestaurador
              
              if (!matchMuseo) {
                console.log(`[DROPDOWN] Descartando empleado ${empleado.nombre} (museo ${empleado.id_museo}) no coincide con obra (museo ${mantenimiento.id_museo})`)
              } else if (!esCuradorORestaurador) {
                console.log(`[DROPDOWN] Descartando empleado ${empleado.nombre} (cargo: ${empleado.cargo}) no es curador ni restaurador`)
              }
              
              return cumpleCondiciones
            })
            
            console.log(`[DROPDOWN] Empleados curadores/restauradores filtrados para museo de la obra: ${options.length}`)
            
            // DEBUG: Mostrar los empleados filtrados
            if (options.length > 0) {
              console.log(`[DROPDOWN] Empleados después del filtro:`, options.slice(0, 3))
            } else {
              console.warn(`[DROPDOWN] ⚠️ No se encontraron curadores ni restauradores para el museo ${mantenimiento.id_museo}`)
            }
          } else {
            console.warn(`[DROPDOWN] No se encontró museo para mantenimiento ID: ${mantenimientoSeleccionado}`)
            console.log(`[DROPDOWN] Datos del mantenimiento:`, mantenimiento)
            
            // Si no tiene museo asignado, filtrar solo por cargo como fallback
            console.log(`[DROPDOWN] FALLBACK: Filtrando solo por cargo (curadores y restauradores)`)
            options = options.filter(empleado => {
              const cargo = empleado.cargo ? empleado.cargo.toLowerCase() : ''
              return cargo.includes('curador') || cargo.includes('restaurador')
            })
            console.log(`[DROPDOWN] Empleados curadores/restauradores (sin filtro de museo): ${options.length}`)
          }
        } else {
          // Si no hay mantenimiento seleccionado, no mostrar empleados
          console.log(`[DROPDOWN] No hay mantenimiento seleccionado, sin empleados disponibles`)
          options = []
        }
        
        console.log(`[DROPDOWN] ${param.dataSource} devolviendo ${options.length} opciones finales para SP_REGISTRAR_MANTENIMIENTO_OBRA`)
        return options
      }
      
      // Detectar el ID de museo seleccionado (puede tener diferentes nombres según el procedimiento)
      const museoSeleccionado = formData.p_id_museo || formData.n_id_museo || formData.id_museo || 
                                formData.n_nombre_museo || formData.p_id_museo_destino
      
      if (museoSeleccionado) {
        console.log(`[DROPDOWN] Museo seleccionado: ${museoSeleccionado}`)
        
        // Si es unidades organizacionales, filtrar por museo
        if (param.dataSource === 'unidadesOrganizacionales') {
          console.log(`[DROPDOWN] Filtrando unidades organizacionales para museo: ${museoSeleccionado}`)
          
          // Manejar diferentes tipos de parámetros de museo (ID vs nombre)
          if (typeof museoSeleccionado === 'string' && isNaN(museoSeleccionado)) {
            // Si es un string (nombre de museo), buscar el ID correspondiente
            const museoEncontrado = supportData.value.museos.find(museo => museo.nombre === museoSeleccionado)
            if (museoEncontrado) {
              options = options.filter(unidad => unidad.id_museo == museoEncontrado.id)
              console.log(`[DROPDOWN] Filtrado por nombre de museo "${museoSeleccionado}" (ID: ${museoEncontrado.id}): ${options.length} unidades`)
            } else {
              console.warn(`[DROPDOWN] No se encontró museo con nombre "${museoSeleccionado}"`)
              options = []
            }
          } else {
            // Si es un número (ID de museo), filtrar directamente
            options = options.filter(unidad => unidad.id_museo == museoSeleccionado)
            console.log(`[DROPDOWN] Filtrado por ID de museo ${museoSeleccionado}: ${options.length} unidades`)
          }
        }
        
        // Si son salas, filtrar por museo
        if (param.dataSource === 'salas') {
          console.log(`[DROPDOWN] Filtrando salas para museo: ${museoSeleccionado}`)
          
          // Manejar diferentes tipos de parámetros de museo (ID vs nombre)
          if (typeof museoSeleccionado === 'string' && isNaN(museoSeleccionado)) {
            // Si es un string (nombre de museo), buscar el ID correspondiente
            const museoEncontrado = supportData.value.museos.find(museo => museo.nombre === museoSeleccionado)
            if (museoEncontrado) {
              options = options.filter(sala => sala.id_museo == museoEncontrado.id)
              console.log(`[DROPDOWN] Salas filtradas por nombre de museo "${museoSeleccionado}" (ID: ${museoEncontrado.id}): ${options.length}`)
            } else {
              console.warn(`[DROPDOWN] No se encontró museo con nombre "${museoSeleccionado}"`)
              options = []
            }
          } else {
            // Si es un número (ID de museo), filtrar directamente
            options = options.filter(sala => sala.id_museo == museoSeleccionado)
            console.log(`[DROPDOWN] Salas filtradas por ID de museo ${museoSeleccionado}: ${options.length}`)
          }
        }
        
        // Si son colecciones, filtrar por museo
        if (param.dataSource === 'colecciones') {
          console.log(`[DROPDOWN] Filtrando colecciones para museo: ${museoSeleccionado}`)
          
          // Manejar diferentes tipos de parámetros de museo (ID vs nombre)
          if (typeof museoSeleccionado === 'string' && isNaN(museoSeleccionado)) {
            // Si es un string (nombre de museo), buscar el ID correspondiente
            const museoEncontrado = supportData.value.museos.find(museo => museo.nombre === museoSeleccionado)
            if (museoEncontrado) {
              options = options.filter(coleccion => coleccion.id_museo == museoEncontrado.id)
              console.log(`[DROPDOWN] Colecciones filtradas por nombre de museo "${museoSeleccionado}" (ID: ${museoEncontrado.id}): ${options.length}`)
            } else {
              console.warn(`[DROPDOWN] No se encontró museo con nombre "${museoSeleccionado}"`)
              options = []
            }
          } else {
            // Si es un número (ID de museo), filtrar directamente
            options = options.filter(coleccion => coleccion.id_museo == museoSeleccionado)
            console.log(`[DROPDOWN] Colecciones filtradas por ID de museo ${museoSeleccionado}: ${options.length}`)
          }
        }
        
        // Si son estructuras físicas, filtrar por museo (solo para procedimientos que NO sean SP_ASIGNAR_VIGILANTE_MANT)
        if (param.dataSource === 'estructurasFisicas' && selectedProcedure.value !== 'SP_ASIGNAR_VIGILANTE_MANT') {
          console.log(`[DROPDOWN] Filtrando estructuras físicas para museo: ${museoSeleccionado}`)
          options = options.filter(estructura => estructura.id_museo == museoSeleccionado)
          console.log(`[DROPDOWN] Estructuras físicas filtradas: ${options.length}`)
        }
        
        // Si son empleados, filtrar por museo (si está disponible)
        if (param.dataSource === 'empleados' && options.length > 0 && options[0].id_museo) {
          console.log(`[DROPDOWN] Filtrando empleados para museo: ${museoSeleccionado}`)
          
          // Manejar diferentes tipos de parámetros de museo (ID vs nombre)
          if (typeof museoSeleccionado === 'string' && isNaN(museoSeleccionado)) {
            // Si es un string (nombre de museo), buscar el ID correspondiente
            const museoEncontrado = supportData.value.museos.find(museo => museo.nombre === museoSeleccionado)
            if (museoEncontrado) {
              options = options.filter(empleado => empleado.id_museo == museoEncontrado.id)
              console.log(`[DROPDOWN] Empleados filtrados por nombre de museo "${museoSeleccionado}" (ID: ${museoEncontrado.id}): ${options.length}`)
            } else {
              console.warn(`[DROPDOWN] No se encontró museo con nombre "${museoSeleccionado}"`)
              options = []
            }
          } else {
            // Si es un número (ID de museo), filtrar directamente
            options = options.filter(empleado => empleado.id_museo == museoSeleccionado)
            console.log(`[DROPDOWN] Empleados filtrados por ID de museo ${museoSeleccionado}: ${options.length}`)
          }
          
          // Filtrado especial para SP_REGISTRAR_OBRA_NUEVA: solo restauradores y curadores
          if (selectedProcedure.value === 'SP_REGISTRAR_OBRA_NUEVA' && param.name === 'n_id_empleado') {
            console.log(`[DROPDOWN] Filtrado especial: solo restauradores y curadores para SP_REGISTRAR_OBRA_NUEVA`)
            options = options.filter(empleado => {
              const cargo = empleado.cargo ? empleado.cargo.toLowerCase() : ''
              return cargo.includes('restaurador') || cargo.includes('curador')
            })
            console.log(`[DROPDOWN] Empleados restauradores/curadores filtrados: ${options.length}`)
          }
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
        // Manejo especial para mantenimientos: mostrar obra y descripción
        if (param.dataSource === 'mantenimientos' && item.obra_nombre && item.descripcion) {
          return `${item.obra_nombre} - ${item.descripcion}`
        }
        // Manejo estándar para otros casos
        if (item.id && (item.nombre || item.titulo)) {
          return `${item.id} - ${item.nombre || item.titulo}`
        }
        return item.nombre || item.titulo || item.tipo || item.obra_nombre || item
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

.procedure-help {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 6px;
  padding: 15px;
  margin-top: 15px;
}

.procedure-help h4 {
  color: #495057;
  margin-bottom: 10px;
  font-size: 1rem;
}

.procedure-help ul {
  margin: 0;
  padding-left: 20px;
}

.procedure-help li {
  margin-bottom: 5px;
  color: #6c757d;
  font-size: 0.9rem;
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