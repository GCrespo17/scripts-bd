<template>
  <div class="empleados-view">
    <header class="view-header">
      <h1>Reporte de Empleados Profesionales</h1>
      <p>Visualice los detalles de cada empleado.</p>
    </header>

    <div class="selection-container card">
      <label for="museo-select">Seleccione un Museo:</label>
      <select id="museo-select" v-model="selectedMuseo" @change="fetchMuseoSeleccionado">
        <option disabled value="">Por favor seleccione uno</option>
        <option v-for="museo in museos" :key="museo.id" :value="museo.id">
          {{ museo.nombre }}
        </option>
      </select>
    </div>

    <div v-if="loading && !detallesEmpleado" class="loading-state">
      <p>Cargando reporte...</p>
    </div>

    <div v-if="error && !detallesEmpleado" class="error-state">
      <p>Ha ocurrido un error al cargar el reporte: {{ error }}</p>
    </div>


    <div v-if="museoInfo" class="report-container card employee-select">
      <div class="report-header">
        <h2>{{ museoInfo.nombre }}</h2>
        <div class="header-details">
          <span><strong>Fundado en:</strong> {{ new Date(museoInfo.fecha_fundacion).getFullYear() }}</span>
          <span v-if="museoInfo.ranking && museoInfo.ranking.categoria" class="rank">{{ museoInfo.ranking.categoria }}</span>
          <span v-if="museoInfo.ranking && museoInfo.ranking.ubicacion" class="location">
            📍 {{ museoInfo.ranking.ubicacion.ciudad }}, {{ museoInfo.ranking.ubicacion.pais }}
          </span>
        </div>
        <p class="mission"><strong>Misión:</strong> {{ museoInfo.mision }}</p>
        <div v-if="museoInfo.ranking && museoInfo.ranking.metricas" class="museo-stats">
          <div class="stat">
            <span class="stat-number">{{ museoInfo.ranking.metricas.total_empleados || 0 }}</span>
            <span class="stat-label">Empleados Activos</span>
          </div>
          <div class="stat">
            <span class="stat-number">{{ formatNumber(museoInfo.ranking.metricas.visitas_ultimo_anio) || 0 }}</span>
            <span class="stat-label">Visitas Anuales</span>
          </div>
        </div>
      </div>


      <div v-if="detallesEmpleado || loadingEmpleado || errorEmpleado" class="employee-detail-view">
        <EmpleadoDet
          v-if="detallesEmpleado"
          :empleado="detallesEmpleado"
          @back-to-list="clearDetallesEmpleado"
        />
        <p v-if="loadingEmpleado" class="loading-details-message">Cargando detalles del empleado...</p>
        <p v-if="errorEmpleado" class="error-details-message">Error al cargar detalles: {{ errorEmpleado }}</p>
      </div>


      <div v-else class="employee-list-view">
        <div class="selection-container card">
          <label for="profesional-select">Seleccione el Cargo del Empleado Profesional: </label>
          <select id="profesional-select" v-model="tipoProfesional">
            <option disabled value="">Por favor seleccione uno</option>
            <option value="curador">Curador</option>
            <option value="restaurador">Restaurador</option>
          </select>
        </div>

        <div v-if="tipoProfesional == 'curador' && empleados" class="report-container card">
          <div class="empleados-content">
            <h2>Curadores:</h2>
            <div class="empleados-root">
              <EmpleadosNode
                v-for="empleado in empleados"
                :key="empleado.doc_identidad"
                :empleado="empleado"
                @employee-selected="fetchDetallesEmpleados"
              />
            </div>
          </div>
        </div>

        <div v-if="tipoProfesional == 'restaurador' && empleados" class="report-container card">
          <div class="empleados-content">
            <h2>Restauradores:</h2>
            <div class="empleados-root">
              <EmpleadosNode
                v-for="empleado in empleados"
                :key="empleado.doc_identidad"
                :empleado="empleado"
                @employee-selected="fetchDetallesEmpleados"
              />
            </div>
          </div>
        </div>


        <div v-else-if="tipoProfesional && !empleados && !loading && !error" class="no-employees-message">
          <p>No se encontraron empleados del tipo seleccionado para este museo.</p>
        </div>
      </div>


    </div>
  </div>
</template>

<script>
import EmpleadoDet from '../components/EmpleadoDet.vue';
import EmpleadosNode from '../components/EmpleadosNode.vue';

