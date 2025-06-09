<template>
  <div class="organigrama-view">
    <header class="view-header">
      <h1>Reporte de Estructura Organizacional</h1>
      <p>Visualice la jerarquía de departamentos y empleados de cada museo.</p>
    </header>

    <div class="selection-container card">
      <label for="museo-select">Seleccione un Museo:</label>
      <select id="museo-select" v-model="selectedMuseo" @change="fetchOrganigrama">
        <option disabled value="">Por favor seleccione uno</option>
        <option v-for="museo in museos" :key="museo.id" :value="museo.id">
          {{ museo.nombre }}
        </option>
      </select>
    </div>

    <div v-if="loading" class="loading-state">
      <p>Cargando reporte...</p>
    </div>

    <div v-if="error" class="error-state">
      <p>Ha ocurrido un error al cargar el reporte: {{ error }}</p>
    </div>

    <div v-if="museoInfo && organigrama" class="report-container card">
      <div class="report-header">
        <h2>{{ museoInfo.nombre }}</h2>
        <div class="header-details">
          <span><strong>Fundado en:</strong> {{ new Date(museoInfo.fecha_fundacion).getFullYear() }}</span>
          <span class="rank"><strong>Ranking:</strong> {{ museoInfo.ranking.categoria }}</span>
        </div>
        <p class="mission"><strong>Misión:</strong> {{ museoInfo.mision }}</p>
        <small><em>(El ranking se calcula basado en la estabilidad del personal y el volumen de visitas anuales)</em></small>
      </div>

      <div class="organigrama-content">
        <h3>Organigrama Jerárquico</h3>
        <ul class="organigrama-root">
          <OrganigramaNode v-for="node in organigrama" :key="node.id" :node="node" />
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import OrganigramaNode from '../components/OrganigramaNode.vue';

export default {
  name: 'OrganigramaView',
  components: {
    OrganigramaNode
  },
  data() {
    return {
      museos: [],
      selectedMuseo: '',
      organigrama: null,
      museoInfo: null,
      loading: false,
      error: null,
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
    async fetchOrganigrama() {
      if (!this.selectedMuseo) return;
      this.loading = true;
      this.error = null;
      this.organigrama = null;
      this.museoInfo = null;

      try {
        // Fetch organigrama and museo info in parallel
        const [organigramaResponse, museoInfoResponse] = await Promise.all([
          fetch(`http://localhost:3000/api/est-organizacional/museo/${this.selectedMuseo}`),
          fetch(`http://localhost:3000/api/museos/${this.selectedMuseo}`)
        ]);

        if (!organigramaResponse.ok) {
          throw new Error('Error al obtener la estructura organizacional.');
        }
        this.organigrama = await organigramaResponse.json();

        if (!museoInfoResponse.ok) {
          throw new Error('Error al obtener la información del museo.');
        }
        this.museoInfo = await museoInfoResponse.json();

      } catch (error) {
        this.error = error.message;
        console.error(error);
      } finally {
        this.loading = false;
      }
    }
  },
  created() {
    this.fetchMuseos();
  }
};
</script>

<style scoped>
.organigrama-view {
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

.organigrama-content h3 {
  color: #1f2937;
  border-bottom: 3px solid #3b82f6;
  padding-bottom: 0.75rem;
  margin-bottom: 2rem;
  font-size: 1.5rem;
  font-weight: 700;
  position: relative;
}

.organigrama-content h3::after {
  content: '';
  position: absolute;
  bottom: -3px;
  left: 0;
  width: 60px;
  height: 3px;
  background: linear-gradient(90deg, #3b82f6 0%, #1d4ed8 100%);
  border-radius: 2px;
}

.organigrama-root {
  list-style: none;
  padding: 0;
  margin: 2rem 0 0 0;
}

/* Responsive mejoras */
@media (max-width: 768px) {
  .organigrama-view {
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
}
</style> 