<script setup>
import { ref, onMounted } from 'vue';

// Campos del formulario de artista
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

// Estados del modal de nuevo lugar
const mostrarModalLugar = ref(false);
const loadingLugar = ref(false);
const errorLugar = ref('');

// Campos del formulario de nuevo lugar
const nuevoLugar = ref({
  nombre: '',
  tipo: 'PAIS',
  continente: '',
  id_lugar_padre: ''
});

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

// Funciones del modal de lugar
function abrirModalLugar() {
  mostrarModalLugar.value = true;
  errorLugar.value = '';
  nuevoLugar.value = {
    nombre: '',
    tipo: 'PAIS',
    continente: '',
    id_lugar_padre: ''
  };
}

function cerrarModalLugar() {
  mostrarModalLugar.value = false;
  errorLugar.value = '';
}

async function crearLugar() {
  if (!nuevoLugar.value.nombre.trim()) {
    errorLugar.value = 'El nombre del lugar es obligatorio';
    return;
  }

  if (nuevoLugar.value.tipo === 'PAIS' && !nuevoLugar.value.continente.trim()) {
    errorLugar.value = 'El continente es obligatorio para países';
    return;
  }

  if (nuevoLugar.value.tipo === 'CIUDAD' && !nuevoLugar.value.id_lugar_padre) {
    errorLugar.value = 'El país es obligatorio para ciudades';
    return;
  }

  loadingLugar.value = true;
  errorLugar.value = '';

  try {
    const response = await fetch('http://localhost:3000/api/lugares', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(nuevoLugar.value),
    });

    if (response.ok) {
      const result = await response.json();
      
      // Recargar la lista de lugares
      await cargarLugares();
      
      // Seleccionar automáticamente el nuevo lugar
      id_lugar.value = result.lugar.id;
      
      // Cerrar el modal
      cerrarModalLugar();
      
      alert('Lugar creado exitosamente!');
    } else {
      const data = await response.json();
      errorLugar.value = data.message || 'Error al crear el lugar';
    }
  } catch (err) {
    console.error('Error de conexión:', err);
    errorLugar.value = 'Error de conexión con el servidor';
  } finally {
    loadingLugar.value = false;
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
    
    <!-- Lugar de origen con botón para agregar -->
    <div class="form-group">
      <label for="id_lugar">Lugar de Origen:</label>
      <div class="lugar-selector-container">
        <select v-model="id_lugar" id="id_lugar" class="lugar-select">
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
        <button 
          type="button" 
          @click="abrirModalLugar"
          class="btn-add-lugar"
          title="Agregar nuevo lugar"
        >
          ➕
        </button>
      </div>
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

  <!-- Modal para agregar nuevo lugar -->
  <div v-if="mostrarModalLugar" class="modal-overlay" @click="cerrarModalLugar">
    <div class="modal-content" @click.stop>
      <div class="modal-header">
        <h3>Agregar Nuevo Lugar</h3>
        <button @click="cerrarModalLugar" class="btn-close">✕</button>
      </div>
      
      <div class="modal-body">
        <!-- Mensaje de error del modal -->
        <div v-if="errorLugar" class="error-message">
          {{ errorLugar }}
        </div>
        
        <!-- Formulario de nuevo lugar -->
        <div class="form-group">
          <label for="lugar-nombre">Nombre del Lugar *</label>
          <input 
            id="lugar-nombre"
            v-model="nuevoLugar.nombre" 
            type="text" 
            placeholder="Ej: Francia, París"
            required
          />
        </div>
        
        <div class="form-group">
          <label for="lugar-tipo">Tipo *</label>
          <select id="lugar-tipo" v-model="nuevoLugar.tipo">
            <option value="PAIS">País</option>
            <option value="CIUDAD">Ciudad</option>
          </select>
        </div>
        
        <div v-if="nuevoLugar.tipo === 'PAIS'" class="form-group">
          <label for="lugar-continente">Continente *</label>
          <select id="lugar-continente" v-model="nuevoLugar.continente">
            <option value="">Seleccione un continente</option>
            <option value="Europa">Europa</option>
            <option value="Asia">Asia</option>
            <option value="África">África</option>
            <option value="América del Norte">América del Norte</option>
            <option value="América del Sur">América del Sur</option>
            <option value="Oceanía">Oceanía</option>
            <option value="Antártida">Antártida</option>
          </select>
        </div>
        
        <div v-if="nuevoLugar.tipo === 'CIUDAD'" class="form-group">
          <label for="lugar-pais">País *</label>
          <select id="lugar-pais" v-model="nuevoLugar.id_lugar_padre">
            <option value="">Seleccione un país</option>
            <option 
              v-for="pais in paises" 
              :key="pais.id" 
              :value="pais.id"
            >
              {{ pais.nombre }} ({{ pais.continente }})
            </option>
          </select>
        </div>
      </div>
      
      <div class="modal-footer">
        <button 
          @click="cerrarModalLugar" 
          class="btn-secondary"
          :disabled="loadingLugar"
        >
          Cancelar
        </button>
        <button 
          @click="crearLugar" 
          class="btn-primary"
          :disabled="loadingLugar"
        >
          {{ loadingLugar ? 'Creando...' : 'Crear Lugar' }}
        </button>
      </div>
    </div>
  </div>
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

/* Estilo para el selector de lugar con botón */
.lugar-selector-container {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.lugar-select {
  flex: 1;
}

.btn-add-lugar {
  padding: 0.75rem;
  background-color: #10b981;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.2s;
  min-width: 45px;
  height: 45px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.btn-add-lugar:hover {
  background-color: #059669;
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

/* Estilos del modal */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 500px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem;
  border-bottom: 1px solid #e5e7eb;
}

.modal-header h3 {
  margin: 0;
  color: #1f2937;
}

.btn-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #6b7280;
  padding: 0.25rem;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 4px;
}

.btn-close:hover {
  background-color: #f3f4f6;
  color: #374151;
}

.modal-body {
  padding: 1.5rem;
}

.modal-footer {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  padding: 1.5rem;
  border-top: 1px solid #e5e7eb;
}

@media (max-width: 640px) {
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .lugar-selector-container {
    flex-direction: column;
    align-items: stretch;
  }
  
  .btn-add-lugar {
    min-width: auto;
    height: auto;
    padding: 0.75rem 1rem;
  }
  
  .modal-content {
    margin: 1rem;
    width: calc(100% - 2rem);
  }
  
  .modal-footer {
    flex-direction: column;
  }
}
</style> 