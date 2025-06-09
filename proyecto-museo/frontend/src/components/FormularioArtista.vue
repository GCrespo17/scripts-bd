<script setup>
import { ref, onMounted } from 'vue';

// Campos del formulario
const primer_nombre = ref('');
const segundo_nombre = ref('');
const primer_apellido = ref('');
const segundo_apellido = ref('');
const fecha_nacimiento = ref('');
const fecha_difuncion = ref('');
const apodo = ref('');
const resumen_caracteristicas = ref('');
const id_lugar = ref('');

// Datos para selectores
const lugares = ref([]);
const paises = ref([]);
const ciudades = ref([]);

// Estados del formulario
const loading = ref(false);
const error = ref('');

// Cargar lugares al montar el componente
onMounted(async () => {
  await cargarLugares();
});

async function cargarLugares() {
  try {
    const response = await fetch('http://localhost:3000/api/lugares');
    if (response.ok) {
      lugares.value = await response.json();
      
      // Separar países y ciudades
      paises.value = lugares.value.filter(lugar => lugar.tipo === 'PAIS');
      ciudades.value = lugares.value.filter(lugar => lugar.tipo === 'CIUDAD');
    }
  } catch (error) {
    console.error('Error al cargar lugares:', error);
  }
}

// Validar fechas
function validarFechas() {
  if (fecha_nacimiento.value && fecha_difuncion.value) {
    const nac = new Date(fecha_nacimiento.value);
    const dif = new Date(fecha_difuncion.value);
    
    if (dif <= nac) {
      error.value = 'La fecha de defunción debe ser posterior a la fecha de nacimiento';
      return false;
    }
  }
  error.value = '';
  return true;
}

async function registrarArtista() {
  if (!validarFechas()) {
    return;
  }

  if (!resumen_caracteristicas.value.trim()) {
    error.value = 'El resumen de características es obligatorio';
    return;
  }

  loading.value = true;
  error.value = '';

  try {
    const response = await fetch('http://localhost:3000/api/artistas', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        primer_nombre: primer_nombre.value.trim() || null,
        segundo_nombre: segundo_nombre.value.trim() || null,
        primer_apellido: primer_apellido.value.trim() || null,
        segundo_apellido: segundo_apellido.value.trim() || null,
        fecha_nacimiento: fecha_nacimiento.value || null,
        fecha_difuncion: fecha_difuncion.value || null,
        apodo: apodo.value.trim() || null,
        resumen_caracteristicas: resumen_caracteristicas.value.trim(),
        id_lugar: id_lugar.value || null
      }),
    });

    if (response.ok) {
      alert('Artista registrado exitosamente!');
      limpiarFormulario();
    } else {
      const data = await response.json();
      error.value = data.message || 'Error al registrar el artista';
    }
  } catch (err) {
    console.error('Error de conexión:', err);
    error.value = 'Error de conexión con el servidor';
  } finally {
    loading.value = false;
  }
}

function limpiarFormulario() {
  primer_nombre.value = '';
  segundo_nombre.value = '';
  primer_apellido.value = '';
  segundo_apellido.value = '';
  fecha_nacimiento.value = '';
  fecha_difuncion.value = '';
  apodo.value = '';
  resumen_caracteristicas.value = '';
  id_lugar.value = '';
  error.value = '';
}
</script>