export default {
  name: 'EmpleadosView',
  components: {
    EmpleadosNode,
    EmpleadoDet
  },
  data() {
    return {
      museos: [],
      selectedMuseo: '',
      empleados: null,
      museoInfo: null,
      tipoProfesional: null,
      loading: false,
      error: null,
      detallesEmpleado: null, 
      loadingEmpleado: false, 
      errorEmpleado: null     
    };
  },
  methods: {
    async fetchMuseos() {
      try {
        const response = await fetch('http://localhost:3000/api/museos');
        if (!response.ok) {
          throw new Error('No se pudieron obtener los museos.');
        }
        this.museos = await response.json();
      } catch (error) {
        this.error = error.message;
        console.error(error);
      }
    },
    async fetchMuseoSeleccionado() {
      if (!this.selectedMuseo)
        return;
      this.loading = true;
      this.error = null;
      this.museoInfo = null;
      this.empleados = null; 
      this.detallesEmpleado = null; 

      try {
        const response = await fetch(`http://localhost:3000/api/museos/${this.selectedMuseo}`);
        if (!response.ok) {
          throw new Error('No se pudo obtener la informacion del museo.');
        }
        this.museoInfo = await response.json();

        if (this.tipoProfesional) {
          if (this.tipoProfesional === 'curador') {
            this.fetchCuradores();
          } else if (this.tipoProfesional === 'restaurador') {
            this.fetchRestauradores();
          }
        }
      } catch (error) {
        this.error = error.message;
        console.error(error);
      } finally {
        this.loading = false;
      }
    },
    async fetchCuradores() {
      if (!this.selectedMuseo)
        return;
      this.loading = true;
      this.error = null;
      this.empleados = null; 
      this.detallesEmpleado = null; 

      try {
        const curadoresResponse = await fetch(`http://localhost:3000/api/empleados/curadores/${this.selectedMuseo}`);
        if (!curadoresResponse.ok) {
          throw new Error('Error al obtener a los curadores.');
        }

        this.empleados = await curadoresResponse.json();
        console.log("Curadores cargados:", this.empleados);

      } catch (error) {
        this.error = error.message;
        console.error(error);
      } finally {
        this.loading = false;
      }
    },
    async fetchRestauradores() {
      if (!this.selectedMuseo)
        return;
      this.loading = true;
      this.error = null;
      this.empleados = null; 
      this.detallesEmpleado = null; 

      try {
        const restauradoresResponse = await fetch(`http://localhost:3000/api/empleados/restauradores/${this.selectedMuseo}`);
        if (!restauradoresResponse.ok) {
          throw new Error('Error al obtener a los curadores.');
        }

        this.empleados = await restauradoresResponse.json();
        console.log("Restauradores cargados:", this.empleados);

      } catch (error) {
        this.error = error.message;
        console.error(error);
      } finally {
        this.loading = false;
      }
    },
    async fetchDetallesEmpleados(empleado) { 

      this.detallesEmpleado = null; 
      this.loadingEmpleado = true; 
      this.errorEmpleado = null;   

      try {
       
        const fichaResponse = await fetch(`http://localhost:3000/api/empleados/${empleado.id}`); 
        if (!fichaResponse.ok) {
          throw new Error('No se pudieron obtener los detalles de este empleado.');
        }
        const detalles = await fichaResponse.json(); 
        this.detallesEmpleado = detalles; 
        console.log('Frontend: Detalles completos del empleado cargados:', detalles);
      } catch (error) {
        console.error('Error al cargar los detalles del empleado:', error);
        this.errorEmpleado = 'Error al cargar los detalles del empleado: ' + error.message;
        this.detallesEmpleado = null; 
      } finally {
        this.loadingEmpleado = false; 
      }
    },
    clearDetallesEmpleado() {
      this.detallesEmpleado = null; 
      this.errorEmpleado = null;
    },
    formatNumber(num) {
      if (!num) return '0';
      return new Intl.NumberFormat('es-ES').format(num);
    }
  },
  watch: {
    tipoProfesional(newType, oldType) {
      console.log('WATCH: tipoProfesional changed from', oldType, 'to', newType);
      this.detallesEmpleado = null;
      if (newType === 'curador' && this.selectedMuseo) {
        this.fetchCuradores();
      } else if (newType === 'restaurador' && this.selectedMuseo) {
        this.fetchRestauradores();
      } else {
        console.log('WATCH: Clearing employee data (no type or museum selected)');
        this.empleados = null; 
      }
    },
    selectedMuseo() {
      this.detallesEmpleado = null;
    }
  },
  created() {
    this.fetchMuseos();
  }
}
</script>

<style scoped>
.empleados-view {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  border-radius: 0;
}

.view-header {
  text-align: center;
  margin-bottom: 2rem;
  color: white;
}

.view-header h1 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  text-shadow: 0 2px 4px rgba(0,0,0,0.3);
}

