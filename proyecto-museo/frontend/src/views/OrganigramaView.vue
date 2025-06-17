<template>
  <div class="organigrama-view">
    <div class="organigrama-container">
      <header class="view-header">
        <h1>Estructura Organizacional</h1>
        <p>Visualice la jerarquía de departamentos y empleados de cada museo.</p>
      </header>

      <!-- Selector de Museo y Filtro -->
      <div class="selection-container card">
        <div class="selector-group">
          <label for="museo-select">Seleccionar Museo:</label>
          <select id="museo-select" v-model="selectedMuseo" @change="fetchOrganigrama">
            <option disabled value="">Por favor seleccione uno</option>
            <option v-for="museo in museos" :key="museo.id" :value="museo.id">
              {{ museo.nombre }}
            </option>
          </select>
        </div>
        
        <!-- Filtro por nivel organizacional -->
        <div class="selector-group" v-if="organigrama">
          <label for="filtro-nivel">Filtrar por nivel:</label>
          <select id="filtro-nivel" v-model="filtroNivel">
            <option value="">Todos los niveles</option>
            <option value="DIRECCION">Solo Direcciones</option>
            <option value="DEPARTAMENTO">Solo Departamentos</option>
            <option value="SECCION">Solo Secciones</option>
          </select>
        </div>
      </div>

      <div v-if="loading" class="loading-state">
        <p>Cargando organigrama...</p>
      </div>

      <div v-if="error" class="error-state">
        <p>Ha ocurrido un error al cargar el organigrama: {{ error }}</p>
      </div>

      <!-- Contenedor del organigrama -->
      <div v-if="museoInfo && organigrama" class="report-container card" id="organigrama-content">
        <div class="report-header">
          <h2>{{ museoInfo.nombre }}</h2>
          <div v-if="filtroNivel" class="filter-badge">
            <span class="filter-label">🔍 Filtro activo:</span>
            <span class="filter-value">{{ getFiltroLabel(filtroNivel) }}</span>
          </div>
        </div>

        <div class="organigrama-content">
          <h3>Organigrama Jerárquico</h3>
          <ul class="organigrama-root" v-if="organigramaFiltrado.length > 0">
            <OrganigramaNode v-for="node in organigramaFiltrado" :key="node.id" :node="node" />
          </ul>
          <div v-else-if="filtroNivel" class="no-results">
            <p>No se encontraron unidades del tipo "{{ getFiltroLabel(filtroNivel) }}" en este museo.</p>
            <p class="no-results-hint">Intente con otro tipo de filtro o seleccione "Todos los niveles" para ver la estructura completa.</p>
          </div>
        </div>

        <!-- Pie del Reporte -->
        <footer class="report-footer">
          <div class="generation-info">
            <p><strong>Reporte generado el:</strong> {{ fechaGeneracion }}</p>
            <p><strong>Sistema de Gestión de Museos - Grupo 3</strong></p>
          </div>
        </footer>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import OrganigramaNode from '../components/OrganigramaNode.vue'

// Estado reactivo
const museos = ref([])
const selectedMuseo = ref('')
const filtroNivel = ref('')
const organigrama = ref(null)
const museoInfo = ref(null)
const loading = ref(false)
const error = ref(null)

