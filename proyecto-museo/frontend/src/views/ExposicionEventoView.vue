<template>
  <div class="exposicion-container">
    <!-- Header Section -->
    <section class="page-header">
      <div class="header-content">
        <div class="header-icon">🎭</div>
        <div class="header-text">
          <h1 class="page-title">Gestión de Exposiciones y Eventos</h1>
          <p class="page-subtitle">Registro y programación de exposiciones y eventos culturales</p>
        </div>
      </div>
    </section>

    <!-- Main Content -->
    <section class="main-content">
      <div class="content-wrapper">
        <!-- Info Card -->
        <div class="info-card">
          <div class="info-icon">ℹ️</div>
          <div class="info-content">
            <h3>Programación de Exposiciones</h3>
            <p>Complete el formulario para registrar una nueva exposición o evento. El sistema validará automáticamente la disponibilidad de salas y fechas.</p>
          </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
          <div class="form-header">
            <h2>Nueva Exposición/Evento</h2>
            <p>Ingrese los datos de la exposición o evento que desea programar</p>
          </div>

          <!-- Formulario -->
          <form @submit.prevent="submitForm" class="exposicion-form">
            
            <!-- Selector de Museo -->
            <div class="form-group">
              <label for="museo-select" class="form-label">
                <span class="label-text">Museo *</span>
                <span class="label-icon">🏛️</span>
              </label>
              <select 
                id="museo-select" 
                v-model="form.id_museo" 
                @change="fetchSalas"
                required
                class="form-select"
                :class="{ 'error': errors.id_museo }"
              >
                <option value="">Seleccione un museo</option>
                <option v-for="museo in museos" :key="museo.id" :value="museo.id">
                  {{ museo.nombre }}
                </option>
              </select>
              <span v-if="errors.id_museo" class="error-message">{{ errors.id_museo }}</span>
            </div>

            <!-- Selector de Sala -->
            <div class="form-group">
              <label for="sala-select" class="form-label">
                <span class="label-text">Sala de Exposición *</span>
                <span class="label-icon">🎪</span>
              </label>
              <select 
                id="sala-select" 
                v-model="selectedSala" 
                @change="updateSalaData"
                required
                :disabled="!form.id_museo || loadingSalas"
                class="form-select"
                :class="{ 'error': errors.sala, 'disabled': !form.id_museo }"
              >
                <option value="">{{ loadingSalas ? 'Cargando salas...' : 'Seleccione una sala' }}</option>
                <option v-for="sala in salas" :key="`${sala.id_sala}-${sala.id_est}`" :value="sala">
                  {{ sala.nombre }}
                </option>
              </select>
              <span v-if="errors.sala" class="error-message">{{ errors.sala }}</span>
            </div>

            <!-- Nombre de la Exposición -->
            <div class="form-group">
              <label for="nombre" class="form-label">
                <span class="label-text">Nombre de la Exposición/Evento *</span>
                <span class="label-icon">🎨</span>
              </label>
              <input 
                type="text" 
                id="nombre" 
                v-model="form.nombre" 
                required 
                maxlength="250"
                placeholder="Ej: Retrospectiva Pablo Picasso"
                class="form-input"
                :class="{ 'error': errors.nombre }"
              />
              <span v-if="errors.nombre" class="error-message">{{ errors.nombre }}</span>
              <small class="field-help">Máximo 250 caracteres</small>
            </div>

            <!-- Fechas -->
            <div class="form-row">
              <div class="form-group">
                <label for="fecha-inicio" class="form-label">
                  <span class="label-text">Fecha de Inicio *</span>
                  <span class="label-icon">📅</span>
                </label>
                <input 
                  type="date" 
                  id="fecha-inicio" 
                  v-model="form.fecha_inicio" 
                  required 
                  :min="minDate"
                  class="form-input"
                  :class="{ 'error': errors.fecha_inicio }"
                />
                <span v-if="errors.fecha_inicio" class="error-message">{{ errors.fecha_inicio }}</span>
              </div>
              <div class="form-group">
                <label for="fecha-fin" class="form-label">
                  <span class="label-text">Fecha de Finalización *</span>
                  <span class="label-icon">🏁</span>
                </label>
                <input 
                  type="date" 
                  id="fecha-fin" 
                  v-model="form.fecha_fin" 
                  required 
                  :min="form.fecha_inicio || minDate"
                  class="form-input"
                  :class="{ 'error': errors.fecha_fin }"
                />
                <span v-if="errors.fecha_fin" class="error-message">{{ errors.fecha_fin }}</span>
              </div>
            </div>

            <!-- Costo e Institución -->
            <div class="form-row">
              <div class="form-group">
                <label for="costo" class="form-label">
                  <span class="label-text">Costo por Persona (€)</span>
                  <span class="label-icon">💰</span>
                </label>
                <input 
                  type="number" 
                  id="costo" 
                  v-model="form.costo_persona" 
                  step="0.01" 
                  min="0"
                  placeholder="0.00"
                  class="form-input"
                  :class="{ 'error': errors.costo_persona }"
                />
                <span v-if="errors.costo_persona" class="error-message">{{ errors.costo_persona }}</span>
                <small class="field-help">Dejar vacío si es gratuito</small>
              </div>
              <div class="form-group">
                <label for="institucion" class="form-label">
                  <span class="label-text">Institución Educativa</span>
                  <span class="label-icon">🎓</span>
                </label>
                <input 
                  type="text" 
                  id="institucion" 
                  v-model="form.institucion_educativa" 
                  maxlength="250"
                  placeholder="Universidad, Escuela, etc."
                  class="form-input"
                  :class="{ 'error': errors.institucion_educativa }"
                />
                <span v-if="errors.institucion_educativa" class="error-message">{{ errors.institucion_educativa }}</span>
                <small class="field-help">Opcional - Máximo 250 caracteres</small>
              </div>
            </div>

            <!-- Botones -->
            <div class="form-actions">
              <button type="button" @click="resetForm" class="btn-secondary" :disabled="loading">
                <span class="btn-icon">🔄</span>
                Limpiar
              </button>
              <button type="submit" :disabled="loading" class="btn-primary">
                <span class="btn-icon">{{ loading ? '⏳' : '✅' }}</span>
                {{ loading ? 'Registrando...' : 'Registrar Exposición' }}
              </button>
            </div>

          </form>

          <!-- Mensaje de estado -->
          <div v-if="message" :class="['message', messageType]">
            <span class="message-icon">{{ messageType === 'success' ? '✅' : '❌' }}</span>
            <span class="message-text">{{ message }}</span>
          </div>
        </div>

        <!-- Quick Stats -->
        <div class="stats-container">
          <div class="stat-item">
            <div class="stat-icon">🎭</div>
            <div class="stat-content">
              <div class="stat-number">{{ loadingStats ? '...' : stats.exposicionesActivas }}</div>
              <div class="stat-label">Exposiciones Activas</div>
            </div>
          </div>
          <div class="stat-item">
            <div class="stat-icon">📅</div>
            <div class="stat-content">
              <div class="stat-number">{{ loadingStats ? '...' : stats.eventosProgramados }}</div>
              <div class="stat-label">Eventos Programados</div>
            </div>
          </div>
          <div class="stat-item">
            <div class="stat-icon">🏛️</div>
            <div class="stat-content">
              <div class="stat-number">{{ loadingStats ? '...' : stats.salasDisponibles }}</div>
              <div class="stat-label">Salas Disponibles</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'ExposicionEventoView',
  data() {
    return {
      museos: [],
      salas: [],
      selectedSala: null,
      loading: false,
      loadingSalas: false,
      message: '',
      messageType: '',
      errors: {},
      form: {
        id_museo: '',
        id_sala: '',
        id_est: '',
        nombre: '',
        fecha_inicio: '',
        fecha_fin: '',
        costo_persona: null,
        institucion_educativa: ''
      },
      stats: {
        exposicionesActivas: 0,
        eventosProgramados: 0,
        salasDisponibles: 0,
      },
      loadingStats: true,
    };
  },
  computed: {
    minDate() {
      const today = new Date();
      return today.toISOString().split('T')[0];
    }
  },
  methods: {
    async fetchStats() {
      this.loadingStats = true;
      try {
        const response = await fetch('http://localhost:3000/api/estadisticas/exposiciones');
        if (response.ok) {
          this.stats = await response.json();
        } else {
          console.error('Error al cargar estadísticas de exposiciones');
        }
      } catch (error) {
        console.error('Error de red al cargar estadísticas:', error);
      } finally {
        this.loadingStats = false;
      }
    },
    async fetchMuseos() {
      try {
        const response = await fetch('http://localhost:3000/api/museos');
        if (!response.ok) throw new Error('Error al obtener museos');
        this.museos = await response.json();
      } catch (error) {
        this.showMessage('Error al cargar los museos: ' + error.message, 'error');
      }
    },

    async fetchSalas() {
      if (!this.form.id_museo) {
        this.salas = [];
        return;
      }

      this.loadingSalas = true;
      try {
        const response = await fetch(`http://localhost:3000/api/salas-exp/museo/${this.form.id_museo}`);
        if (!response.ok) throw new Error('Error al obtener salas');
        this.salas = await response.json();
        
        // Limpiar sala seleccionada si cambió el museo
        this.selectedSala = null;
        this.form.id_sala = '';
        this.form.id_est = '';
        
      } catch (error) {
        this.showMessage('Error al cargar las salas: ' + error.message, 'error');
      } finally {
        this.loadingSalas = false;
      }
    },

    updateSalaData() {
      if (this.selectedSala) {
        this.form.id_sala = this.selectedSala.id_sala;
        this.form.id_est = this.selectedSala.id_est;
      } else {
        this.form.id_sala = '';
        this.form.id_est = '';
      }
    },

    validateForm() {
      this.errors = {};
      let isValid = true;

      // Validar campos obligatorios
      if (!this.form.id_museo) {
        this.errors.id_museo = 'Debe seleccionar un museo';
        isValid = false;
      }

      if (!this.form.id_sala || !this.form.id_est) {
        this.errors.sala = 'Debe seleccionar una sala';
        isValid = false;
      }

      if (!this.form.nombre.trim()) {
        this.errors.nombre = 'El nombre es obligatorio';
        isValid = false;
      } else if (this.form.nombre.length > 250) {
        this.errors.nombre = 'El nombre no puede exceder 250 caracteres';
        isValid = false;
      }

      if (!this.form.fecha_inicio) {
        this.errors.fecha_inicio = 'La fecha de inicio es obligatoria';
        isValid = false;
      }

      if (!this.form.fecha_fin) {
        this.errors.fecha_fin = 'La fecha de fin es obligatoria';
        isValid = false;
      }

      // Validar fechas
      if (this.form.fecha_inicio && this.form.fecha_fin) {
        if (new Date(this.form.fecha_inicio) >= new Date(this.form.fecha_fin)) {
          this.errors.fecha_fin = 'La fecha de fin debe ser posterior a la fecha de inicio';
          isValid = false;
        }
      }

      // Validar fecha de inicio no sea en el pasado
      if (this.form.fecha_inicio && new Date(this.form.fecha_inicio) < new Date(this.minDate)) {
        this.errors.fecha_inicio = 'La fecha de inicio no puede ser en el pasado';
        isValid = false;
      }

      // Validar costo
      if (this.form.costo_persona !== null && this.form.costo_persona !== '' && this.form.costo_persona < 0) {
        this.errors.costo_persona = 'El costo no puede ser negativo';
        isValid = false;
      }

      // Validar institución educativa
      if (this.form.institucion_educativa && this.form.institucion_educativa.length > 250) {
        this.errors.institucion_educativa = 'La institución educativa no puede exceder 250 caracteres';
        isValid = false;
      }

      return isValid;
    },

    async submitForm() {
      if (!this.validateForm()) {
        this.showMessage('Por favor corrija los errores en el formulario', 'error');
        return;
      }

      this.loading = true;
      try {
        const response = await fetch('http://localhost:3000/api/exposiciones-eventos', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            ...this.form,
            // Convertir costo vacío a null
            costo_persona: this.form.costo_persona === '' ? null : this.form.costo_persona,
            // Convertir institución vacía a null
            institucion_educativa: this.form.institucion_educativa.trim() === '' ? null : this.form.institucion_educativa.trim()
          })
        });

        if (!response.ok) {
          const errorData = await response.json();
          throw new Error(errorData.message || 'Error al registrar la exposición');
        }

        this.showMessage('Exposición/Evento registrado exitosamente', 'success');
        this.resetForm();
        
        // Actualizar estadísticas (simulado)
        this.stats.exposicionesActivas++;
        this.stats.eventosProgramados++;
        
      } catch (error) {
        this.showMessage('Error: ' + error.message, 'error');
      } finally {
        this.loading = false;
      }
    },

    resetForm() {
      this.form = {
        id_museo: '',
        id_sala: '',
        id_est: '',
        nombre: '',
        fecha_inicio: '',
        fecha_fin: '',
        costo_persona: null,
        institucion_educativa: ''
      };
      this.selectedSala = null;
      this.salas = [];
      this.errors = {};
      this.message = '';
    },

    showMessage(text, type) {
      this.message = text;
      this.messageType = type;
      setTimeout(() => {
        this.message = '';
      }, 5000);
    }
  },
  created() {
    this.fetchMuseos();
    this.fetchStats();
  }
}
</script>

