<template>
  <div class="reporte-estructura-view">
    <div class="reporte-estructura-container">
      <header class="view-header">
        <h1>Reporte de Estructura Física</h1>
        <p>Análisis detallado de la infraestructura del museo</p>
      </header>

      <!-- Selector de Museo y Filtros -->
      <div class="selection-container card">
        <div class="selector-group">
          <label for="museo-select">Seleccionar Museo:</label>
          <select id="museo-select" v-model="selectedMuseo" @change="fetchReporte">
            <option disabled value="">Seleccione un museo para generar el reporte</option>
            <option v-for="museo in museos" :key="museo.id" :value="museo.id">
              {{ museo.nombre }}
            </option>
          </select>
        </div>
        
        <div class="selector-group" v-if="reporte">
          <label for="filtro-tipo">Filtrar por tipo:</label>
          <select id="filtro-tipo" v-model="filtroTipo">
            <option value="">Todos los elementos</option>
            <option value="EDIFICIO">Solo Edificios</option>
            <option value="PISO">Solo Pisos</option>
            <option value="AREA">Solo Áreas</option>
          </select>
        </div>
      </div>

      <!-- Contenido del Reporte -->
      <div v-if="loadingReporte" class="loading-state">
        <div class="loading-spinner">🔄</div>
        <p>Generando reporte...</p>
      </div>

      <div v-else-if="errorReporte" class="error-state">
        <div class="error-icon">⚠️</div>
        <p>{{ errorReporte }}</p>
        <button @click="fetchReporte" class="retry-btn">Reintentar</button>
      </div>

      <main v-else-if="reporte" class="report-content-card card" id="report-content">
        <!-- Encabezado del Museo -->
        <section class="museum-info">
          <h2>{{ reporte.museo.nombre }}</h2>
          <div v-if="filtroTipo" class="filter-badge">
            <span class="filter-label">🔍 Filtro activo:</span>
            <span class="filter-value">{{ getFilterLabel(filtroTipo) }}</span>
          </div>
        </section>

        <!-- Estructura Física Detallada -->
        <section class="structure-detail">
          <h3>🏗️ Estructura Física Detallada</h3>
          <div class="structure-tree">
            <ReporteEstructuraNode 
              v-for="edificio in estructuraFiltrada" 
              :key="edificio.id" 
              :node="edificio"
              :level="0" 
            />
          </div>
          <div v-if="estructuraFiltrada.length === 0 && filtroTipo" class="no-results">
            <p>No se encontraron elementos del tipo "{{ getFilterLabel(filtroTipo) }}" en este museo.</p>
            <p class="no-results-hint">Intente con otro tipo de filtro o seleccione "Todos los elementos" para ver la estructura completa.</p>
          </div>
        </section>

        <!-- Exposiciones Actuales -->
        <section v-if="reporte.exposiciones_actuales && reporte.exposiciones_actuales.length > 0" class="current-exhibitions">
          <h3>🎭 Exposiciones y Eventos Actuales</h3>
          <div class="exhibitions-table">
            <table>
              <thead>
                <tr>
                  <th>Nombre del Evento</th>
                  <th>Sala</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="expo in reporte.exposiciones_actuales" :key="expo.nombre">
                  <td class="expo-name">{{ expo.nombre }}</td>
                  <td>{{ expo.sala }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <!-- Pie del Reporte -->
        <footer class="report-footer">
          <div class="generation-info">
            <p><strong>Reporte generado el:</strong> {{ fechaGeneracion }}</p>
            <p><strong>Sistema de Gestión de Museos - Grupo 3</strong></p>
          </div>
        </footer>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'
import ReporteEstructuraNode from '../components/ReporteEstructuraNode.vue'

// Configuración
const API_URL = 'http://localhost:3000/api'

// Estado reactivo
const museos = ref([])
const selectedMuseo = ref('')
const filtroTipo = ref('') // Nuevo: filtro por tipo
const reporte = ref(null)
const loadingMuseos = ref(false)
const loadingReporte = ref(false)
const errorReporte = ref(null)

// Computadas
const fechaGeneracion = computed(() => {
  return new Date().toLocaleString('es-ES', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
})

// Nueva computada: estructura filtrada
const estructuraFiltrada = computed(() => {
  if (!reporte.value || !reporte.value.estructura_fisica) {
    return []
  }
  
  if (!filtroTipo.value) {
    // Sin filtro: devolver estructura completa
    return reporte.value.estructura_fisica
  }
  
  // Aplicar filtro recursivo
  const resultado = filtrarEstructura(reporte.value.estructura_fisica, filtroTipo.value)
  console.log('Filtro aplicado:', filtroTipo.value)
  console.log('Estructura original:', reporte.value.estructura_fisica)
  console.log('Estructura filtrada:', resultado)
  return resultado
})

// Métodos
const fetchMuseos = async () => {
  loadingMuseos.value = true
  try {
    const response = await axios.get(`${API_URL}/museos`)
    museos.value = response.data
  } catch (error) {
    console.error('Error al cargar museos:', error)
  } finally {
    loadingMuseos.value = false
  }
}

const fetchReporte = async () => {
  if (!selectedMuseo.value) return
  
  loadingReporte.value = true
  errorReporte.value = null
  reporte.value = null
  filtroTipo.value = '' // Resetear filtro al cambiar museo
  
  try {
    const response = await axios.get(`${API_URL}/reportes/estructura-fisica/${selectedMuseo.value}`)
    reporte.value = response.data
  } catch (error) {
    console.error('Error al generar reporte:', error)
    errorReporte.value = error.response?.data?.message || 'Error al generar el reporte'
  } finally {
    loadingReporte.value = false
  }
}

// Nueva función: filtrar estructura por tipo (corregida)
const filtrarEstructura = (nodos, tipo) => {
  const resultado = []
  
  // Función recursiva para encontrar todos los nodos del tipo especificado
  const buscarTodosTipos = (nodos, tipoFiltro) => {
    const encontrados = []
    
    for (const nodo of nodos) {
      // Si el nodo coincide con el tipo buscado, agregarlo
      if (nodo.tipo === tipoFiltro) {
        encontrados.push({
          ...nodo,
          children: [] // Los nodos filtrados no tendrán hijos para mostrar solo el tipo específico
        })
      }
      
      // Continuar buscando en los hijos
      if (nodo.children && nodo.children.length > 0) {
        encontrados.push(...buscarTodosTipos(nodo.children, tipoFiltro))
      }
    }
    
    return encontrados
  }
  
  return buscarTodosTipos(nodos, tipo)
}

// Nueva función: obtener etiqueta del filtro
const getFilterLabel = (tipo) => {
  const labels = {
    'EDIFICIO': 'Solo Edificios',
    'PISO': 'Solo Pisos', 
    'AREA': 'Solo Áreas'
  }
  return labels[tipo] || 'Todos los elementos'
}

const formatearFecha = (fecha) => {
  if (!fecha) return 'N/A'
  return new Date(fecha).toLocaleDateString('es-ES', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const formatearMoneda = (cantidad) => {
  if (!cantidad) return 'Gratuito'
  return new Intl.NumberFormat('es-ES', {
    style: 'currency',
    currency: 'EUR'
  }).format(cantidad)
}

// Lifecycle
onMounted(() => {
  fetchMuseos()
})
</script>

<style scoped>
.reporte-estructura-view {
  padding: 2rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100%;
}

.reporte-estructura-container {
  max-width: 1200px;
  margin: 0 auto;
}

.view-header {
  text-align: center;
  margin-bottom: 2rem;
  color: white;
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
  border: 1px solid rgba(255,255,255,0.2);
}

.selection-container {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  flex-wrap: wrap;
}

.selector-group {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  flex: 1;
  min-width: 250px;
}

.selector-group label {
  font-weight: 600;
  color: #374151;
  font-size: 1rem;
  white-space: nowrap;
}

select {
  flex: 1;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  border: 2px solid #e5e7eb;
  font-size: 1rem;
  transition: all 0.2s ease;
  background-color: white;
  min-width: 180px;
}

select:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}



/* Estados de carga y error */
.loading-state,
.error-state {
  text-align: center;
  padding: 4rem 2rem;
  border-radius: 16px;
  background: #fff;
}

.loading-spinner {
  font-size: 3rem;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.error-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  color: #dc2626;
}

.error-state {
  border: 1px solid #fecaca;
}

.retry-btn {
  padding: 0.75rem 1.5rem;
  background: var(--primary-color);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  margin-top: 1rem;
}

/* Contenido del reporte */
.report-content-card {
  line-height: 1.6;
}

.museum-info {
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: var(--gray-50);
  border-radius: 12px;
  border-left: 4px solid var(--primary-color);
}

.museum-info h2 {
  color: var(--primary-color);
  font-size: 1.8rem;
  margin-bottom: 1rem;
}

.filter-badge {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-top: 0.75rem;
  padding: 0.5rem 1rem;
  background: #EBF4FF;
  border: 1px solid #3B82F6;
  border-radius: 6px;
  width: fit-content;
}

.filter-label {
  font-size: 0.9rem;
  color: #1E40AF;
  font-weight: 600;
}

.filter-value {
  font-size: 0.9rem;
  color: #3B82F6;
  font-weight: 500;
  background: white;
  padding: 0.125rem 0.5rem;
  border-radius: 4px;
}

/* Estructura detallada */
.structure-detail {
  margin-bottom: 2rem;
}

.structure-detail h3 {
  color: var(--gray-800);
  font-size: 1.5rem;
  margin-bottom: 1rem;
}

.structure-tree {
  background: var(--gray-50);
  padding: 1.5rem;
  border-radius: 12px;
  border: 1px solid var(--gray-200);
}

.no-results {
  text-align: center;
  padding: 2rem;
  color: var(--gray-600);
  font-style: italic;
  background: var(--gray-50);
  border-radius: 8px;
  border: 1px solid var(--gray-200);
}

.no-results-hint {
  font-size: 0.9rem;
  color: var(--gray-500);
  margin-top: 0.5rem;
  font-style: normal;
}

/* Exposiciones actuales */
.current-exhibitions {
  margin-bottom: 2rem;
}

.current-exhibitions h3 {
  color: var(--gray-800);
  font-size: 1.5rem;
  margin-bottom: 1rem;
}

.exhibitions-table {
  overflow-x: auto;
  border-radius: 12px;
  border: 1px solid var(--gray-200);
}

.exhibitions-table table {
  width: 100%;
  border-collapse: collapse;
  background: white;
}

.exhibitions-table th {
  background: var(--gray-100);
  padding: 1rem;
  text-align: left;
  font-weight: 600;
  color: var(--gray-700);
  border-bottom: 2px solid var(--gray-200);
}

.exhibitions-table td {
  padding: 1rem;
  border-bottom: 1px solid var(--gray-200);
}

.expo-name {
  font-weight: 600;
  color: var(--primary-color);
}

/* Pie del reporte */
.report-footer {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 2px solid var(--gray-200);
  text-align: center;
}

.generation-info {
  color: var(--gray-600);
  font-size: 0.9rem;
}

.generation-info p {
  margin: 0.25rem 0;
}

/* Responsive */
@media (max-width: 768px) {
  .selection-container {
    flex-direction: column;
    align-items: stretch;
  }
  
  .selector-group {
    flex-direction: column;
    align-items: stretch;
    min-width: auto;
  }
  
  .export-pdf-btn {
    align-self: stretch;
  }
  
  .filter-badge {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.25rem;
  }
  
  .exhibitions-table {
    font-size: 0.875rem;
  }
  
  .exhibitions-table th,
  .exhibitions-table td {
    padding: 0.75rem 0.5rem;
  }
}

/* Estilos para impresión */
@media print {
  .report-header {
    flex-direction: column;
    gap: 1rem;
  }
  
  .museum-selector {
    display: none;
  }
  
  .print-btn {
    display: none;
  }
  
  .reporte-estructura-container {
    padding: 1rem;
    max-width: none;
  }
  
  .loading-container,
  .error-container {
    display: none;
  }
}
</style> 