.view-header p {
  font-size: 1.1rem;
  opacity: 0.9;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

.card {
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.15), 0 4px 10px rgba(0,0,0,0.1);
  padding: 2rem;
  margin-bottom: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255,255,255,0.2);
}

.selection-container {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.selection-container label {
  font-weight: 600;
  color: #374151;
  font-size: 1rem;
  white-space: nowrap;
}

select {
  flex: 1;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  border: 2px solid #e5e7eb;
  font-size: 1rem;
  transition: all 0.2s ease;
  background-color: white;
  min-width: 200px;
}

select:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.loading-state, .error-state {
  text-align: center;
  padding: 3rem;
  border-radius: 16px;
}

.loading-state {
  background: linear-gradient(135deg, #f3f4f6 0%, #ffffff 100%);
  color: #6b7280;
}

.error-state {
  background: linear-gradient(135deg, #fef2f2 0%, #ffffff 100%);
  color: #dc2626;
  border: 1px solid #fecaca;
}

.report-container {
  background: linear-gradient(135deg, #ffffff 0%, #f9fafb 100%);
  border: none;
  box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

.report-header {
  border-bottom: 3px solid #f0f0f0;
  padding-bottom: 2rem;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #f8fafc 0%, transparent 100%);
  padding: 2rem;
  margin: -2rem -2rem 2rem -2rem;
  border-radius: 16px 16px 0 0;
}

.report-header h2 {
  color: #1f2937;
  margin-top: 0;
  font-size: 2rem;
  font-weight: 700;
  text-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.header-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  flex-wrap: wrap;
  gap: 1rem;
}

.header-details span {
  font-size: 1rem;
  color: #374151;
}

.rank {
  background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
  color: white;
  padding: 0.5rem 1.2rem;
  border-radius: 25px;
  font-weight: 700;
  font-size: 0.9rem;
  box-shadow: 0 4px 8px rgba(59, 130, 246, 0.3);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.mission {
  font-style: italic;
  color: #555;
  font-size: 1.1rem;
  line-height: 1.6;
  margin: 1rem 0;
  padding: 1rem;
  background-color: #f8fafc;
  border-radius: 8px;
  border-left: 4px solid #3b82f6;
}

.empleados-content h3 {
  color: #1f2937;
  border-bottom: 3px solid #3b82f6;
  padding-bottom: 0.75rem;
  margin-bottom: 2rem;
  font-size: 1.5rem;
  font-weight: 700;
  position: relative;
}

.empleados-content h3::after {
  content: '';
  position: absolute;
  bottom: -3px;
  left: 0;
  width: 60px;
  height: 3px;
  background: linear-gradient(90deg, #3b82f6 0%, #1d4ed8 100%);
  border-radius: 2px;
}

.empleados-root {
  list-style: none;
  padding: 0;
  margin: 2rem 0 0 0;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1rem;
  padding: 1rem 0;
}

/* Estilos para los mensajes de carga/error específicos del detalle */
.loading-details-message, .error-details-message {
  text-align: center;
  margin-top: 1rem;
  font-style: italic;
  color: #888;
}

.error-details-message {
  color: #c0392b;
}

/* Estilos para el ranking y estadísticas del museo */
.museo-stats {
  display: flex;
  gap: 2rem;
  margin-top: 1rem;
  padding: 1rem 0;
}

.stat {
  text-align: center;
  padding: 1rem;
  background: rgba(255,255,255,0.1);
  border-radius: 8px;
  min-width: 120px;
}

.stat-number {
  display: block;
  font-size: 1.5rem;
  font-weight: 700;
  color: #1f2937;
}

.stat-label {
  display: block;
  font-size: 0.8rem;
  color: #6b7280;
  margin-top: 0.25rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.location {
  background: rgba(255,255,255,0.15);
  padding: 0.25rem 0.75rem;
  border-radius: 15px;
  font-size: 0.85rem;
  font-weight: 500;
}

/* Responsive mejoras */
@media (max-width: 768px) {
  .empleados-view {
    padding: 1rem;
  }

  .view-header h1 {
    font-size: 2rem;
  }

  .card {
    padding: 1.5rem;
  }

  .selection-container {
    flex-direction: column;
    align-items: stretch;
  }

  .header-details {
    flex-direction: column;
    align-items: flex-start;
  }

  .report-header {
    padding: 1.5rem;
    margin: -1.5rem -1.5rem 1.5rem -1.5rem;
  }

  .museo-stats {
    flex-direction: column;
    gap: 1rem;
  }

  .stat {
    min-width: auto;
  }
}
</style>
