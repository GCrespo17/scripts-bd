<template>
  <li class="node-item">
    <div class="node-content">
      <span class="node-icon">{{ icon }}</span>
      <div class="node-details">
        <span class="node-name">{{ node.nombre }}</span>
        <span class="node-type">{{ node.tipo }}</span>
        <p v-if="node.descripcion" class="node-description">{{ node.descripcion }}</p>
        <p v-if="node.direccion" class="node-address">📍 {{ node.direccion }}</p>
      </div>
    </div>
    <ul v-if="node.children && node.children.length" class="child-nodes">
      <EstructuraNode v-for="child in node.children" :key="child.id" :node="child" />
    </ul>
  </li>
</template>

<script setup>
import { computed } from 'vue';

// Define 'defineProps' which is a compiler macro and does not need to be imported.
const props = defineProps({
  node: {
    type: Object,
    required: true
  }
});

// Import itself for recursive use
const EstructuraNode = 'EstructuraNode';

const icon = computed(() => {
  switch (props.node.tipo) {
    case 'EDIFICIO': return '🏢';
    case 'PISO': return '🧱';
    case 'AREA': return '🚪';
    default: return '🏛️';
  }
});
</script>

<style scoped>
.node-item {
  list-style-type: none;
  margin-top: 1rem;
}

.node-content {
  display: flex;
  align-items: flex-start;
  padding: 0.75rem;
  background-color: var(--gray-50);
  border-radius: 8px;
  border-left: 4px solid var(--primary-color);
}

.node-icon {
  font-size: 1.5rem;
  margin-right: 1rem;
  color: var(--primary-dark);
}

.node-details {
  display: flex;
  flex-direction: column;
}

.node-name {
  font-weight: 600;
  color: var(--gray-800);
}

.node-type {
  font-size: 0.8rem;
  color: var(--gray-500);
  background-color: var(--gray-200);
  padding: 0.1rem 0.4rem;
  border-radius: 6px;
  align-self: flex-start;
  margin-top: 0.25rem;
}

.node-description, .node-address {
    font-size: 0.9rem;
    color: var(--gray-600);
    margin-top: 0.5rem;
}

.child-nodes {
  list-style-type: none;
  padding-left: 2.5rem;
  margin-top: 0.5rem;
  border-left: 2px dashed var(--gray-300);
}
</style> 