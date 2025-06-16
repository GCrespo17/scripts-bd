<template>
  <div class="reporte-estructura-view">
    <div class="reporte-estructura-container">
      <header class="view-header">
        <h1>Reporte de Estructura Física</h1>
        <p>Análisis detallado de la infraestructura del museo</p>
      </header>

      <!-- Selector de Museo -->
      <div class="selection-container card">
        <label for="museo-select">Seleccionar Museo:</label>
        <select id="museo-select" v-model="selectedMuseo" @change="fetchReporte">
          <option disabled value="">Seleccione un museo para generar el reporte</option>
          <option v-for="museo in museos" :key="museo.id" :value="museo.id">
            {{ museo.nombre }}
          </option>
        </select>
        <button 
          v-if="reporte" 
          @click="exportToPDF" 
          :disabled="exportingPDF"
          class="export-pdf-btn"
        >
          <span v-if="exportingPDF">📄 Generando PDF...</span>
          <span v-else>📄 Exportar PDF</span>
        </button>
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
        </section>

        <!-- Estructura Física Detallada -->
        <section class="structure-detail">
          <h3>🏗️ Estructura Física Detallada</h3>
          <div class="structure-tree">
            <ReporteEstructuraNode 
              v-for="edificio in reporte.estructura_fisica" 
              :key="edificio.id" 
              :node="edificio"
              :level="0" 
            />
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
            <p><strong>Sistema de Gestión de Museos</strong> - v2024.2</p>
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
const reporte = ref(null)
const loadingMuseos = ref(false)
const loadingReporte = ref(false)
const errorReporte = ref(null)
const exportingPDF = ref(false)

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