<style scoped>
.exposicion-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 0;
}

.page-header {
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.1) 0%, rgba(0, 0, 0, 0.3) 100%);
  color: white;
  padding: 3rem 2rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  gap: 2rem;
}

.header-icon {
  font-size: 4rem;
  filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
}

.header-text {
  flex: 1;
}

.page-title {
  font-size: 3rem;
  font-weight: 800;
  margin-bottom: 0.5rem;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  background: linear-gradient(135deg, #ffffff 0%, #f1f5f9 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.page-subtitle {
  font-size: 1.2rem;
  opacity: 0.9;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
  margin: 0;
}

.main-content {
  background: var(--gray-100);
  padding: 3rem 2rem;
  min-height: calc(100vh - 200px);
}

.content-wrapper {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 2fr;
  grid-template-rows: auto 1fr auto;
  gap: 2rem;
  grid-template-areas: 
    "info form"
    "stats form"
    "stats form";
}

.info-card {
  grid-area: info;
  background: white;
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: var(--shadow-lg);
  border: 1px solid var(--gray-200);
  display: flex;
  gap: 1rem;
  align-items: flex-start;
}

.info-icon {
  font-size: 2rem;
  color: var(--primary-color);
  margin-top: 0.25rem;
}

.info-content h3 {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--gray-800);
  margin-bottom: 0.5rem;
}