// Computada para la fecha de generación
const fechaGeneracion = computed(() => {
  return new Date().toLocaleString('es-ES', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
})

// Computada para filtrar el organigrama por nivel
const organigramaFiltrado = computed(() => {
  if (!organigrama.value) {
    return []
  }
  
  if (!filtroNivel.value) {
    // Sin filtro: devolver estructura completa
    return organigrama.value
  }
  
  // Aplicar filtro recursivo por tipo
  return filtrarOrganigrama(organigrama.value, filtroNivel.value)
})

// Métodos
const fetchMuseos = async () => {
  try {
    const response = await fetch('http://localhost:3000/api/museos')
    if (!response.ok) {
      throw new Error('No se pudieron obtener los museos.')
    }
    museos.value = await response.json()
  } catch (error) {
    error.value = error.message
    console.error(error)
  }
}

const fetchOrganigrama = async () => {
  if (!selectedMuseo.value) return
  
  loading.value = true
  error.value = null
  organigrama.value = null
  museoInfo.value = null
  filtroNivel.value = '' // Resetear filtro al cambiar museo

  try {
    // Fetch organigrama y museo info en paralelo
    const [organigramaResponse, museoInfoResponse] = await Promise.all([
      fetch(`http://localhost:3000/api/est-organizacional/museo/${selectedMuseo.value}`),
      fetch(`http://localhost:3000/api/museos/${selectedMuseo.value}`)
    ])

    if (!organigramaResponse.ok) {
      throw new Error('Error al obtener la estructura organizacional.')
    }
    organigrama.value = await organigramaResponse.json()

    if (!museoInfoResponse.ok) {
      throw new Error('Error al obtener la información del museo.')
    }
    museoInfo.value = await museoInfoResponse.json()

  } catch (err) {
    error.value = err.message
    console.error(err)
  } finally {
    loading.value = false
  }
}

// Función para filtrar organigrama por tipo de nivel
const filtrarOrganigrama = (nodos, tipoFiltro) => {
  const resultado = []
  
  // Función recursiva para encontrar todos los nodos del tipo especificado
  const buscarTodosTipos = (nodos, tipo) => {
    const encontrados = []
    
    nodos.forEach(nodo => {
      // Si el nodo coincide con el tipo, lo incluimos
      if (nodo.tipo === tipo) {
        // Crear una copia del nodo sin hijos para este contexto
        const nodoCopia = {
          ...nodo,
          children: [] // Los nodos filtrados no muestran jerarquía
        }
        encontrados.push(nodoCopia)
      }
      
      // Buscar recursivamente en los hijos
      if (nodo.children && nodo.children.length > 0) {
        const hijosEncontrados = buscarTodosTipos(nodo.children, tipo)
        encontrados.push(...hijosEncontrados)
      }
    })
    
    return encontrados
  }
  
  return buscarTodosTipos(nodos, tipoFiltro)
}

const getFiltroLabel = (nivel) => {
  const niveles = {
    DIRECCION: 'Direcciones',
    DEPARTAMENTO: 'Departamentos',
    SECCION: 'Secciones'
  }
  return niveles[nivel] || 'Todos los niveles'
}



// Inicializar
onMounted(fetchMuseos)
</script>

<style scoped>
.organigrama-view {
  padding: 1rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100%;
  width: 100%;
  box-sizing: border-box;
}

.organigrama-container {
  max-width: 1400px;
  margin: 0 auto;
}

.view-header {
  text-align: center;
  margin-bottom: 2rem;
  color: white;
  padding: 0 1rem;
}

.view-header h1 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  text-shadow: 0 2px 4px rgba(0,0,0,0.3);
}

.view-header p {
  font-size: 1.1rem;
  opacity: 0.9;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

.card {
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.15), 0 4px 10px rgba(0,0,0,0.1);
  padding: 2rem;
  margin-bottom: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.2);
  width: 100%;
  box-sizing: border-box;
}

.selection-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  align-items: end;
  gap: 2rem;
  width: 100%;
  padding: 1rem 1.5rem;
  margin: -0.5rem -1rem 0.5rem -1rem;
  background: linear-gradient(135deg, #f8fafc 0%, rgba(248, 250, 252, 0.5) 100%);
  border-radius: 12px;
  border: 1px solid #e5e7eb;
}

.selector-group {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  min-width: 0;
}

.selector-group label {
  font-weight: 600;
  color: #374151;
  font-size: 1rem;
  margin-bottom: 0.25rem;
  white-space: nowrap;
}

select {
  width: 100%;
  padding: 0.875rem 1rem;
  border-radius: 12px;
  border: 2px solid #e5e7eb;
  font-size: 1rem;
  transition: all 0.2s ease;
  background-color: white;
  min-width: 220px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  font-weight: 500;
}

select:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.loading-state, .error-state {
  text-align: center;
  padding: 3rem;
  border-radius: 16px;
  width: 100%;
  box-sizing: border-box;
}