const exportToPDF = async () => {
  exportingPDF.value = true
  
  try {
    // Importación dinámica de jsPDF
    const jsPDF = (await import('jspdf')).default
    
    // Crear el PDF en orientación vertical A4
    const pdf = new jsPDF('portrait', 'mm', 'a4')
    const pageWidth = pdf.internal.pageSize.getWidth()
    const pageHeight = pdf.internal.pageSize.getHeight()
    let yPosition = 20
    
    // Función helper para verificar si necesitamos nueva página
    const checkNewPage = (requiredHeight) => {
      if (yPosition + requiredHeight > pageHeight - 20) {
        pdf.addPage()
        yPosition = 20
        return true
      }
      return false
    }
    
    // Función para agregar texto con ajuste automático
    const addWrappedText = (text, x, maxWidth, fontSize = 10) => {
      pdf.setFontSize(fontSize)
      const lines = pdf.splitTextToSize(text, maxWidth)
      const lineHeight = fontSize * 0.4
      
      checkNewPage(lines.length * lineHeight)
      
      lines.forEach(line => {
        pdf.text(line, x, yPosition)
        yPosition += lineHeight
      })
      return yPosition
    }
    
    // HEADER DEL DOCUMENTO
    pdf.setFontSize(18)
    pdf.setFont('helvetica', 'bold')
    pdf.text('REPORTE DE ESTRUCTURA FÍSICA', pageWidth / 2, yPosition, { align: 'center' })
    yPosition += 15
    
    // Línea separadora
    pdf.setLineWidth(0.5)
    pdf.line(20, yPosition, pageWidth - 20, yPosition)
    yPosition += 10
    
    // INFORMACIÓN DEL MUSEO
    pdf.setFontSize(14)
    pdf.setFont('helvetica', 'bold')
    pdf.text('MUSEO:', 20, yPosition)
    pdf.setFont('helvetica', 'normal')
    pdf.text(reporte.value.museo.nombre, 45, yPosition)
    yPosition += 8
    
    pdf.setFont('helvetica', 'bold')
    pdf.text('FECHA REPORTE:', 20, yPosition)
    pdf.setFont('helvetica', 'normal')
    pdf.text(new Date().toLocaleDateString('es-ES'), 70, yPosition)
    yPosition += 10
    
    // Línea separadora
    pdf.setLineWidth(0.3)
    pdf.line(20, yPosition, pageWidth - 20, yPosition)
    yPosition += 10
    
    // ESTRUCTURA FÍSICA
    pdf.setFontSize(14)
    pdf.setFont('helvetica', 'bold')
    pdf.text('ESTRUCTURA FÍSICA DETALLADA:', 20, yPosition)
    yPosition += 10
    
    // Función recursiva para dibujar la estructura física (VERSIÓN CORREGIDA)
    const drawEstructuraNode = (node, level = 0, parentNumber = '', siblingIndex = 0) => {
      const indent = 20 + (level * 15)
      
      let nodeNumber
      if (level === 0) {
        nodeNumber = (siblingIndex + 1).toString()
      } else {
        nodeNumber = parentNumber + '.' + (siblingIndex + 1)
      }
      
      const contentMaxWidth = pageWidth - indent - 25
      
      // --- Inicio del cálculo de altura preciso ---
      let calculatedHeight = 0
      const lineHeightSmall = 4
      const lineHeightMedium = 5
      const lineHeightLarge = 6
      const collectionLineHeight = 3

      const titleText = `${nodeNumber}. ${node.nombre} (${node.tipo})`
      const titleLines = pdf.splitTextToSize(titleText, contentMaxWidth)
      calculatedHeight += titleLines.length * lineHeightMedium + 4

      if (node.descripcion) {
        const descLines = pdf.splitTextToSize(node.descripcion, contentMaxWidth)
        calculatedHeight += descLines.slice(0, 2).length * lineHeightSmall + 2
      }
      
      if (node.direccion && node.tipo === 'EDIFICIO') {
        calculatedHeight += lineHeightLarge
      }
      
      if (node.total_salas > 0) {
        calculatedHeight += lineHeightLarge
      }
      
      if (node.salas && node.salas.length > 0) {
        calculatedHeight += 4 // 'SALAS:'
        node.salas.forEach((sala) => {
          calculatedHeight += lineHeightSmall // • Sala Nombre
          
          if (sala.colecciones && sala.colecciones.length > 0) {
            sala.colecciones.forEach((coleccion) => {
              const coleccionText = `  - ${coleccion.nombre} (${coleccion.total_obras} obras)`
              const coleccionLines = pdf.splitTextToSize(coleccionText, contentMaxWidth - 10)
              calculatedHeight += coleccionLines.length * collectionLineHeight
            })
          }
        })
        calculatedHeight += 2
      }
      
      const nodeHeight = calculatedHeight + 5 // + padding final
      // --- Fin del cálculo de altura ---
      
      checkNewPage(nodeHeight)
      
      const startY = yPosition

      const bgColors = {
        'EDIFICIO': [230, 245, 255],
        'PISO': [230, 255, 230],     
        'AREA': [255, 240, 230],
      }
      const bgColor = bgColors[node.tipo] || [245, 245, 245]
      
      pdf.setFillColor(bgColor[0], bgColor[1], bgColor[2])
      pdf.rect(indent, yPosition - 4, pageWidth - indent - 20, nodeHeight, 'F')
      
      pdf.setDrawColor(100, 100, 100)
      pdf.setLineWidth(0.2)
      pdf.rect(indent, yPosition - 4, pageWidth - indent - 20, nodeHeight)
      
      pdf.setFontSize(12)
      pdf.setFont('helvetica', 'bold')
      pdf.setTextColor(0, 0, 0)
      
      titleLines.forEach((line, index) => {
        pdf.text(line, indent + 3, yPosition + 2 + (index * 5))
      })
      yPosition += titleLines.length * 5 + 3
      
      if (node.descripcion) {
        pdf.setFontSize(9)
        pdf.setFont('helvetica', 'italic')
        pdf.setTextColor(80, 80, 80)
        const descLines = pdf.splitTextToSize(node.descripcion, contentMaxWidth)
        descLines.slice(0, 2).forEach(line => {
          pdf.text(line, indent + 3, yPosition)
          yPosition += 4
        })
      }
      
      if (node.direccion && node.tipo === 'EDIFICIO') {
        pdf.setFontSize(9)
        pdf.setFont('helvetica', 'normal')
        pdf.setTextColor(60, 60, 60)
        pdf.text(`📍 ${node.direccion}`, indent + 3, yPosition)
        yPosition += 6
      }
      
      if (node.total_salas > 0) {
        pdf.setFontSize(9)
        pdf.setFont('helvetica', 'normal')
        pdf.setTextColor(0, 0, 0)
        pdf.text(`🏛️ ${node.total_salas} sala${node.total_salas > 1 ? 's' : ''} de exposición`, indent + 3, yPosition)
        yPosition += 6
      }
      
      if (node.salas && node.salas.length > 0) {
        pdf.setFontSize(8)
        pdf.setFont('helvetica', 'bold')
        pdf.setTextColor(0, 0, 0)
        pdf.text('SALAS:', indent + 5, yPosition)
        yPosition += 4
        
        node.salas.forEach((sala) => {
          pdf.setFont('helvetica', 'normal')
          pdf.text(`• ${sala.nombre}`, indent + 10, yPosition)
          yPosition += 4
          
          if (sala.colecciones && sala.colecciones.length > 0) {
            sala.colecciones.forEach((coleccion) => {
              pdf.setFontSize(7)
              pdf.setTextColor(100, 100, 100)
              const coleccionText = `  - ${coleccion.nombre} (${coleccion.total_obras} obras)`
              const coleccionLines = pdf.splitTextToSize(coleccionText, contentMaxWidth - 10)
              coleccionLines.forEach(line => {
                pdf.text(line, indent + 15, yPosition)
                yPosition += collectionLineHeight
              })
            })
            pdf.setFontSize(8)
            pdf.setTextColor(0, 0, 0)
          }
        })
        yPosition += 2
      }
      
      // Forzar la posición Y para evitar errores de acumulación
      yPosition = startY + nodeHeight + 2 
      
      // Procesar hijos
      if (node.children && node.children.length > 0) {
        node.children.forEach((child, childIndex) => {
          drawEstructuraNode(child, level + 1, nodeNumber, childIndex)
        })
      }
    }
    
    // Dibujar todos los nodos raíz
    reporte.value.estructura_fisica.forEach((rootNode, index) => {
      drawEstructuraNode(rootNode, 0, '', index)
    })
    
    yPosition += 5; // Espacio extra antes de la siguiente sección

    // EXPOSICIONES ACTUALES
    if (reporte.value.exposiciones_actuales && reporte.value.exposiciones_actuales.length > 0) {
      checkNewPage(20)
      
      pdf.setFontSize(14)
      pdf.setFont('helvetica', 'bold')
      pdf.text('EXPOSICIONES Y EVENTOS ACTUALES:', 20, yPosition)
      yPosition += 10
      
      reporte.value.exposiciones_actuales.forEach((expo, index) => {
        checkNewPage(15)
        
        pdf.setFontSize(11)
        pdf.setFont('helvetica', 'bold')
        pdf.text(`${index + 1}. ${expo.nombre}`, 25, yPosition)
        yPosition += 6
        
        pdf.setFontSize(9)
        pdf.setFont('helvetica', 'normal')
        pdf.text(`Sala: ${expo.sala}`, 30, yPosition)
        yPosition += 6
      })
    }
    
    // FOOTER
    const totalPages = pdf.internal.getNumberOfPages()
    for (let i = 1; i <= totalPages; i++) {
      pdf.setPage(i)
      pdf.setFontSize(8)
      pdf.setFont('helvetica', 'normal')
      pdf.setTextColor(100, 100, 100)
      
      // Fecha de generación
      const fechaGeneracion = new Date().toLocaleString('es-ES')
      pdf.text(`Generado el: ${fechaGeneracion}`, 20, pageHeight - 10)
      
      // Número de página
      pdf.text(`Página ${i} de ${totalPages}`, pageWidth - 40, pageHeight - 10)
    }
    
    // Generar nombre del archivo
    const fecha = new Date().toLocaleDateString('es-ES').replace(/\//g, '-')
    const nombreArchivo = `Estructura_Fisica_${reporte.value.museo.nombre.replace(/\s+/g, '_')}_${fecha}.pdf`
    
    // Descargar el PDF
    pdf.save(nombreArchivo)

  } catch (error) {
    console.error('Error al exportar PDF:', error)
    alert('Error al generar el PDF. Por favor, inténtelo de nuevo.')
  } finally {
    exportingPDF.value = false
  }
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
  gap: 1rem;
  flex-wrap: wrap;
}

.selection-container label {
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
  min-width: 200px;
}

select:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.export-pdf-btn {
  padding: 0.75rem 1.5rem;
  background: #DC2626;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.export-pdf-btn:hover:not(:disabled) {
  background: #B91C1C;
}

.export-pdf-btn:disabled {
  background: #9CA3AF;
  cursor: not-allowed;
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

/* Responsive */
@media (max-width: 768px) {
  .selection-container {
    flex-direction: column;
    align-items: stretch;
  }
  

  
  .exhibitions-table {
    font-size: 0.875rem;
  }
  
  .exhibitions-table th,
  .exhibitions-table td {
    padding: 0.75rem 0.5rem;
  }
}
</style> 