.info-content p {
  color: var(--gray-600);
  font-size: 0.9rem;
  line-height: 1.5;
  margin: 0;
}

.form-container {
  grid-area: form;
  background: white;
  border-radius: 20px;
  padding: 2.5rem;
  box-shadow: var(--shadow-xl);
  border: 1px solid var(--gray-200);
}

.form-header {
  margin-bottom: 2rem;
  padding-bottom: 1.5rem;
  border-bottom: 2px solid var(--gray-200);
}

.form-header h2 {
  font-size: 2rem;
  font-weight: 700;
  color: var(--gray-800);
  margin-bottom: 0.5rem;
}

.form-header p {
  color: var(--gray-600);
  font-size: 1rem;
  margin: 0;
}

.exposicion-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-label {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-weight: 600;
  color: var(--gray-700);
  font-size: 0.95rem;
}

.label-text {
  flex: 1;
}

.label-icon {
  font-size: 1.1rem;
  opacity: 0.7;
}

.form-input,
.form-select {
  padding: 0.875rem 1rem;
  border: 2px solid var(--gray-300);
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.2s ease;
  background-color: white;
}

.form-input:focus,
.form-select:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.form-input.error,
.form-select.error {
  border-color: var(--error-color);
  box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}

.form-select:disabled,
.form-select.disabled {
  background-color: var(--gray-100);
  color: var(--gray-500);
  cursor: not-allowed;
}

