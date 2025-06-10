<template>
  <div class="report-node" :class="`level-${level}`">
    <div class="node-header">
      <div class="node-main-info">
        <span class="node-icon">{{ getIcon(node.tipo) }}</span>
        <div class="node-details">
          <h4 class="node-name">{{ node.nombre }}</h4>
          <span class="node-type-badge">{{ node.tipo }}</span>
        </div>
      </div>
      <div class="node-metrics" v-if="node.metricas">
        <div class="metric" v-if="node.metricas.area_m2">
          <span class="metric-value">{{ node.metricas.area_m2 }}</span>
          <span class="metric-label">m²</span>
        </div>
        <div class="metric" v-if="node.metricas.capacidad">
          <span class="metric-value">{{ node.metricas.capacidad }}</span>
          <span class="metric-label">cap.</span>
        </div>
      </div>
    </div>

    <div class="node-content" v-if="node.descripcion || node.direccion_edificio || hasCollections">
      <p v-if="node.descripcion" class="node-description">
        <strong>Descripción:</strong> {{ node.descripcion }}
      </p>
      
      <p v-if="node.direccion_edificio" class="node-address">
        <strong>📍 Dirección:</strong> {{ node.direccion_edificio }}
      </p>

      <!-- Colecciones ubicadas en esta área -->
      <div v-if="hasCollections" class="collections-section">
        <h5>🎨 Colecciones Ubicadas</h5>
        <div class="collections-grid">
          <div 
            v-for="collection in node.colecciones" 
            :key="collection.id" 
            class="collection-item"
          >
            <div class="collection-header">
              <strong>{{ collection.nombre }}</strong>
              <span class="collection-count">({{ collection.total_obras }} obras)</span>
            </div>
            <div class="collection-details">
              <span class="collection-type">{{ collection.tipo_coleccion }}</span>
              <span v-if="collection.periodo" class="collection-period">• {{ collection.periodo }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Exposiciones actuales en esta área -->
      <div v-if="hasExpositions" class="expositions-section">
        <h5>🎭 Exposiciones Activas</h5>
        <div class="expositions-list">
          <div 
            v-for="expo in node.exposiciones" 
            :key="expo.id" 
            class="exposition-item"
          >
            <div class="exposition-header">
              <strong>{{ expo.nombre }}</strong>
              <span class="exposition-dates">
                {{ formatearFecha(expo.fecha_inicio) }} - {{ formatearFecha(expo.fecha_fin) }}
              </span>
            </div>
            <div class="exposition-details">
              <span v-if="expo.costo_persona" class="exposition-cost">
                {{ formatearMoneda(expo.costo_persona) }}
              </span>
              <span v-if="expo.visitantes_estimados" class="exposition-visitors">
                {{ expo.visitantes_estimados }} visitantes estimados
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Nodos hijos -->
    <div v-if="node.children && node.children.length > 0" class="child-nodes">
      <ReporteEstructuraNode 
        v-for="child in node.children" 
        :key="child.id" 
        :node="child"
        :level="level + 1" 
      />
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

// Props
const props = defineProps({
  node: {
    type: Object,
    required: true
  },
  level: {
    type: Number,
    default: 0
  }
})

// Computadas
const hasCollections = computed(() => {
  return props.node.colecciones && props.node.colecciones.length > 0
})

const hasExpositions = computed(() => {
  return props.node.exposiciones && props.node.exposiciones.length > 0
})

// Métodos
const getIcon = (tipo) => {
  const iconMap = {
    'EDIFICIO': '🏢',
    'PISO': '🏠',
    'AREA': '📦',
    'SALA': '🖼️',
    'DEPOSITO': '📚',
    'OFICINA': '🏢',
    'TALLER': '🔨',
    'AUDITORIO': '🎭',
    'CAFETERIA': '☕',
    'TIENDA': '🛍️'
  }
  return iconMap[tipo] || '📦'
}

const formatearFecha = (fecha) => {
  if (!fecha) return 'N/A'
  return new Date(fecha).toLocaleDateString('es-ES', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  })
}

const formatearMoneda = (cantidad) => {
  if (!cantidad) return 'Gratuito'
  return new Intl.NumberFormat('es-ES', {
    style: 'currency',
    currency: 'EUR'
  }).format(cantidad)
}
</script>

