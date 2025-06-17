<template>
  <div class="page-container">
    <header class="page-header">
      <h1>Gestión de Estructura Física</h1>
      <p>Administre los edificios, pisos y áreas de los museos.</p>
    </header>

    <!-- Selector de Museo -->
    <div class="control-section">
      <label for="museo-select">Seleccione un Museo:</label>
      <select id="museo-select" v-model="selectedMuseo" @change="onMuseoChange">
        <option disabled value="">Por favor seleccione un museo</option>
        <option v-for="museo in museos" :key="museo.id" :value="museo.id">
          {{ museo.nombre }}
        </option>
      </select>
    </div>

    <!-- Formulario Principal -->
    <div class="form-container" v-if="selectedMuseo">
      <div class="form-card">
        <h2>Añadir Nuevo Elemento</h2>
        <form @submit.prevent="handleSubmit" class="add-form">
          <div class="form-group">
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" v-model="newElemento.nombre" required />
          </div>
          <div class="form-group">
            <label for="tipo">Tipo</label>
            <select id="tipo" v-model="newElemento.tipo" @change="onTipoChange" required>
              <option value="EDIFICIO">Edificio</option>
              <option value="PISO">Piso</option>
              <option value="AREA">Área</option>
            </select>
          </div>
          <div class="form-group" v-if="newElemento.tipo === 'EDIFICIO'">
            <label for="direccion">Dirección del Edificio</label>
            <input type="text" id="direccion" v-model="newElemento.direccion_edificio" />
          </div>
          <div class="form-group">
            <label for="descripcion">Descripción</label>
            <textarea id="descripcion" v-model="newElemento.descripcion"></textarea>
          </div>
          <div class="form-group" v-if="isPadreRequired">
            <label for="padre">
              {{ padreLabel }}
              <span class="required">*</span>
            </label>
            <select id="padre" v-model="newElemento.id_est_padre" required>
              <option disabled :value="null">-- Seleccione un {{ tipoPermitidoPadre.toLowerCase() }} --</option>
              <option v-for="item in opcionesPadreDisponibles" :key="item.id" :value="item.id">
                <span v-for="i in item.level" :key="i">&nbsp;&nbsp;</span>
                {{ item.nombre }} ({{ item.tipo }})
              </option>
            </select>
            <small class="form-hint">
              Los {{ newElemento.tipo.toLowerCase() }}s deben ubicarse dentro de un {{ tipoPermitidoPadre.toLowerCase() }}.
            </small>
          </div>
          <div v-if="errorSubmit" class="error-message">{{ errorSubmit }}</div>
          <div class="form-actions">
            <button type="submit" :disabled="loadingSubmit" class="btn-primary">
              {{ loadingSubmit ? 'Guardando...' : 'Guardar Elemento' }}
            </button>
            <button type="button" @click="resetForm" class="btn-secondary">
              Limpiar Formulario
            </button>
          </div>
        </form>
      </div>
    </div>
    
    <div v-else class="placeholder">
      <p>Seleccione un museo para agregar elementos a su estructura física.</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';

const API_URL = 'http://localhost:3000/api';

const museos = ref([]);
const selectedMuseo = ref('');
const estructura = ref([]);
const loadingEstructura = ref(false);
const errorEstructura = ref(null);

const newElemento = ref({
  nombre: '',
  tipo: 'EDIFICIO',
  descripcion: '',
  direccion_edificio: '',
  id_est_padre: null,
  id_museo: null
});

const loadingSubmit = ref(false);
const errorSubmit = ref(null);

const fetchMuseos = async () => {
  try {
    const response = await axios.get(`${API_URL}/museos`);
    museos.value = response.data;
  } catch (error) {
    console.error('Error fetching museums:', error);
    errorEstructura.value = 'No se pudieron cargar los museos.';
  }
};

