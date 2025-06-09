<template>
  <li class="org-node">
    <div class="node-content" :class="`level-${node.nivel}`">
      <div class="node-header">
        <h4 class="node-title">{{ node.nombre }}</h4>
        <div class="node-badges">
          <span class="badge badge-type">{{ node.tipo }}</span>
          <span class="badge badge-level">Nivel {{ node.nivel }}</span>
        </div>
      </div>
      
      <p v-if="node.descripcion" class="node-description">{{ node.descripcion }}</p>
      
      <div v-if="node.empleados && node.empleados.length > 0" class="employees-section">
        <div class="employees-header">
          <span class="employees-icon">👥</span>
          <strong>Empleados ({{ node.empleados.length }})</strong>
        </div>
        <div class="employees-grid">
          <div v-for="empleado in node.empleados" :key="empleado.id_empleado" class="employee-card">
            <div class="employee-name">{{ empleado.nombre }}</div>
            <div class="employee-role">{{ empleado.cargo }}</div>
          </div>
        </div>
      </div>
    </div>

    <ul v-if="node.children && node.children.length > 0" class="children-list">
      <OrganigramaNode v-for="child in node.children" :key="child.id" :node="child" />
    </ul>
  </li>
</template>

<script>
export default {
  name: 'OrganigramaNode',
  props: {
    node: {
      type: Object,
      required: true
    }
  }
};
</script>

<style scoped>
.org-node {
  position: relative;
  margin: 0 0 1.5rem 0;
  list-style: none;
}

.node-content {
  background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
  border: 2px solid #e9ecef;
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 1rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 1px 3px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.node-content:hover {
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
  transform: translateY(-2px);
}

/* Diferentes colores por nivel */
.level-1 {
  border-left: 6px solid #2563eb;
  background: linear-gradient(135deg, #dbeafe 0%, #ffffff 100%);
}

.level-2 {
  border-left: 6px solid #059669;
  background: linear-gradient(135deg, #d1fae5 0%, #ffffff 100%);
}

.level-3 {
  border-left: 6px solid #dc2626;
  background: linear-gradient(135deg, #fecaca 0%, #ffffff 100%);
}

.level-4 {
  border-left: 6px solid #7c3aed;
  background: linear-gradient(135deg, #e9d5ff 0%, #ffffff 100%);
}

.node-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1rem;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.node-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
  flex: 1;
  line-height: 1.3;
}

.node-badges {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.badge {
  padding: 0.25rem 0.75rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.badge-type {
  background-color: #f3f4f6;
  color: #374151;
  border: 1px solid #d1d5db;
}

.badge-level {
  background-color: #3b82f6;
  color: white;
}

.node-description {
  color: #6b7280;
  font-style: italic;
  margin: 0 0 1rem 0;
  font-size: 0.9rem;
  line-height: 1.5;
}

.employees-section {
  background-color: #f8fafc;
  border-radius: 8px;
  padding: 1rem;
  border: 1px solid #e2e8f0;
}

.employees-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  color: #374151;
  font-size: 0.9rem;
}

.employees-icon {
  font-size: 1.1rem;
}

.employees-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 0.75rem;
}

.employee-card {
  background-color: white;
  padding: 0.75rem;
  border-radius: 6px;
  border: 1px solid #e5e7eb;
  transition: all 0.2s ease;
}

.employee-card:hover {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border-color: #3b82f6;
}

.employee-name {
  font-weight: 600;
  color: #1f2937;
  font-size: 0.9rem;
  margin-bottom: 0.25rem;
}

.employee-role {
  font-size: 0.8rem;
  color: #6b7280;
  font-style: italic;
}

.children-list {
  list-style: none;
  padding: 0;
  margin: 0;
  position: relative;
  padding-left: 2rem;
}

.children-list::before {
  content: '';
  position: absolute;
  left: 0;
  top: -1rem;
  bottom: 1rem;
  width: 2px;
  background: linear-gradient(to bottom, #e5e7eb 0%, transparent 100%);
}

.children-list > .org-node::before {
  content: '';
  position: absolute;
  left: -2rem;
  top: 1rem;
  width: 1.5rem;
  height: 2px;
  background-color: #e5e7eb;
}

.children-list > .org-node:last-child::after {
  content: '';
  position: absolute;
  left: -2rem;
  top: 1rem;
  bottom: -1rem;
  width: 2px;
  background-color: white;
}

/* Responsive design */
@media (max-width: 768px) {
  .node-header {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .employees-grid {
    grid-template-columns: 1fr;
  }
  
  .children-list {
    padding-left: 1rem;
  }
}
</style> 