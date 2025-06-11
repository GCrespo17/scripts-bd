<template>
  <div class="employee-professional-card" @click="$emit('employee-selected', empleado)">
    <div class="card-header">
      <h4 class="employee-name">{{ empleado.nombre }}</h4>
      <span class="badge badge-role">{{ empleado.cargo}}</span>
    </div>
    <div class="card-body">
      <p class="employee-detail"><strong>Documento de Identidad:</strong> {{ empleado.doc_identidad }}</p>
      </div>
  </div>
</template>

<script>
export default {
  name: 'EmpleadosNode',
  props: {
    empleado: {
      type: Object,
      required: true,
      // Se puede añadir un validador para asegurar que tenga las propiedades básicas
              validator: function(obj) {
          return obj.hasOwnProperty('nombre') &&
                 obj.hasOwnProperty('doc_identidad') &&
                 obj.hasOwnProperty('cargo');
        }
    }
  }
};
</script>

<style scoped>
/* Las clases de estilo son similares a las de tu OrganigramaNode y EmpleadosReporte */

.employee-professional-card {
  /* Inspirado en .node-content o .employee-card de tu OrganigramaNode */
  background-color: white;
  border: 1px solid #e5e7eb;
  border-radius: 8px; /* Bordes más redondeados para la tarjeta */
  padding: 1rem;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08); /* Una sombra más notoria para la tarjeta individual */
  transition: all 0.2s ease-in-out;
  display: flex;
  flex-direction: column;
  justify-content: space-between; /* Distribuye el contenido verticalmente */
  height: auto; /* Ajusta la altura al contenido */
}

.employee-professional-card:hover {
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15); /* Sombra más grande al pasar el ratón */
  transform: translateY(-3px); /* Pequeño levantamiento */
  border-color: #3b82f6; /* Borde azul al pasar el ratón */
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.8rem;
  flex-wrap: wrap; /* Permite que el contenido se ajuste */
  gap: 0.5rem;
}

.employee-name {
  font-size: 1.1rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
  line-height: 1.2;
}

.badge {
  padding: 0.25rem 0.6rem;
  border-radius: 9999px; /* Píldora redondeada */
  font-size: 0.7rem; /* Texto más pequeño para el badge */
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  white-space: nowrap; /* Evita que el texto del badge se rompa */
}

.badge-role {
  background-color: #e0f2fe; /* Azul claro */
  color: #0d6efd; /* Azul más oscuro */
  border: 1px solid #a7d9f9;
}

.card-body {
  flex-grow: 1; /* Permite que el cuerpo crezca */
}

.employee-detail {
  font-size: 0.85rem;
  color: #4a5568;
  margin-bottom: 0.4rem;
  line-height: 1.4;
}

.employee-detail strong {
  color: #1f2937;
}

/* Puedes añadir más estilos si los datos del empleado son más complejos */
</style>