<style scoped>
.report-node {
  margin-bottom: 1.5rem;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  border: 1px solid var(--gray-200);
  background: white;
}

.report-node.level-0 {
  border-left: 4px solid var(--primary-color);
}

.report-node.level-1 {
  margin-left: 1rem;
  border-left: 3px solid var(--secondary-color);
}

.report-node.level-2 {
  margin-left: 2rem;
  border-left: 2px solid var(--accent-color);
}

.report-node.level-3 {
  margin-left: 3rem;
  border-left: 1px solid var(--gray-400);
}

.node-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.25rem;
  background: var(--gray-50);
  border-bottom: 1px solid var(--gray-200);
}

.node-main-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.node-icon {
  font-size: 1.5rem;
  opacity: 0.8;
}

.node-details {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.node-name {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--gray-800);
  margin: 0;
}

.node-type-badge {
  font-size: 0.75rem;
  font-weight: 500;
  color: var(--primary-color);
  background: var(--primary-color-light);
  padding: 0.125rem 0.5rem;
  border-radius: 12px;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  width: fit-content;
}

.node-metrics {
  display: flex;
  gap: 1rem;
}

.metric {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.metric-value {
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--primary-color);
  line-height: 1;
}

.metric-label {
  font-size: 0.75rem;
  color: var(--gray-600);
  font-weight: 500;
}

.node-content {
  padding: 1.25rem;
}

.node-description {
  margin: 0 0 1rem 0;
  color: var(--gray-700);
  line-height: 1.5;
}

.node-address {
  margin: 0 0 1rem 0;
  color: var(--gray-700);
  font-weight: 500;
}

/* Secciones de colecciones */
.collections-section,
.expositions-section {
  margin-top: 1.5rem;
  padding-top: 1rem;
  border-top: 1px solid var(--gray-200);
}

.collections-section h5,
.expositions-section h5 {
  margin: 0 0 1rem 0;
  font-size: 1rem;
  font-weight: 600;
  color: var(--gray-800);
}

.collections-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 0.75rem;
}

.collection-item {
  padding: 0.75rem;
  background: var(--gray-50);
  border-radius: 6px;
  border: 1px solid var(--gray-200);
}

.collection-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.collection-header strong {
  color: var(--primary-color);
  font-size: 0.9rem;
}

.collection-count {
  font-size: 0.8rem;
  color: var(--gray-600);
  font-weight: 500;
}

.collection-details {
  font-size: 0.8rem;
  color: var(--gray-600);
}

.collection-type {
  font-weight: 500;
}

.collection-period {
  font-style: italic;
}

/* Secciones de exposiciones */
.expositions-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.exposition-item {
  padding: 0.75rem;
  background: var(--accent-color-light);
  border-radius: 6px;
  border: 1px solid var(--accent-color);
}

.exposition-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.exposition-header strong {
  color: var(--accent-color-dark);
  font-size: 0.9rem;
}

.exposition-dates {
  font-size: 0.8rem;
  color: var(--gray-600);
  font-weight: 500;
}

.exposition-details {
  font-size: 0.8rem;
  display: flex;
  gap: 1rem;
}

.exposition-cost {
  color: var(--success-color);
  font-weight: 600;
}

.exposition-visitors {
  color: var(--gray-600);
}

/* Nodos hijos */
.child-nodes {
  border-top: 1px solid var(--gray-200);
  background: var(--gray-25);
  padding: 1rem;
}

.child-nodes .report-node:last-child {
  margin-bottom: 0;
}

/* Responsive */
@media (max-width: 768px) {
  .node-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.75rem;
  }
  
  .collections-grid {
    grid-template-columns: 1fr;
  }
  
  .exposition-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.25rem;
  }
  
  .report-node.level-1,
  .report-node.level-2,
  .report-node.level-3 {
    margin-left: 0.5rem;
  }
}

/* Estilos para impresión */
@media print {
  .report-node {
    box-shadow: none;
    border: 1px solid #ddd;
    page-break-inside: avoid;
    break-inside: avoid;
  }
  
  .child-nodes {
    break-inside: avoid;
  }
}
</style> 