.field-help {
  font-size: 0.8rem;
  color: var(--gray-500);
  font-style: italic;
}

.error-message {
  font-size: 0.85rem;
  color: var(--error-color);
  font-weight: 500;
}

.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 1px solid var(--gray-200);
}

.btn-primary,
.btn-secondary {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.875rem 1.5rem;
  border: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
}

.btn-primary {
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
  color: white;
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.2);
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(59, 130, 246, 0.3);
}

.btn-primary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

.btn-secondary {
  background-color: var(--gray-100);
  color: var(--gray-700);
  border: 2px solid var(--gray-300);
}

.btn-secondary:hover:not(:disabled) {
  background-color: var(--gray-200);
  border-color: var(--gray-400);
}

.btn-secondary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-icon {
  font-size: 1.1rem;
}

.message {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-top: 1.5rem;
  padding: 1rem 1.25rem;
  border-radius: 12px;
  font-weight: 500;
  font-size: 0.95rem;
}

.message.success {
  background-color: #d1fae5;
  color: #065f46;
  border: 1px solid #a7f3d0;
}

.message.error {
  background-color: #fee2e2;
  color: #991b1b;
  border: 1px solid #fca5a5;
}

.message-icon {
  font-size: 1.2rem;
}

.stats-container {
  grid-area: stats;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.stat-item {
  background: white;
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: var(--shadow-lg);
  border: 1px solid var(--gray-200);
  display: flex;
  align-items: center;
  gap: 1rem;
  transition: transform 0.2s ease;
}

.stat-item:hover {
  transform: translateY(-2px);
}

.stat-icon {
  font-size: 2.5rem;
  opacity: 0.8;
}

.stat-content {
  flex: 1;
}

.stat-number {
  font-size: 2rem;
  font-weight: 800;
  color: var(--primary-color);
  line-height: 1;
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.9rem;
  color: var(--gray-600);
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Responsive */
@media (max-width: 1024px) {
  .content-wrapper {
    grid-template-columns: 1fr;
    grid-template-areas: 
      "info"
      "form"
      "stats";
  }

  .stats-container {
    flex-direction: row;
    justify-content: space-between;
  }

  .stat-item {
    flex: 1;
    min-width: 0;
  }

  .stat-number {
    font-size: 1.5rem;
  }
}

@media (max-width: 768px) {
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .form-actions {
    flex-direction: column;
  }

  .stats-container {
    flex-direction: column;
  }

  .page-title {
    font-size: 2rem;
  }

  .header-content {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }

  .main-content {
    padding: 2rem 1rem;
  }

  .form-container {
    padding: 1.5rem;
  }
}
</style>