const fetchEstructura = async () => {
  if (!selectedMuseo.value) return;
  
  loadingEstructura.value = true;
  errorEstructura.value = null;
  estructura.value = [];

  try {
    const response = await axios.get(`${API_URL}/est-fisica/museo/${selectedMuseo.value}`);
    estructura.value = response.data;
  } catch (error) {
    console.error('Error fetching estructura:', error);
    errorEstructura.value = 'Error al cargar la estructura del museo.';
  } finally {
    loadingEstructura.value = false;
  }
};

const flattenEstructura = (nodes, level = 0) => {
  let flatList = [];
  for (const node of nodes) {
    flatList.push({ id: node.id, nombre: node.nombre, tipo: node.tipo, level: level });
    if (node.children && node.children.length > 0) {
      flatList = flatList.concat(flattenEstructura(node.children, level + 1));
    }
  }
  return flatList;
};

const estructuraPlana = computed(() => flattenEstructura(estructura.value));

// Reglas de jerarquía para la estructura física
const reglasJerarquia = {
  'EDIFICIO': { 
    requierePadre: false, 
    tipoPermitido: null 
  },
  'PISO': { 
    requierePadre: true, 
    tipoPermitido: 'EDIFICIO' 
  },
  'AREA': { 
    requierePadre: true, 
    tipoPermitido: 'PISO' 
  }
};

// Computed properties para la lógica del padre
const isPadreRequired = computed(() => {
  return reglasJerarquia[newElemento.value.tipo]?.requierePadre || false;
});

const tipoPermitidoPadre = computed(() => {
  return reglasJerarquia[newElemento.value.tipo]?.tipoPermitido || '';
});

const padreLabel = computed(() => {
  return `${tipoPermitidoPadre.value} Padre`;
});

const opcionesPadreDisponibles = computed(() => {
  // Filtrar solo los elementos del tipo permitido como padre
  return estructuraPlana.value.filter(item => 
    item.tipo === tipoPermitidoPadre.value
  );
});

const onTipoChange = () => {
  // Limpiar el padre seleccionado si ya no es válido para el nuevo tipo
  const tipoActual = newElemento.value.tipo;
  const requierePadre = reglasJerarquia[tipoActual]?.requierePadre;
  
  if (!requierePadre) {
    // Para edificios, el padre puede ser null
    newElemento.value.id_est_padre = null;
  } else {
    // Para pisos y áreas, verificar si el padre actual es del tipo correcto
    const tipoPermitido = reglasJerarquia[tipoActual]?.tipoPermitido;
    const padreActual = estructuraPlana.value.find(item => item.id === newElemento.value.id_est_padre);
    
    if (!padreActual || padreActual.tipo !== tipoPermitido) {
      newElemento.value.id_est_padre = null;
    }
  }
};

const handleSubmit = async () => {
  loadingSubmit.value = true;
  errorSubmit.value = null;
  newElemento.value.id_museo = selectedMuseo.value;

  // Validación adicional de reglas de jerarquía
  if (isPadreRequired.value && !newElemento.value.id_est_padre) {
    errorSubmit.value = `Debe seleccionar un ${tipoPermitidoPadre.value.toLowerCase()} como padre para el ${newElemento.value.tipo.toLowerCase()}.`;
    loadingSubmit.value = false;
    return;
  }

  // Si el tipo no es 'EDIFICIO', la dirección debe ser nula.
  if (newElemento.value.tipo !== 'EDIFICIO') {
    newElemento.value.direccion_edificio = null;
  }

  try {
    await axios.post(`${API_URL}/est-fisica`, newElemento.value);
    // Éxito
    resetForm();
    alert('Elemento de estructura física guardado exitosamente!');
    await fetchEstructura(); // Recargar la estructura para futuras operaciones
  } catch (error) {
    console.error('Error submitting new element:', error);
    errorSubmit.value = `Error al guardar: ${error.response?.data?.message || error.message}`;
  } finally {
    loadingSubmit.value = false;
  }
};

