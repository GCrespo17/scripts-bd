<template>
  <div class="employee-details-panel card">
    <div class="panel-header">
      <button @click="$emit('back-to-list')" class="back-button" title="Volver a la lista">&#8592; Volver a la Lista</button>
      <h3 class="panel-title">Detalles del Empleado</h3>
    </div>
    <div class="panel-body" v-if="empleado">
      <h4>{{ empleado.primer_nombre }} {{ empleado.primer_apellido }}</h4>
      <p><strong>Documento de Identidad:</strong> {{ empleado.doc_identidad }}</p>
      <p v-if="empleado.segundo_nombre"><strong>Segundo Nombre:</strong> {{ empleado.segundo_nombre }}</p>
      <p v-if="empleado.segundo_apellido"><strong>Segundo Apellido:</strong> {{ empleado.segundo_apellido }}</p>
      <p v-if="empleado.fecha_nacimiento"><strong>Fecha de Nacimiento:</strong> {{ formatFecha(empleado.fecha_nacimiento) }}</p>
      <p v-if="empleado.contacto"><strong>Contacto:</strong> {{ empleado.contacto }}</p>
      <p v-if="empleado.cargo"><strong>Cargo Actual:</strong> {{ empleado.cargo }}</p>

      <!-- SECCIÓN DE FORMACIÓN ACADÉMICA -->
      <div v-if="empleado.formaciones && empleado.formaciones.length">
        <h5 class="section-title">Formación Académica</h5>
        <ul class="detail-list">
          <li v-for="(formacion, index) in empleado.formaciones" :key="index">
            <strong>{{ formacion.titulo }}</strong> ({{ formacion.anio }})<br>
            <small>{{ formacion.descripcion }}</small>
          </li>
        </ul>
      </div>

      <!-- SECCIÓN DE IDIOMAS -->
      <div v-if="empleado.idiomas && empleado.idiomas.length">
        <h5 class="section-title">Idiomas</h5>
        <ul class="detail-list">
          <li v-for="(idioma, index) in empleado.idiomas" :key="index">{{ idioma }}</li>
        </ul>
      </div>

      <!-- SECCIÓN DE HISTORIAL LABORAL -->
      <div v-if="empleado.historial && empleado.historial.length">
        <h5 class="section-title">Historial Laboral</h5>
        <ul class="detail-list">
          <li v-for="(hist, index) in empleado.historial" :key="index">
            <strong>Cargo:</strong> {{ hist.cargo }}<br>
            <strong>Museo:</strong> {{ hist.museo }}<br>
            <strong>Unidad Organizativa:</strong> {{ hist.unidad }}<br>
            <strong>Período:</strong> {{ formatFecha(hist.fecha_inicio) }} - {{ hist.fecha_fin || 'Actual' }}
          </li>
        </ul>
      </div>

    </div>
    <div v-else class="panel-body">
        <p>Cargando detalles del empleado...</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EmpleadoDet',
  props: {
    empleado: {
      type: Object,
      default: null
    }
  },
   methods: {
    formatFecha(fechaString) {
      if (!fechaString) return '';
      try {
        const date = new Date(fechaString);
        const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
        return new Intl.DateTimeFormat('es-ES', options).format(date);
      } catch (e) {
        console.error("Error al formatear la fecha:", fechaString, e);
        return fechaString; 
      }
    }
  }
}
</script>

<style scoped>

.employee-details-panel {
  background-color: #f8f9fa;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
  margin-top: 0rem;
  width: 100%;
}

.panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  border-bottom: 1px solid #e9ecef;
  padding-bottom: 0.75rem;
}

.panel-title {
  font-size: 1.6rem;
  color: #2c3e50;
  margin: 0;
  flex-grow: 1;
  text-align: center;
}

.back-button {
  background: none;
  border: 1px solid #007bff;
  color: #007bff;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.2s, color 0.2s;
  margin-right: 1rem;
}

.back-button:hover {
  background-color: #007bff;
  color: white;
}

.panel-body h4 {
  font-size: 1.4rem;
  color: #34495e;
  margin-bottom: 1rem;
}

.panel-body p {
  font-size: 1rem;
  color: #555;
  margin-bottom: 0.5rem;
}

.panel-body strong {
  color: #333;
}

.section-title {
  font-size: 1.2rem;
  color: #2c3e50;
  margin-top: 1.5rem;
  margin-bottom: 0.8rem;
  border-bottom: 1px dashed #ccc;
  padding-bottom: 0.4rem;
}

.detail-list {
  list-style-type: disc; /* O 'none' si prefieres sin viñetas */
  padding-left: 1.5rem;
  margin-bottom: 1rem;
}

.detail-list li {
  margin-bottom: 0.5rem;
  color: #555;
}

.detail-list li strong {
  color: #333;
}

.detail-list li small {
  display: block;
  font-size: 0.85rem;
  color: #777;
  margin-top: 0.2rem;
}
</style>