.loading-state {
  background: linear-gradient(135deg, #f3f4f6 0%, #ffffff 100%);
  color: #6b7280;
}

.error-state {
  background: linear-gradient(135deg, #fef2f2 0%, #ffffff 100%);
  color: #dc2626;
  border: 1px solid #fecaca;
}

.report-container {
  background: linear-gradient(135deg, #ffffff 0%, #f9fafb 100%);
  border: none;
  box-shadow: 0 20px 40px rgba(0,0,0,0.1);
  width: 100%;
  box-sizing: border-box;
}

.report-header {
  border-bottom: 3px solid #f0f0f0;
  padding-bottom: 2rem;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #f8fafc 0%, transparent 100%);
  padding: 2rem;
  margin: -2rem -2rem 2rem -2rem;
  border-radius: 16px 16px 0 0;
}

.report-header h2 {
  color: #1f2937;
  margin-top: 0;
  font-size: 2rem;
  font-weight: 700;
  text-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.filter-badge {
  background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 25px;
  font-weight: 700;
  font-size: 0.9rem;
  box-shadow: 0 4px 8px rgba(59, 130, 246, 0.3);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-top: 1rem;
}

.filter-label {
  font-weight: 600;
  margin-right: 0.5rem;
}

.filter-value {
  font-weight: 400;
}

.organigrama-content {
  width: 100%;
  overflow-x: auto;
}

.organigrama-content h3 {
  color: #1f2937;
  border-bottom: 3px solid #3b82f6;
  padding-bottom: 0.75rem;
  margin-bottom: 2rem;
  font-size: 1.5rem;
  font-weight: 700;
  position: relative;
}

.organigrama-content h3::after {
  content: '';
  position: absolute;
  bottom: -3px;
  left: 0;
  width: 60px;
  height: 3px;
  background: linear-gradient(90deg, #3b82f6 0%, #1d4ed8 100%);
  border-radius: 2px;
}

.organigrama-root {
  list-style: none;
  padding: 0;
  margin: 2rem 0 0 0;
  width: 100%;
  min-width: fit-content;
}

.no-results {
  text-align: center;
  padding: 3rem;
  border-radius: 16px;
  width: 100%;
  box-sizing: border-box;
  background: linear-gradient(135deg, #f3f4f6 0%, #ffffff 100%);
  color: #6b7280;
}

.no-results-hint {
  font-style: italic;
  color: #555;
  font-size: 1.1rem;
  line-height: 1.6;
  margin-top: 1rem;
  padding: 1rem;
  background-color: #f8fafc;
  border-radius: 8px;
  border-left: 4px solid #3b82f6;
}

/* Pie del reporte */
.report-footer {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 2px solid #e5e7eb;
  text-align: center;
}

.generation-info {
  color: #6b7280;
  font-size: 0.9rem;
}

.generation-info p {
  margin: 0.25rem 0;
}

/* Responsive mejoras */
@media (max-width: 1024px) {
  .selection-container {
    gap: 1.5rem;
    padding: 1rem 1.25rem;
  }
  
  select {
    min-width: 180px;
  }
}

@media (max-width: 768px) {
  .organigrama-view {
    padding: 0.5rem;
  }
  
  .view-header {
    padding: 0 0.5rem;
  }
  
  .view-header h1 {
    font-size: 2rem;
  }
  
  .card {
    padding: 1.5rem;
    margin-bottom: 1.5rem;
  }
  
  .selection-container {
    grid-template-columns: 1fr;
    gap: 1.5rem;
    text-align: center;
    padding: 1rem;
    margin: -0.5rem -0.5rem 1rem -0.5rem;
  }
  
  .selector-group {
    width: 100%;
  }
  
  .selector-group label {
    text-align: center;
    margin-bottom: 0.5rem;
  }
  
  select {
    min-width: unset;
    width: 100%;
  }
  
  .report-header {
    padding: 1.5rem;
    margin: -1.5rem -1.5rem 1.5rem -1.5rem;
  }

  .organigrama-content {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }
}

@media (max-width: 480px) {
  .organigrama-view {
    padding: 0.25rem;
  }
  
  .view-header h1 {
    font-size: 1.75rem;
  }
  
  .card {
    padding: 1rem;
  }
}

/* Estilos específicos para impresión PDF */
@media print {
  .organigrama-view {
    background: white;
    padding: 0;
    margin: 0;
    width: 100%;
  }
  
  .view-header,
  .selection-container {
    display: none;
  }
  
  .report-container {
    box-shadow: none;
    border-radius: 0;
    margin: 0;
    padding: 20px;
    width: 100%;
  }
}
</style> 