<template>
  <form @submit.prevent="registrarArtista" class="formulario-artista">
    <h3>Registrar Nuevo Artista</h3>
    
    <!-- Mensaje de error -->
    <div v-if="error" class="error-message">
      {{ error }}
    </div>
    
    <!-- Nombres -->
    <div class="form-group">
      <label for="primer_nombre">Primer Nombre:</label>
      <input 
        id="primer_nombre" 
        v-model="primer_nombre" 
        type="text" 
        placeholder="Ej: Leonardo"
      />
    </div>
    
    <div class="form-group">
      <label for="segundo_nombre">Segundo Nombre:</label>
      <input 
        id="segundo_nombre" 
        v-model="segundo_nombre" 
        type="text" 
        placeholder="Ej: da"
      />
    </div>
    
    <!-- Apellidos -->
    <div class="form-group">
      <label for="primer_apellido">Primer Apellido:</label>
      <input 
        id="primer_apellido" 
        v-model="primer_apellido" 
        type="text" 
        placeholder="Ej: Vinci"
      />
    </div>
    
    <div class="form-group">
      <label for="segundo_apellido">Segundo Apellido:</label>
      <input 
        id="segundo_apellido" 
        v-model="segundo_apellido" 
        type="text" 
      />
    </div>
    
    <!-- Apodo -->
    <div class="form-group">
      <label for="apodo">Apodo / Nombre Artístico:</label>
      <input 
        id="apodo" 
        v-model="apodo" 
        type="text" 
        placeholder="Ej: El Maestro del Renacimiento"
      />
    </div>
    
    <!-- Fechas -->
    <div class="form-row">
      <div class="form-group">
        <label for="fecha_nacimiento">Fecha de Nacimiento:</label>
        <input 
          id="fecha_nacimiento" 
          v-model="fecha_nacimiento" 
          type="date"
          @change="validarFechas"
        />
      </div>
      
      <div class="form-group">
        <label for="fecha_difuncion">Fecha de Defunción:</label>
        <input 
          id="fecha_difuncion" 
          v-model="fecha_difuncion" 
          type="date"
          @change="validarFechas"
        />
      </div>
    </div>
    
    <!-- Lugar de origen -->
    <div class="form-group">
      <label for="id_lugar">Lugar de Origen:</label>
      <select v-model="id_lugar" id="id_lugar">
        <option value="">Seleccione un lugar</option>
        <optgroup label="Países">
          <option 
            v-for="pais in paises" 
            :key="pais.id" 
            :value="pais.id"
          >
            {{ pais.nombre }} ({{ pais.continente }})
          </option>
        </optgroup>
        <optgroup label="Ciudades">
          <option 
            v-for="ciudad in ciudades" 
            :key="ciudad.id" 
            :value="ciudad.id"
          >
            {{ ciudad.nombre }}
          </option>
        </optgroup>
      </select>
    </div>
    
    <!-- Resumen de características (obligatorio) -->
    <div class="form-group">
      <label for="resumen_caracteristicas">
        Resumen de Características *
      </label>
      <textarea 
        id="resumen_caracteristicas" 
        v-model="resumen_caracteristicas" 
        required
        rows="4"
        placeholder="Describa las características principales del artista, su estilo, época, movimiento artístico, etc."
      />
    </div>
    
    <!-- Botones -->
    <div class="form-actions">
      <button 
        type="button" 
        @click="limpiarFormulario"
        class="btn-secondary"
        :disabled="loading"
      >
        Limpiar
      </button>
      <button 
        type="submit" 
        class="btn-primary"
        :disabled="loading"
      >
        {{ loading ? 'Guardando...' : 'Guardar Artista' }}
      </button>
    </div>
  </form>
</template>

<style scoped>
.formulario-artista {
  max-width: 700px;
  margin: 0 auto;
  padding: 2rem;
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.formulario-artista h3 {
  margin: 0 0 1.5rem 0;
  color: #2c3e50;
  text-align: center;
}

.error-message {
  background-color: #fee;
  color: #c53030;
  padding: 0.75rem;
  border-radius: 4px;
  margin-bottom: 1rem;
  border: 1px solid #fed7d7;
}

.form-group {
  margin-bottom: 1rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 500;
  color: #374151;
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  font-size: 0.875rem;
  transition: border-color 0.2s, box-shadow 0.2s;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.form-group textarea {
  resize: vertical;
  min-height: 100px;
}

.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
}

.btn-primary,
.btn-secondary {
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 4px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-primary {
  background-color: #3b82f6;
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background-color: #2563eb;
}

.btn-secondary {
  background-color: #6b7280;
  color: white;
}

.btn-secondary:hover:not(:disabled) {
  background-color: #4b5563;
}

.btn-primary:disabled,
.btn-secondary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

@media (max-width: 640px) {
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }
}
</style> 