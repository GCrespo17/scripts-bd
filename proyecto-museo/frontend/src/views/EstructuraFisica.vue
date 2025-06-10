<template>
  <div class="page-container">
    <header class="page-header">
      <h1>Gestión de Estructura Física</h1>
      <p>Administre los edificios, pisos y áreas de los museos.</p>
    </header>

    <!-- Selector de Museo -->
    <div class="control-section">
      <label for="museo-select">Seleccione un Museo:</label>
      <select id="museo-select" v-model="selectedMuseo" @change="fetchEstructura">
        <option disabled value="">Por favor seleccione un museo</option>
        <option v-for="museo in museos" :key="museo.id" :value="museo.id">
          {{ museo.nombre }}
        </option>
      </select>
    </div>

    <!-- Contenido Principal -->
    <div class="content-grid" v-if="selectedMuseo">
      <!-- Columna de la Estructura Actual -->
      <div class="structure-column">
        <h2>Estructura Actual</h2>
        <div v-if="loadingEstructura" class="loading-spinner">Cargando...</div>
        <div v-if="errorEstructura" class="error-message">{{ errorEstructura }}</div>
        <div v-if="!loadingEstructura && estructura.length === 0" class="no-data">
          No hay estructura física registrada para este museo.
        </div>
        <ul class="structure-tree" v-if="estructura.length > 0">
          <EstructuraNode 
            v-for="node in estructura" 
            :key="node.id" 
            :node="node" 
          />
        </ul>
      </div>

      <!-- Columna del Formulario -->
      <div class="form-column">
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
          <button type="submit" :disabled="loadingSubmit">
            {{ loadingSubmit ? 'Guardando...' : 'Guardar Elemento' }}
          </button>
        </form>
      </div>
    </div>
     <div v-else class="placeholder">
      <p>Seleccione un museo para ver y gestionar su estructura física.</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import EstructuraNode from '../components/EstructuraNode.vue';
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
    await fetchEstructura(); // Recargar la estructura
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
};

onMounted(fetchMuseos);
</script>

<style scoped>
.page-container {
  padding: 2rem;
  background-color: var(--gray-50);
}

.page-header {
  margin-bottom: 2rem;
  border-bottom: 1px solid var(--gray-200);
  padding-bottom: 1rem;
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
}

.control-section label {
  font-weight: 600;
  margin-right: 1rem;
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

.content-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.structure-column, .form-column {
  background-color: white;
  padding: 1.5rem;
  border-radius: 12px;
  box-shadow: var(--shadow-md);
}

h2 {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--gray-700);
  margin-bottom: 1.5rem;
  border-bottom: 1px solid var(--gray-200);
  padding-bottom: 0.75rem;
}

.loading-spinner, .error-message, .no-data {
  padding: 1rem;
  border-radius: 8px;
  text-align: center;
}

.error-message {
  background-color: #fee2e2;
  color: #b91c1c;
}

.no-data {
  background-color: var(--gray-100);
  color: var(--gray-600);
}

.structure-tree {
  list-style-type: none;
  padding-left: 0;
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
}

.add-form input:focus,
.add-form select:focus,
.add-form textarea:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
}

.add-form button {
  width: 100%;
  padding: 0.85rem;
  background-color: var(--primary-color);
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s;
}

.add-form button:hover {
  background-color: var(--primary-dark);
}

.add-form button:disabled {
  background-color: var(--gray-400);
  cursor: not-allowed;
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
</style> 