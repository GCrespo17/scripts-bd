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
        
        <!-- Botón de exportar PDF -->
        <button 
          v-if="organigrama && museoInfo" 
          @click="exportToPDF" 
          :disabled="exportingPDF"
          class="export-button"
        >
          <span v-if="exportingPDF">📄 Generando PDF...</span>
          <span v-else>📄 Exportar PDF</span>
        </button>
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
const exportingPDF = ref(false)

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

const exportToPDF = async () => {
  exportingPDF.value = true
  
  try {
    const jsPDF = (await import('jspdf')).default
    
    const pdf = new jsPDF('portrait', 'mm', 'a4')
    const pageWidth = pdf.internal.pageSize.getWidth()
    const pageHeight = pdf.internal.pageSize.getHeight()
    let yPosition = 20
    
    const checkNewPage = (requiredHeight) => {
      if (yPosition + requiredHeight > pageHeight - 20) {
        pdf.addPage()
        yPosition = 20
      }
    }
    
    // Funciones helper para texto seguro
    const safeText = (text) => {
      if (text === null || text === undefined) return ''
      return String(text).trim()
    }

    const safeDrawText = (text, x, y, options = {}) => {
      const cleanText = safeText(text)
      if (!cleanText) return
      
      try {
        pdf.text(cleanText, x, y, options)
      } catch (error) {
        console.warn('Error al dibujar texto:', cleanText, error)
      }
    }

    // Cabecera PDF
    pdf.setFontSize(18)
    pdf.setFont('helvetica', 'bold')
    safeDrawText('ESTRUCTURA ORGANIZACIONAL', pageWidth / 2, yPosition, { align: 'center' })
    yPosition += 15
    
    pdf.setLineWidth(0.5)
    pdf.line(20, yPosition, pageWidth - 20, yPosition)
    yPosition += 10
    
    pdf.setFontSize(12)
    pdf.setFont('helvetica', 'bold')
    safeDrawText('MUSEO:', 20, yPosition)
    pdf.setFont('helvetica', 'normal')
    safeDrawText(museoInfo.value.nombre || 'Sin nombre', 45, yPosition)
    yPosition += 8
    
    if (filtroNivel.value) {
      pdf.setFont('helvetica', 'bold')
      safeDrawText('FILTRO:', 20, yPosition)
      pdf.setFont('helvetica', 'normal')
      safeDrawText(getFiltroLabel(filtroNivel.value), 45, yPosition)
      yPosition += 8
    }
    
    yPosition += 10

    // Función recursiva para dibujar nodos
    const drawNode = (node, level = 0) => {
      checkNewPage(15)
      
      const indent = 20 + (level * 10)
      const nodeText = `${node.nombre} (${node.tipo})`
      
      pdf.setFont('helvetica', level === 0 ? 'bold' : 'normal')
      pdf.setFontSize(level === 0 ? 11 : 10)
      safeDrawText(nodeText, indent, yPosition)
      yPosition += 6
      
      // Mostrar empleados
      if (node.jefes && node.jefes.length > 0) {
        node.jefes.forEach(jefe => {
          checkNewPage(10)
          pdf.setFont('helvetica', 'bold')
          pdf.setFontSize(9)
          safeDrawText(`👤 JEFE: ${jefe.nombre_completo} - ${jefe.cargo}`, indent + 5, yPosition)
          yPosition += 5
        })
      }
      
      if (node.personal && node.personal.length > 0) {
        node.personal.forEach(emp => {
          checkNewPage(10)
          pdf.setFont('helvetica', 'normal')
          pdf.setFontSize(9)
          safeDrawText(`👤 ${emp.nombre_completo} - ${emp.cargo}`, indent + 5, yPosition)
          yPosition += 5
        })
      }
      
      // Dibujar hijos (solo si no hay filtro activo)
      if (!filtroNivel.value && node.children) {
        node.children.forEach(child => {
          drawNode(child, level + 1)
        })
      }
      
      yPosition += 3
    }
    
    // Dibujar todos los nodos
    organigramaFiltrado.value.forEach(node => {
      drawNode(node)
    })
    
    // Pie de página
    checkNewPage(20)
    yPosition += 10
    pdf.setLineWidth(0.5)
    pdf.line(20, yPosition, pageWidth - 20, yPosition)
    yPosition += 8
    
    pdf.setFontSize(10)
    pdf.setFont('helvetica', 'normal')
    const fechaGeneracion = new Date().toLocaleString('es-ES')
    safeDrawText(`Generado el: ${fechaGeneracion}`, 20, yPosition)
    safeDrawText('Sistema de Gestión de Museos', pageWidth - 20, yPosition, { align: 'right' })
    
    // Guardar PDF
    const nombreArchivo = `organigrama_${museoInfo.value.nombre.replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.pdf`
    pdf.save(nombreArchivo)
    
  } catch (error) {
    console.error('Error al exportar PDF:', error)
    alert('Error al generar el PDF. Por favor intente nuevamente.')
  } finally {
    exportingPDF.value = false
  }
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
  grid-template-columns: 1fr 1fr auto;
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

/* Estilo mejorado para el botón de exportar PDF */
.export-button {
  background: linear-gradient(135deg, #059669 0%, #047857 100%);
  color: white;
  border: none;
  padding: 0.875rem 1.75rem;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
  white-space: nowrap;
  align-self: end;
  height: fit-content;
  min-width: 160px;
}

.export-button:hover:not(:disabled) {
  background: linear-gradient(135deg, #047857 0%, #065f46 100%);
  transform: translateY(-1px);
  box-shadow: 0 6px 12px rgba(5, 150, 105, 0.4);
}

.export-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.export-button:active {
  transform: translateY(0);
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

/* Responsive mejoras */
@media (max-width: 1024px) {
  .selection-container {
    gap: 1.5rem;
    padding: 1rem 1.25rem;
  }
  
  select {
    min-width: 180px;
  }
  
  .export-button {
    min-width: 140px;
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

  .export-button {
    width: 100%;
    justify-self: center;
    min-width: unset;
    margin-top: 0;
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