const resetForm = () => {
  newElemento.value = {
    nombre: '',
    tipo: 'EDIFICIO',
    descripcion: '',
    direccion_edificio: '',
    id_est_padre: null,
    id_museo: null
  };
  errorSubmit.value = null;
};

const onMuseoChange = () => {
  // Llamar a fetchEstructura cuando se cambie el museo para cargar opciones de padre
  fetchEstructura();
  // También limpiar el formulario
  resetForm();
};

onMounted(fetchMuseos);
</script>

<style scoped>
.page-container {
  padding: 2rem;
  background-color: var(--gray-50);
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 2rem;
  border-bottom: 1px solid var(--gray-200);
  padding-bottom: 1rem;
  text-align: center;
}

.page-header h1 {
  font-size: 2rem;
  font-weight: 700;
  color: var(--gray-800);
}

.page-header p {
  font-size: 1rem;
  color: var(--gray-500);
}

.control-section {
  margin-bottom: 2rem;
  background-color: white;
  padding: 1.5rem;
  border-radius: 12px;
  box-shadow: var(--shadow-md);
  text-align: center;
}

.control-section label {
  font-weight: 600;
  margin-right: 1rem;
  display: inline-block;
}

.control-section select {
  padding: 0.5rem 1rem;
  border-radius: 8px;
  border: 1px solid var(--gray-300);
  min-width: 300px;
}

.placeholder {
  text-align: center;
  margin-top: 4rem;
  color: var(--gray-500);
  padding: 2rem;
  background-color: white;
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
}

.form-container {
  display: flex;
  justify-content: center;
  width: 100%;
}

.form-card {
  background-color: white;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: var(--shadow-md);
  width: 100%;
  max-width: 600px;
}

h2 {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-700);
  margin-bottom: 1.5rem;
  border-bottom: 1px solid var(--gray-200);
  padding-bottom: 0.75rem;
  text-align: center;
}

.error-message {
  padding: 1rem;
  border-radius: 8px;
  text-align: center;
  background-color: #fee2e2;
  color: #b91c1c;
  margin-bottom: 1rem;
}

.add-form .form-group {
  margin-bottom: 1.5rem;
}

.add-form label {
  display: block;
  font-weight: 500;
  margin-bottom: 0.5rem;
  color: var(--gray-600);
}

.add-form input,
.add-form select,
.add-form textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid var(--gray-300);
  border-radius: 8px;
  transition: border-color 0.2s;
  font-size: 1rem;
}

.add-form textarea {
  min-height: 100px;
  resize: vertical;
}

.add-form input:focus,
.add-form select:focus,
.add-form textarea:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
}

.form-actions {
  display: flex;
  gap: 1rem;
  margin-top: 2rem;
}

.btn-primary,
.btn-secondary {
  flex: 1;
  padding: 0.85rem 1.5rem;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  font-size: 1rem;
}

.btn-primary {
  background-color: var(--primary-color);
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background-color: var(--primary-dark);
  transform: translateY(-1px);
}

.btn-primary:disabled {
  background-color: var(--gray-400);
  cursor: not-allowed;
  transform: none;
}

.btn-secondary {
  background-color: var(--gray-200);
  color: var(--gray-700);
  border: 1px solid var(--gray-300);
}

.btn-secondary:hover {
  background-color: var(--gray-300);
  transform: translateY(-1px);
}

.required {
  color: var(--error-color);
  font-weight: bold;
}

.form-hint {
  display: block;
  margin-top: 0.25rem;
  font-size: 0.875rem;
  color: var(--gray-500);
  font-style: italic;
}

/* Responsive design */
@media (max-width: 768px) {
  .page-container {
    padding: 1rem;
  }
  
  .form-card {
    padding: 1.5rem;
  }
  
  .control-section select {
    min-width: 250px;
  }
  
  .form-actions {
    flex-direction: column;
  }
}
</style> 