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
        <div class="info-basica-card card">
          <h2 class="section-title">Información del Museo</h2>
          <div class="info-grid">
            <div class="info-item">
              <strong>Nombre:</strong>
              <span>{{ fichaMuseo.nombre }}</span>
            </div>
            <div class="info-item" v-if="fichaMuseo.ranking?.ubicacion">
              <strong>Ubicación:</strong>
              <span>{{ fichaMuseo.ranking.ubicacion.ciudad }}, {{ fichaMuseo.ranking.ubicacion.pais }}</span>
            </div>
            <div class="info-item">
              <strong>Fecha de Fundación:</strong>
              <span>{{ formatearFecha(fichaMuseo.fecha_fundacion) }}</span>
            </div>
            <div class="info-item mision">
              <strong>Misión:</strong>
              <span>{{ fichaMuseo.mision }}</span>
            </div>
            <!-- Ranking Nacional -->
            <div class="info-item" v-if="fichaMuseo.ranking?.posiciones">
              <strong>Ranking Nacional:</strong>
              <span v-if="fichaMuseo.ranking.posiciones.nacional?.posicion">
                {{ fichaMuseo.ranking.posiciones.nacional.posicion }} / {{ fichaMuseo.ranking.posiciones.nacional.total }}
              </span>
              <span v-else>No disponible</span>
            </div>
            <!-- Ranking Mundial -->
            <div class="info-item" v-if="fichaMuseo.ranking?.posiciones">
              <strong>Ranking Mundial:</strong>
              <span v-if="fichaMuseo.ranking.posiciones.mundial?.posicion">
                {{ fichaMuseo.ranking.posiciones.mundial.posicion }} / {{ fichaMuseo.ranking.posiciones.mundial.total }}
              </span>
              <span v-else>No disponible</span>
            </div>
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
          <div class="colecciones-lista">
            <ol class="lista-colecciones">
              <li v-for="(coleccion, index) in fichaMuseo.colecciones" :key="index" class="coleccion-item">
                {{ coleccion }}
              </li>
            </ol>
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
  </template>
  
  <script setup>
  import { ref, onMounted, computed } from 'vue'
  import axios from 'axios'
  
  const museos = ref([])
  const selectedMuseoId = ref('')
  const fichaMuseo = ref(null)
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
  
  .colecciones-lista {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 25px;
  }
  
  .lista-colecciones {
    margin: 0;
    padding-left: 20px;
    line-height: 1.8;
  }
  
  .coleccion-item {
    color: #495057;
    font-size: 1.1rem;
    margin-bottom: 10px;
    font-weight: 500;
  }
  
  .coleccion-item:hover {
    color: #007bff;
    transition: color 0.3s ease;
  }
  
  /* Estilos para las posiciones en rankings */
  .posiciones-section {
    background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
    border-radius: 15px;
    padding: 25px;
    margin-top: 25px;
    border: 2px solid #f59e0b;
  }

  .posiciones-section h4 {
    margin: 0 0 25px 0;
    color: #92400e;
    font-size: 1.3rem;
    text-align: center;
    font-weight: 700;
  }

  .posiciones-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
  }

  .posicion-item {
    background: white;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
  }

  .posicion-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  }

  .posicion-item.nacional {
    border-left: 4px solid #3b82f6;
  }

  .posicion-item.mundial {
    border-left: 4px solid #10b981;
  }

  .posicion-header {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-bottom: 15px;
  }

  .posicion-icon {
    font-size: 1.5rem;
  }

  .posicion-titulo {
    font-weight: 700;
    color: #374151;
    font-size: 1.1rem;
  }

  .posicion-numeros {
    display: flex;
    align-items: baseline;
    justify-content: center;
    gap: 5px;
    margin-bottom: 10px;
  }

  .posicion-actual {
    font-size: 3rem;
    font-weight: 800;
    color: #1f2937;
    line-height: 1;
  }

  .posicion-separador {
    font-size: 1.5rem;
    color: #6b7280;
    font-weight: 500;
  }

  .posicion-total {
    font-size: 1.8rem;
    font-weight: 600;
    color: #4b5563;
    line-height: 1;
  }

  .posicion-contexto {
    color: #6b7280;
    font-size: 0.9rem;
    margin-bottom: 10px;
    font-weight: 500;
  }

  .posicion-porcentaje {
    display: inline-block;
    background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  /* Estilos para las puntuaciones */
  .puntuaciones-section {
    background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
    border-radius: 15px;
    padding: 25px;
    margin-top: 25px;
    border: 2px solid #cbd5e1;
  }

  .puntuaciones-section.metricas-detalle {
    background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
    border-color: #0ea5e9;
  }
  
  .puntuaciones-section h4 {
    margin: 0 0 20px 0;
    color: #1e293b;
    font-size: 1.2rem;
    text-align: center;
  }
  
  .puntuaciones-grid {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .puntuacion-item {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }
  
  .puntuacion-label {
    font-weight: 600;
    color: #374151;
    font-size: 0.95rem;
  }
  
  .puntuacion-valor {
    font-size: 0.9rem;
    color: #6b7280;
    font-weight: 600;
    text-align: center;
    margin-top: 5px;
  }
  
  .progress-fill.estabilidad {
    background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
    box-shadow: inset 0 2px 4px rgba(255, 255, 255, 0.3);
  }
  
  .progress-fill.popularidad {
    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    box-shadow: inset 0 2px 4px rgba(255, 255, 255, 0.3);
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
  
  .report-footer {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-top: 40px;
  }
  
  .generation-info {
    text-align: center;
  }
  
  .generation-info p {
    margin: 0;
    font-size: 1rem;
    color: #6c757d;
  }
  
  .generation-info p strong {
    font-weight: 600;
    color: #495057;
  }
  
  @media print {
    .museo-selector {
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
    
    .posiciones-grid {
      grid-template-columns: 1fr;
      gap: 15px;
    }
    
    .posicion-actual {
      font-size: 2.5rem;
    }
    
    .posicion-total {
      font-size: 1.5rem;
    }
    
    .metricas-grid {
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