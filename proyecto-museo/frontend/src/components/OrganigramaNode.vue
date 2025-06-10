<template>
  <li class="org-node">
    <div class="node-content" :class="`level-${node.nivel}`">
      <div class="node-header">
        <h4 class="node-title">{{ node.nombre }}</h4>
        <div class="node-badges">
          <span class="badge badge-type">{{ node.tipo }}</span>
          <span class="badge badge-level">Nivel {{ node.nivel }}</span>
          <span v-if="node.total_empleados > 0" class="badge badge-staff">{{ node.total_empleados }} empleado{{ node.total_empleados > 1 ? 's' : '' }}</span>
        </div>
      </div>
      
      <p v-if="node.descripcion" class="node-description">{{ node.descripcion }}</p>
      
      <!-- Sección de Jefes/Directores -->
      <div v-if="node.jefes && node.jefes.length > 0" class="leadership-section">
        <div class="section-header leadership-header">
          <span class="section-icon">👑</span>
          <strong>Dirección ({{ node.jefes.length }})</strong>
        </div>
        <ul class="employee-list leadership-list">
          <li v-for="jefe in node.jefes" :key="`jefe-${jefe.id_empleado}`" class="employee-item leadership-item">
            <div class="employee-info">
              <span class="employee-name">{{ jefe.nombre_completo }}</span>
              <span class="employee-role leadership-role">{{ jefe.cargo }}</span>
              <span class="employee-tenure">{{ formatFechaInicio(jefe.fecha_inicio) }}</span>
            </div>
            <div class="employee-badge">
              <span class="role-icon">🏛️</span>
            </div>
          </li>
        </ul>
      </div>

      <!-- Sección de Personal -->
      <div v-if="node.personal && node.personal.length > 0" class="employees-section">
        <div class="section-header employees-header">
          <span class="section-icon">👥</span>
          <strong>Personal ({{ node.personal.length }})</strong>
        </div>
        <ul class="employee-list staff-list">
          <li v-for="empleado in node.personal" :key="`emp-${empleado.id_empleado}`" class="employee-item staff-item">
            <div class="employee-info">
              <span class="employee-name">{{ empleado.nombre_completo }}</span>
              <span class="employee-role">{{ empleado.cargo }}</span>
              <span class="employee-tenure">{{ formatFechaInicio(empleado.fecha_inicio) }}</span>
            </div>
            <div class="employee-badge">
              <span class="role-icon">🧑‍💼</span>
            </div>
          </li>
        </ul>
      </div>

      <!-- Mensaje cuando no hay empleados -->
      <div v-if="node.total_empleados === 0" class="no-employees">
        <span class="no-employees-icon">📋</span>
        <em>Sin personal asignado actualmente</em>
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
  },
  methods: {
    formatFechaInicio(fecha) {
      if (!fecha) return '';
      const fechaObj = new Date(fecha);
      const hoy = new Date();
      const meses = (hoy.getFullYear() - fechaObj.getFullYear()) * 12 + (hoy.getMonth() - fechaObj.getMonth());
      
      if (meses < 12) {
        return `${meses} mes${meses !== 1 ? 'es' : ''} en el cargo`;
      } else {
        const años = Math.floor(meses / 12);
        return `${años} año${años !== 1 ? 's' : ''} en el cargo`;
      }
    }
  }
};
</script>

<style scoped>
.org-node {
  position: relative;
  margin: 0 0 1.5rem 0;
  list-style: none;
  width: 100%;
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
  width: 100%;
  box-sizing: border-box;
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
  min-width: 200px;
}

.node-badges {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  align-items: center;
}

.badge {
  padding: 0.25rem 0.75rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  white-space: nowrap;
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

.badge-staff {
  background-color: #10b981;
  color: white;
}

.node-description {
  color: #6b7280;
  font-style: italic;
  margin: 0 0 1rem 0;
  font-size: 0.9rem;
  line-height: 1.5;
}

/* Secciones de empleados */
.leadership-section {
  background: linear-gradient(135deg, #fef3e2 0%, #ffffff 100%);
  border-radius: 8px;
  padding: 1rem;
  border: 1px solid #f59e0b;
  margin-bottom: 1rem;
}

.employees-section {
  background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
  border-radius: 8px;
  padding: 1rem;
  border: 1px solid #e2e8f0;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  font-size: 0.9rem;
  font-weight: 600;
}

.leadership-header {
  color: #d97706;
}

.employees-header {
  color: #374151;
}

.section-icon {
  font-size: 1.1rem;
}

/* Listas de empleados */
.employee-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.employee-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.5rem 0.75rem;
  border-radius: 6px;
  transition: all 0.2s ease;
  border: 1px solid transparent;
}

.leadership-item {
  background: linear-gradient(135deg, #fffbeb 0%, #ffffff 80%);
  border-color: #fbbf24;
}

.leadership-item:hover {
  background: linear-gradient(135deg, #fef3c7 0%, #fffbeb 100%);
  border-color: #f59e0b;
  transform: translateX(3px);
  box-shadow: 0 2px 8px rgba(245, 158, 11, 0.15);
}

.staff-item {
  background: linear-gradient(135deg, #f1f5f9 0%, #ffffff 80%);
  border-color: #cbd5e1;
}

.staff-item:hover {
  background: linear-gradient(135deg, #e2e8f0 0%, #f1f5f9 100%);
  border-color: #94a3b8;
  transform: translateX(3px);
  box-shadow: 0 2px 8px rgba(148, 163, 184, 0.15);
}

.employee-info {
  display: flex;
  flex-direction: column;
  gap: 0.125rem;
  flex: 1;
}

.employee-name {
  font-weight: 600;
  color: #1f2937;
  font-size: 0.9rem;
  line-height: 1.2;
}

.employee-role {
  font-size: 0.8rem;
  color: #6b7280;
  font-style: italic;
}

.leadership-role {
  color: #d97706;
  font-weight: 500;
}

.employee-tenure {
  font-size: 0.75rem;
  color: #9ca3af;
}

.employee-badge {
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 32px;
  height: 32px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.role-icon {
  font-size: 1rem;
}

/* Sin empleados */
.no-employees {
  background-color: #f9fafb;
  border: 1px dashed #d1d5db;
  border-radius: 8px;
  padding: 1.5rem;
  text-align: center;
  color: #6b7280;
}

.no-employees-icon {
  font-size: 1.5rem;
  display: block;
  margin-bottom: 0.5rem;
}

.children-list {
  list-style: none;
  padding: 0;
  margin: 0;
  position: relative;
  padding-left: 2rem;
  width: 100%;
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
  
  .node-title {
    min-width: unset;
    margin-bottom: 0.5rem;
  }
  
  .employee-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
    padding: 0.75rem;
  }
  
  .employee-info {
    gap: 0.25rem;
  }
  
  .employee-badge {
    align-self: flex-end;
  }
  
  .children-list {
    padding-left: 1rem;
  }
}

@media (max-width: 480px) {
  .node-content {
    padding: 1rem;
  }
  
  .leadership-section,
  .employees-section {
    padding: 0.75rem;
  }
}
</style> 