<template>
    <div class="ficha-museo">
      <!-- Header con selector de museo -->
      <div class="museo-selector">
        <h1 class="page-title">📄 Ficha Detallada de Museo</h1>
        <div class="selector-container">
          <label for="museoSelect">Seleccionar Museo:</label>
          <select id="museoSelect" v-model="selectedMuseoId" @change="cargarFichaMuseo" class="form-select">
            <option value="">-- Seleccione un museo --</option>
            <option v-for="museo in museos" :key="museo.id" :value="museo.id">
              {{ museo.nombre }}
            </option>
          </select>
        </div>
      </div>
  
      <!-- Loading State -->
      <div v-if="loading" class="loading-container">
        <div class="spinner"></div>
        <p>Cargando ficha del museo...</p>
      </div>
  
      <!-- Error State -->
      <div v-if="error" class="error-container">
        <div class="error-message">
          <h3>❌ Error al cargar los datos</h3>
          <p>{{ error }}</p>
          <button @click="cargarFichaMuseo" class="btn-retry">🔄 Reintentar</button>
        </div>
      </div>
  
      <!-- Ficha del Museo -->
      <div v-if="fichaMuseo && !loading" class="ficha-content">
        <!-- Información Básica -->
        <div class="info-basica-card">
          <h2 class="section-title">🏛️ Información Básica</h2>
          <div class="info-grid">
            <div class="info-item">
              <strong>Nombre:</strong>
              <span>{{ fichaMuseo.nombre }}</span>
            </div>
            <div class="info-item">
              <strong>Fecha de Fundación:</strong>
              <span>{{ formatearFecha(fichaMuseo.fecha_fundacion) }}</span>
            </div>
            <div class="info-item" v-if="fichaMuseo.ranking?.ubicacion">
              <strong>Ubicación:</strong>
              <span>{{ fichaMuseo.ranking.ubicacion.ciudad }}, {{ fichaMuseo.ranking.ubicacion.pais }}</span>
            </div>
            <div class="info-item mision">
              <strong>Misión:</strong>
              <span>{{ fichaMuseo.mision }}</span>
            </div>
          </div>
        </div>
  
        <!-- Ranking Comparativo -->
        <div v-if="fichaMuseo.ranking && fichaMuseo.ranking.ranking" class="ranking-card">
          <h2 class="section-title">🏆 Ranking y Evaluación</h2>
          
          <!-- Score y Categoría -->
          <div class="ranking-header">
            <div class="score-display">
              <div class="score-number">{{ fichaMuseo.ranking.ranking.score_final || 0 }}</div>
              <div class="score-label">Puntaje Final</div>
            </div>
            <div class="categoria-display">
              <div class="categoria-badge" :class="getCategoriaClass(fichaMuseo.ranking.ranking.categoria)">
                {{ fichaMuseo.ranking.ranking.categoria || 'Sin clasificar' }}
              </div>
            </div>
          </div>
  
          <!-- Rankings Comparativos -->
          <div class="rankings-grid">
            <div class="ranking-item nacional">
              <h4>🏅 Ranking Nacional</h4>
              <div class="ranking-position">
                <span class="position-number">{{ fichaMuseo.ranking.ranking.posicion_nacional || 'N/A' }}</span>
                <span class="position-separator">de</span>
                <span class="total-number">{{ fichaMuseo.ranking.ranking.total_nacional || 'N/A' }}</span>
              </div>
              <div class="ranking-context">
                en {{ fichaMuseo.ranking.ubicacion?.pais || 'País no disponible' }}
              </div>
              <div class="ranking-percentage" v-if="fichaMuseo.ranking.ranking.posicion_nacional && fichaMuseo.ranking.ranking.total_nacional">
                Top {{ Math.round((fichaMuseo.ranking.ranking.posicion_nacional / fichaMuseo.ranking.ranking.total_nacional) * 100) }}%
              </div>
            </div>
            <div class="ranking-item mundial">
              <h4>🌍 Ranking Mundial</h4>
              <div class="ranking-position">
                <span class="position-number">{{ fichaMuseo.ranking.ranking.posicion_mundial || 'N/A' }}</span>
                <span class="position-separator">de</span>
                <span class="total-number">{{ fichaMuseo.ranking.ranking.total_mundial || 'N/A' }}</span>
              </div>
              <div class="ranking-context">
                a nivel mundial
              </div>
              <div class="ranking-percentage" v-if="fichaMuseo.ranking.ranking.posicion_mundial && fichaMuseo.ranking.ranking.total_mundial">
                Top {{ Math.round((fichaMuseo.ranking.ranking.posicion_mundial / fichaMuseo.ranking.ranking.total_mundial) * 100) }}%
              </div>
            </div>
          </div>
  
          <!-- Métricas Detalladas -->
          <div class="metricas-section">
            <h4>📊 Métricas de Evaluación</h4>
            <div class="metricas-grid">
              <div class="metrica-item">
                <div class="metrica-icon">⏱️</div>
                <div class="metrica-content">
                  <div class="metrica-value">{{ (fichaMuseo.ranking.metricas?.antiguedad_promedio_anios || 0).toFixed(1) }} años</div>
                  <div class="metrica-label">Antigüedad Promedio del Personal</div>
                </div>
              </div>
              <div class="metrica-item">
                <div class="metrica-icon">🔄</div>
                <div class="metrica-content">
                  <div class="metrica-value">{{ (fichaMuseo.ranking.metricas?.tasa_rotacion_alta_pct || 0).toFixed(1) }}%</div>
                  <div class="metrica-label">Tasa de Rotación Alta</div>
                </div>
              </div>
              <div class="metrica-item">
                <div class="metrica-icon">👥</div>
                <div class="metrica-content">
                  <div class="metrica-value">{{ (fichaMuseo.ranking.metricas?.visitas_ultimo_anio || 0).toLocaleString() }}</div>
                  <div class="metrica-label">Visitas Último Año</div>
                </div>
              </div>
            </div>
          </div>

          <!-- Indicador de Posición Visual -->
          <div class="posicion-visual" v-if="fichaMuseo.ranking.ranking.posicion_nacional && fichaMuseo.ranking.ranking.posicion_mundial">
            <h4>🎯 Posición Comparativa</h4>
            <div class="indicadores-posicion">
              <div class="indicador nacional-indicator">
                <div class="indicador-label">Nacional ({{ fichaMuseo.ranking.ubicacion?.pais }})</div>
                <div class="progress-bar">
                  <div class="progress-fill nacional" 
                       :style="{ width: `${Math.max(10, 100 - ((fichaMuseo.ranking.ranking.posicion_nacional - 1) / (fichaMuseo.ranking.ranking.total_nacional - 1)) * 100)}%` }">
                  </div>
                </div>
                <div class="posicion-texto">Posición {{ fichaMuseo.ranking.ranking.posicion_nacional }}</div>
              </div>
              <div class="indicador mundial-indicator">
                <div class="indicador-label">Mundial</div>
                <div class="progress-bar">
                  <div class="progress-fill mundial" 
                       :style="{ width: `${Math.max(5, 100 - ((fichaMuseo.ranking.ranking.posicion_mundial - 1) / (fichaMuseo.ranking.ranking.total_mundial - 1)) * 100)}%` }">
                  </div>
                </div>
                <div class="posicion-texto">Posición {{ fichaMuseo.ranking.ranking.posicion_mundial }}</div>
              </div>
            </div>
          </div>
        </div>
  
        <!-- Mensaje cuando no hay datos de ranking -->
        <div v-else-if="fichaMuseo && !fichaMuseo.ranking" class="ranking-card no-ranking">
          <h2 class="section-title">🏆 Ranking y Evaluación</h2>
          <div class="no-data-message">
            <p>📊 No hay suficientes datos disponibles para calcular el ranking de este museo.</p>
            <p>Esto puede deberse a que el museo no tiene empleados registrados o no hay registros de ventas de tickets.</p>
          </div>
        </div>
  
        <!-- Historia del Museo -->
        <div v-if="fichaMuseo.historia && fichaMuseo.historia.length > 0" class="historia-card">
          <h2 class="section-title">📚 Historia del Museo</h2>
          <div class="timeline">
            <div v-for="hecho in fichaMuseo.historia" :key="hecho.anio" class="timeline-item">
              <div class="timeline-year">{{ hecho.anio }}</div>
              <div class="timeline-content">{{ hecho.hecho }}</div>
            </div>
          </div>
        </div>
  
        <!-- Colecciones Permanentes -->
        <div v-if="fichaMuseo.colecciones && fichaMuseo.colecciones.length > 0" class="colecciones-card">
          <h2 class="section-title">🎨 Colecciones Permanentes</h2>
          <div class="colecciones-grid">
            <div v-for="coleccion in fichaMuseo.colecciones" :key="coleccion.id" class="coleccion-item">
              <h4 class="coleccion-nombre">{{ coleccion.nombre }}</h4>
              <p class="coleccion-caracteristicas">{{ coleccion.caracteristicas }}</p>
              <div class="coleccion-tag">{{ coleccion.palabra_clave }}</div>
            </div>
          </div>
        </div>
  
        <!-- Botón de Impresión -->
        <div class="print-section">
          <button @click="imprimirFicha" class="print-button">
            <span class="print-icon">📄</span>
            <span>Exportar a PDF</span>
          </button>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import jsPDF from 'jspdf'
  import axios from 'axios'
  
  const museos = ref([])
  const selectedMuseoId = ref('')
  const fichaMuseo = ref(null)
  const loading = ref(false)
  const error = ref(null)
  
  async function cargarMuseos() {
    try {
      const response = await axios.get('http://localhost:3000/api/museos')
      museos.value = response.data
    } catch (error) {
      console.error('Error al cargar museos:', error)
      error.value = 'Error al cargar la lista de museos'
    }
  }
  
  async function cargarFichaMuseo() {
    if (!selectedMuseoId.value) {
      fichaMuseo.value = null
      return
    }
  
    loading.value = true
    error.value = null
  
    try {
      const response = await axios.get(`http://localhost:3000/api/museos/${selectedMuseoId.value}`)
      fichaMuseo.value = response.data
      console.log('Ficha del museo cargada:', fichaMuseo.value)
    } catch (error) {
      console.error('Error al cargar ficha del museo:', error)
      error.value = error.response?.data?.message || 'Error al cargar la ficha del museo'
      fichaMuseo.value = null
    } finally {
      loading.value = false
    }
  }
  
  function formatearFecha(fecha) {
    if (!fecha) return 'No disponible'
    return new Date(fecha).toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })
  }
  
  function getCategoriaClass(categoria) {
    if (!categoria) return 'categoria-sin-clasificar'
    if (categoria.includes('Excelente')) return 'categoria-excelente'
    if (categoria.includes('Bueno')) return 'categoria-bueno'
    if (categoria.includes('Regular')) return 'categoria-regular'
    return 'categoria-desarrollo'
  }
  
  function imprimirFicha() {
    if (!fichaMuseo.value) {
      alert('No hay datos de museo para exportar')
      return
    }

    const doc = new jsPDF()
    let yPosition = 20
    const pageWidth = doc.internal.pageSize.getWidth()
    const leftMargin = 20
    const rightMargin = pageWidth - 20
    
    // Función auxiliar para agregar texto con salto de línea automático
    const addWrappedText = (text, x, y, maxWidth, lineHeight = 7) => {
      const lines = doc.splitTextToSize(text, maxWidth)
      lines.forEach((line, index) => {
        doc.text(line, x, y + (index * lineHeight))
      })
      return y + (lines.length * lineHeight)
    }
    
    // Función auxiliar para agregar línea divisoria
    const addDivider = (y) => {
      doc.setLineWidth(0.5)
      doc.line(leftMargin, y, rightMargin, y)
      return y + 10
    }
    
    // ENCABEZADO
    doc.setFontSize(20)
    doc.setFont(undefined, 'bold')
    doc.text('FICHA DETALLADA DE MUSEO', pageWidth / 2, yPosition, { align: 'center' })
    
    yPosition += 15
    doc.setFontSize(12)
    doc.setFont(undefined, 'normal')
    doc.text(`Generado el: ${new Date().toLocaleDateString('es-ES')}`, pageWidth / 2, yPosition, { align: 'center' })
    
    yPosition = addDivider(yPosition + 10)
    
    // INFORMACIÓN BÁSICA
    doc.setFontSize(16)
    doc.setFont(undefined, 'bold')
    doc.text('INFORMACIÓN BÁSICA', leftMargin, yPosition)
    yPosition += 10
    
    doc.setFontSize(11)
    doc.setFont(undefined, 'normal')
    
    // Nombre del museo
    doc.setFont(undefined, 'bold')
    doc.text('Nombre:', leftMargin, yPosition)
    doc.setFont(undefined, 'normal')
    yPosition = addWrappedText(fichaMuseo.value.nombre, leftMargin + 25, yPosition, rightMargin - leftMargin - 25)
    yPosition += 5
    
    // Ubicación
    if (fichaMuseo.value.ranking?.ubicacion) {
      doc.setFont(undefined, 'bold')
      doc.text('Ubicación:', leftMargin, yPosition)
      doc.setFont(undefined, 'normal')
      doc.text(`${fichaMuseo.value.ranking.ubicacion.ciudad}, ${fichaMuseo.value.ranking.ubicacion.pais}`, leftMargin + 25, yPosition)
      yPosition += 7
    }
    
    // Fecha de fundación
    doc.setFont(undefined, 'bold')
    doc.text('Fundación:', leftMargin, yPosition)
    doc.setFont(undefined, 'normal')
    doc.text(formatearFecha(fichaMuseo.value.fecha_fundacion), leftMargin + 25, yPosition)
    yPosition += 7
    
    // Misión
    doc.setFont(undefined, 'bold')
    doc.text('Misión:', leftMargin, yPosition)
    doc.setFont(undefined, 'normal')
    yPosition = addWrappedText(fichaMuseo.value.mision, leftMargin + 25, yPosition, rightMargin - leftMargin - 25)
    
    yPosition = addDivider(yPosition + 5)
    
    // RANKING Y EVALUACIÓN
    if (fichaMuseo.value.ranking?.ranking) {
      doc.setFontSize(16)
      doc.setFont(undefined, 'bold')
      doc.text('RANKING Y EVALUACIÓN', leftMargin, yPosition)
      yPosition += 10
      
      doc.setFontSize(11)
      
      // Score y categoría
      doc.setFont(undefined, 'bold')
      doc.text('Puntaje Final:', leftMargin, yPosition)
      doc.setFont(undefined, 'normal')
      doc.text(`${fichaMuseo.value.ranking.ranking.score_final || 0}/10`, leftMargin + 30, yPosition)
      yPosition += 7
      
      doc.setFont(undefined, 'bold')
      doc.text('Categoría:', leftMargin, yPosition)
      doc.setFont(undefined, 'normal')
      doc.text(`${fichaMuseo.value.ranking.ranking.categoria || 'Sin clasificar'}`, leftMargin + 25, yPosition)
      yPosition += 5
      
      // Rankings comparativos
      if (fichaMuseo.value.ranking.ranking.posicion_nacional) {
        doc.setFont(undefined, 'bold')
        doc.text('Ranking Nacional:', leftMargin, yPosition)
        doc.setFont(undefined, 'normal')
        const rankingNacionalText = `Posición ${fichaMuseo.value.ranking.ranking.posicion_nacional} de ${fichaMuseo.value.ranking.ranking.total_nacional} museos en ${fichaMuseo.value.ranking.ubicacion?.pais || 'el país'}`
        yPosition = addWrappedText(rankingNacionalText, leftMargin + 35, yPosition, rightMargin - leftMargin - 35)
        yPosition += 3
        
        // Calcular porcentaje nacional
        const porcentajeNacional = Math.round((fichaMuseo.value.ranking.ranking.posicion_nacional / fichaMuseo.value.ranking.ranking.total_nacional) * 100)
        doc.setFont(undefined, 'italic')
        doc.text(`(Top ${porcentajeNacional}% nacional)`, leftMargin + 35, yPosition)
        yPosition += 7
      }
      
      if (fichaMuseo.value.ranking.ranking.posicion_mundial) {
        doc.setFont(undefined, 'bold')
        doc.text('Ranking Mundial:', leftMargin, yPosition)
        doc.setFont(undefined, 'normal')
        const rankingMundialText = `Posición ${fichaMuseo.value.ranking.ranking.posicion_mundial} de ${fichaMuseo.value.ranking.ranking.total_mundial} museos a nivel mundial`
        yPosition = addWrappedText(rankingMundialText, leftMargin + 35, yPosition, rightMargin - leftMargin - 35)
        yPosition += 3
        
        // Calcular porcentaje mundial
        const porcentajeMundial = Math.round((fichaMuseo.value.ranking.ranking.posicion_mundial / fichaMuseo.value.ranking.ranking.total_mundial) * 100)
        doc.setFont(undefined, 'italic')
        doc.text(`(Top ${porcentajeMundial}% mundial)`, leftMargin + 35, yPosition)
        yPosition += 7
      }
      
      yPosition = addDivider(yPosition + 5)
    }
    
    // MÉTRICAS DETALLADAS
    if (fichaMuseo.value.ranking?.metricas) {
      doc.setFontSize(16)
      doc.setFont(undefined, 'bold')
      doc.text('MÉTRICAS DETALLADAS', leftMargin, yPosition)
      yPosition += 10
      
      doc.setFontSize(11)
      
      // Estabilidad del personal
      doc.setFont(undefined, 'bold')
      doc.text('Estabilidad del Personal:', leftMargin, yPosition)
      yPosition += 7
      
      doc.setFont(undefined, 'normal')
      doc.text(`• Antigüedad promedio: ${(fichaMuseo.value.ranking.metricas.antiguedad_promedio_anios || 0).toFixed(1)} años`, leftMargin + 5, yPosition)
      yPosition += 6
      doc.text(`• Tasa de rotación alta (<5 años): ${(fichaMuseo.value.ranking.metricas.tasa_rotacion_alta_pct || 0).toFixed(1)}%`, leftMargin + 5, yPosition)
      yPosition += 8
      
      // Popularidad
      doc.setFont(undefined, 'bold')
      doc.text('Popularidad:', leftMargin, yPosition)
      yPosition += 7
      
      doc.setFont(undefined, 'normal')
      doc.text(`• Visitas último año: ${(fichaMuseo.value.ranking.metricas.visitas_ultimo_anio || 0).toLocaleString()} visitantes`, leftMargin + 5, yPosition)
      yPosition += 7
      
      yPosition = addDivider(yPosition + 5)
    }
    
    // Verificar si necesitamos nueva página
    if (yPosition > 250) {
      doc.addPage()
      yPosition = 20
    }
    
    // HISTORIAL DEL MUSEO
    if (fichaMuseo.value.historia && fichaMuseo.value.historia.length > 0) {
      doc.setFontSize(16)
      doc.setFont(undefined, 'bold')
      doc.text('HISTORIAL DEL MUSEO', leftMargin, yPosition)
      yPosition += 10
      
      doc.setFontSize(10)
      doc.setFont(undefined, 'normal')
      
      fichaMuseo.value.historia.forEach((hecho, index) => {
        // Verificar espacio en página
        if (yPosition > 270) {
          doc.addPage()
          yPosition = 20
        }
        
        doc.setFont(undefined, 'bold')
        doc.text(`${hecho.anio}:`, leftMargin, yPosition)
        doc.setFont(undefined, 'normal')
        yPosition = addWrappedText(hecho.hecho, leftMargin + 15, yPosition, rightMargin - leftMargin - 15, 5)
        yPosition += 3
      })
      
      yPosition = addDivider(yPosition + 5)
    }
    
    // COLECCIONES PERMANENTES
    if (fichaMuseo.value.colecciones && fichaMuseo.value.colecciones.length > 0) {
      // Verificar si necesitamos nueva página
      if (yPosition > 200) {
        doc.addPage()
        yPosition = 20
      }
      
      doc.setFontSize(16)
      doc.setFont(undefined, 'bold')
      doc.text('COLECCIONES PERMANENTES', leftMargin, yPosition)
      yPosition += 10
      
      doc.setFontSize(10)
      doc.setFont(undefined, 'normal')
      
      fichaMuseo.value.colecciones.forEach((coleccion, index) => {
        // Verificar espacio en página
        if (yPosition > 260) {
          doc.addPage()
          yPosition = 20
        }
        
        doc.setFont(undefined, 'bold')
        yPosition = addWrappedText(`${index + 1}. ${coleccion.nombre}`, leftMargin, yPosition, rightMargin - leftMargin, 6)
        
        doc.setFont(undefined, 'normal')
        yPosition = addWrappedText(`Características: ${coleccion.caracteristicas}`, leftMargin + 5, yPosition, rightMargin - leftMargin - 5, 5)
        
        if (coleccion.palabra_clave) {
          yPosition = addWrappedText(`Palabra clave: ${coleccion.palabra_clave}`, leftMargin + 5, yPosition, rightMargin - leftMargin - 5, 5)
        }
        yPosition += 5
      })
    }
    
    // PIE DE PÁGINA
    const totalPages = doc.internal.getNumberOfPages()
    for (let i = 1; i <= totalPages; i++) {
      doc.setPage(i)
      doc.setFontSize(8)
      doc.setFont(undefined, 'normal')
      doc.text(`Página ${i} de ${totalPages}`, pageWidth / 2, doc.internal.pageSize.getHeight() - 10, { align: 'center' })
      doc.text('Sistema de Gestión de Museos - Reporte Oficial', pageWidth / 2, doc.internal.pageSize.getHeight() - 5, { align: 'center' })
    }
    
    // Guardar el PDF
    const nombreArchivo = `ficha_museo_${fichaMuseo.value.nombre.replace(/[^a-zA-Z0-9]/g, '_')}_${new Date().toISOString().split('T')[0]}.pdf`
    doc.save(nombreArchivo)
  }
  
  onMounted(async () => {
    await cargarMuseos()
  })
  </script>
  
  <style scoped>
  .ficha-museo {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  
  .page-title {
    color: #2c3e50;
    text-align: center;
    margin-bottom: 30px;
    font-size: 2.5rem;
    font-weight: 700;
  }
  
  .museo-selector {
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 30px;
  }
  
  .selector-container {
    display: flex;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
  }
  
  .selector-container label {
    font-weight: 600;
    color: #495057;
    min-width: 140px;
  }
  
  .form-select {
    flex: 1;
    min-width: 250px;
    padding: 12px 15px;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 16px;
    transition: border-color 0.3s ease;
  }
  
  .form-select:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
  }
  
  .loading-container {
    text-align: center;
    padding: 60px 20px;
  }
  
  .spinner {
    width: 50px;
    height: 50px;
    border: 5px solid #f3f3f3;
    border-top: 5px solid #007bff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 20px;
  }
  
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
  
  .error-container {
    display: flex;
    justify-content: center;
    padding: 40px 20px;
  }
  
  .error-message {
    background: #f8d7da;
    color: #721c24;
    padding: 25px;
    border-radius: 8px;
    text-align: center;
    max-width: 500px;
  }
  
  .btn-retry {
    background: #dc3545;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    margin-top: 15px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  
  .btn-retry:hover {
    background: #c82333;
  }
  
  .ficha-content {
    display: flex;
    flex-direction: column;
    gap: 30px;
  }
  
  .info-basica-card,
  .ranking-card,
  .historia-card,
  .colecciones-card {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }
  
  .section-title {
    color: #2c3e50;
    font-size: 1.8rem;
    font-weight: 700;
    margin-bottom: 25px;
    padding-bottom: 10px;
    border-bottom: 3px solid #007bff;
  }
  
  .info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
  }
  
  .info-item {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }
  
  .info-item.mision {
    grid-column: 1 / -1;
  }
  
  .info-item strong {
    color: #495057;
    font-weight: 600;
  }
  
  .info-item span {
    color: #6c757d;
    line-height: 1.5;
  }
  
  .ranking-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    flex-wrap: wrap;
    gap: 20px;
  }
  
  .score-display {
    text-align: center;
  }
  
  .score-number {
    font-size: 3rem;
    font-weight: 700;
    color: #007bff;
  }
  
  .score-label {
    color: #6c757d;
    font-weight: 600;
  }
  
  .categoria-display {
    text-align: center;
  }
  
  .categoria-badge {
    padding: 12px 20px;
    border-radius: 25px;
    font-weight: 600;
    font-size: 1.1rem;
  }
  
  .categoria-excelente {
    background: #d4edda;
    color: #155724;
  }
  
  .categoria-bueno {
    background: #d1ecf1;
    color: #0c5460;
  }
  
  .categoria-regular {
    background: #fff3cd;
    color: #856404;
  }
  
  .categoria-desarrollo {
    background: linear-gradient(135deg, #ffc107, #ff8c00);
    color: white;
  }
  
  .categoria-sin-clasificar {
    background: linear-gradient(135deg, #6c757d, #495057);
    color: white;
  }
  
  .rankings-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
    margin: 25px 0;
  }
  
  .ranking-item {
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    border-radius: 15px;
    padding: 20px;
    border: 2px solid;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
  }
  
  .ranking-item.nacional {
    border-color: #3b82f6;
    box-shadow: 0 4px 15px rgba(59, 130, 246, 0.2);
  }
  
  .ranking-item.mundial {
    border-color: #10b981;
    box-shadow: 0 4px 15px rgba(16, 185, 129, 0.2);
  }
  
  .ranking-item:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
  }
  
  .ranking-item h4 {
    margin: 0 0 15px 0;
    font-size: 1.1rem;
    font-weight: 700;
    color: #1e293b;
  }
  
  .ranking-position {
    display: flex;
    align-items: baseline;
    gap: 8px;
    margin-bottom: 10px;
    flex-wrap: wrap;
  }
  
  .position-number {
    font-size: 2.5rem;
    font-weight: 800;
    color: #1e293b;
    line-height: 1;
  }
  
  .position-separator {
    font-size: 1.2rem;
    color: #64748b;
    font-weight: 500;
  }
  
  .total-number {
    font-size: 1.8rem;
    font-weight: 600;
    color: #475569;
    line-height: 1;
  }
  
  .ranking-context {
    color: #64748b;
    font-size: 0.9rem;
    margin-bottom: 8px;
    font-weight: 500;
  }
  
  .ranking-percentage {
    display: inline-block;
    background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  /* Estilos para los indicadores visuales */
  .posicion-visual {
    background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
    border-radius: 15px;
    padding: 25px;
    margin-top: 30px;
    border: 2px solid #cbd5e1;
  }
  
  .posicion-visual h4 {
    margin: 0 0 20px 0;
    color: #1e293b;
    font-size: 1.2rem;
    text-align: center;
  }
  
  .indicadores-posicion {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .indicador {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }
  
  .indicador-label {
    font-weight: 600;
    color: #374151;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .progress-bar {
    height: 20px;
    background: #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    position: relative;
    border: 2px solid #d1d5db;
  }
  
  .progress-fill {
    height: 100%;
    border-radius: 8px;
    transition: width 0.8s ease-out;
    position: relative;
    overflow: hidden;
  }
  
  .progress-fill.nacional {
    background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
    box-shadow: inset 0 2px 4px rgba(255, 255, 255, 0.3);
  }
  
  .progress-fill.mundial {
    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    box-shadow: inset 0 2px 4px rgba(255, 255, 255, 0.3);
  }
  
  .progress-fill::after {
    content: '';
    position: absolute;
    top: 0;
    left: -50%;
    width: 50%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    animation: shimmer 2s infinite;
  }
  
  @keyframes shimmer {
    0% { left: -50%; }
    100% { left: 100%; }
  }
  
  .posicion-texto {
    font-size: 0.85rem;
    color: #6b7280;
    font-weight: 500;
    text-align: center;
  }
  
  .metricas-section h4 {
    color: #495057;
    margin-bottom: 20px;
    font-size: 1.3rem;
  }
  
  .metricas-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }
  
  .metrica-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 10px;
    border-left: 4px solid #007bff;
  }
  
  .metrica-icon {
    font-size: 2rem;
    width: 50px;
    text-align: center;
  }
  
  .metrica-content {
    flex: 1;
  }
  
  .metrica-value {
    font-size: 1.4rem;
    font-weight: 700;
    color: #2c3e50;
  }
  
  .metrica-label {
    color: #6c757d;
    font-size: 0.9rem;
    margin-top: 4px;
  }
  
  .timeline {
    position: relative;
    padding-left: 30px;
  }
  
  .timeline::before {
    content: '';
    position: absolute;
    left: 15px;
    top: 20px;
    height: calc(100% - 45px);
    width: 2px;
    background: #007bff;
  }
  
  .timeline-item {
    position: relative;
    margin-bottom: 30px;
    padding: 0;
    min-height: 40px;
  }
  
  .timeline-item:last-child {
    margin-bottom: 0;
  }
  
  .timeline-item::before {
    content: '';
    position: absolute;
    left: -23px;
    top: 8px;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: #007bff;
    border: 3px solid white;
    box-shadow: 0 0 0 2px #007bff;
    z-index: 1;
  }
  
  .timeline-year {
    font-weight: 700;
    color: #007bff;
    font-size: 1.1rem;
    margin-bottom: 8px;
    line-height: 1.2;
  }
  
  .timeline-content {
    color: #495057;
    line-height: 1.6;
    margin-left: 0;
    padding-left: 0;
  }
  
  .colecciones-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
  }
  
  .coleccion-item {
    padding: 25px;
    border: 2px solid #e9ecef;
    border-radius: 10px;
    transition: all 0.3s ease;
  }
  
  .coleccion-item:hover {
    border-color: #007bff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.15);
  }
  
  .coleccion-nombre {
    color: #2c3e50;
    margin-bottom: 15px;
    font-size: 1.2rem;
  }
  
  .coleccion-caracteristicas {
    color: #6c757d;
    line-height: 1.5;
    margin-bottom: 15px;
  }
  
  .coleccion-tag {
    display: inline-block;
    background: #007bff;
    color: white;
    padding: 6px 12px;
    border-radius: 15px;
    font-size: 0.85rem;
    font-weight: 600;
  }
  
  .print-section {
    text-align: center;
    padding: 30px 0;
    border-top: 2px solid #e9ecef;
    margin-top: 40px;
  }
  
  .print-button {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
    border: none;
    padding: 15px 30px;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
    display: inline-flex;
    align-items: center;
    gap: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  
  .print-button:hover {
    background: linear-gradient(135deg, #c82333 0%, #a71e2a 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
  }
  
  .print-button:active {
    transform: translateY(0);
    box-shadow: 0 3px 10px rgba(220, 53, 69, 0.3);
  }
  
  .print-icon {
    font-size: 20px;
    filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.2));
  }
  
  .no-ranking {
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    border: 2px dashed #6c757d;
  }
  
  .no-data-message {
    text-align: center;
    padding: 40px 20px;
    color: #6c757d;
  }
  
  .no-data-message p {
    margin-bottom: 15px;
    font-size: 1.1rem;
    line-height: 1.6;
  }
  
  .no-data-message p:first-child {
    font-weight: 600;
    color: #495057;
  }
  
  @media print {
    .museo-selector,
    .print-section {
      display: none;
    }
    
    .ficha-content {
      margin: 0;
      padding: 0;
    }
    
    .section-title {
      color: black !important;
    }
    
    .ranking-item.nacional,
    .ranking-item.mundial {
      background: #f8f9fa !important;
      color: black !important;
      border: 1px solid #dee2e6 !important;
    }
  }
  
  @media (max-width: 768px) {
    .ficha-museo {
      padding: 15px;
    }
    
    .page-title {
      font-size: 2rem;
    }
    
    .selector-container {
      flex-direction: column;
      align-items: stretch;
    }
    
    .ranking-header {
      flex-direction: column;
      text-align: center;
    }
    
    .info-grid {
      grid-template-columns: 1fr;
    }
    
    .rankings-grid {
      grid-template-columns: 1fr;
    }
    
    .metricas-grid {
      grid-template-columns: 1fr;
    }
    
    .colecciones-grid {
      grid-template-columns: 1fr;
    }
  }
  
  /* Responsive */
  @media (max-width: 768px) {
    .container {
      padding: 10px;
    }
    
    .ficha-content {
      gap: 20px;
    }
    
    .museo-selector {
      flex-direction: column;
      gap: 10px;
    }
    
    .rankings-grid {
      grid-template-columns: 1fr;
      gap: 15px;
      margin: 20px 0;
    }
    
    .ranking-item {
      padding: 15px;
    }
    
    .position-number {
      font-size: 2rem;
    }
    
    .total-number {
      font-size: 1.4rem;
    }
    
    .ranking-position {
      justify-content: center;
      text-align: center;
    }
    
    .metricas-grid {
      grid-template-columns: 1fr;
    }
    
    .indicadores-posicion {
      gap: 15px;
    }
    
    .posicion-visual {
      padding: 15px;
      margin-top: 20px;
    }
    
    .progress-bar {
      height: 16px;
    }
    
    .historia-card, .colecciones-card {
      padding: 15px;
    }
    
    .timeline-item {
      padding: 10px;
    }
  }

  @media (max-width: 480px) {
    .rankings-grid {
      gap: 10px;
    }
    
    .ranking-item {
      padding: 12px;
    }
    
    .position-number {
      font-size: 1.8rem;
    }
    
    .total-number {
      font-size: 1.2rem;
    }
    
    .ranking-item h4 {
      font-size: 1rem;
    }
    
    .posicion-visual h4 {
      font-size: 1.1rem;
    }
  }
  </style>