<template>
  <div class="empleados-view">
    <div class="empleados-container">
      <header class="view-header">
        <h1>Expedientes de Empleados</h1>
        <p>Busque y visualice los expedientes de curadores y restauradores.</p>
      </header>

      <!-- Nuevo sistema de búsqueda directa -->
      <div class="search-container card">
        <div class="search-wrapper">
          <label for="empleado-search">🔍 Buscar Empleado:</label>
          <div class="search-input-wrapper">
            <input
              id="empleado-search"
              type="text"
              v-model="searchQuery"
              @input="handleSearchInput"
              @focus="handleFocus"
              placeholder="Escriba nombre, apellido o documento de identidad..."
              class="search-input"
              autocomplete="off"
            />
            <button 
              v-if="searchQuery" 
              @click="clearSearch" 
              class="clear-button"
              title="Limpiar búsqueda"
            >
              ✕
            </button>
          </div>
          
          <!-- Dropdown de resultados -->
          <div 
            v-if="showDropdown && (searchResults.length > 0 || isSearching)" 
            class="search-dropdown"
            @click.stop
          >
            <div v-if="isSearching" class="dropdown-loading">
              <span class="loading-spinner"></span>
              Buscando empleados...
            </div>
            
            <div v-else-if="searchResults.length === 0 && searchQuery.trim()" class="dropdown-empty">
              No se encontraron curadores o restauradores que coincidan con "{{ searchQuery }}"
            </div>
            
            <div v-else class="dropdown-results">
              <div v-if="!searchQuery.trim() && searchResults.length > 0" class="dropdown-header">
                <span class="result-count">{{ searchResults.length }} curadores y restauradores encontrados</span>
                <small>Escriba para filtrar resultados</small>
              </div>
              
              <div 
                v-for="empleado in searchResults" 
                :key="empleado.id"
                @click="selectEmpleado(empleado)"
                class="dropdown-item"
                :class="{ 'inactive': !empleado.posicion_actual.activo }"
              >
                <div class="empleado-info">
                  <div class="empleado-name">{{ empleado.nombre_completo }}</div>
                  <div class="empleado-doc">Documento de identidad: {{ empleado.doc_identidad }}</div>
                  <div class="empleado-position" v-if="empleado.posicion_actual.activo">
                    <strong>{{ empleado.posicion_actual.cargo }}</strong>
                    <span class="museum-name">{{ empleado.posicion_actual.museo }}</span>
                    <span v-if="empleado.posicion_actual.departamento" class="department-name">
                      • {{ empleado.posicion_actual.departamento }}
                    </span>
                  </div>
                  <div v-else class="empleado-inactive">
                    <span class="inactive-badge">Inactivo</span>
                  </div>
                </div>
              </div>
            </div>
            
            <div v-if="searchResults.length >= 50" class="dropdown-footer">
              Mostrando primeros 50 resultados. Refine su búsqueda para mejores resultados.
            </div>
          </div>
        </div>
      </div>

      <!-- Loading y Error States -->
      <div v-if="loading && !detallesEmpleado" class="loading-state">
        <p>Cargando expediente...</p>
      </div>

      <div v-if="error && !detallesEmpleado" class="error-state">
        <p>Ha ocurrido un error: {{ error }}</p>
      </div>

      <!-- Vista de detalles del empleado -->
      <div v-if="detallesEmpleado || loadingEmpleado || errorEmpleado" class="employee-detail-view">
        <EmpleadoDet
          v-if="detallesEmpleado"
          :empleado="detallesEmpleado"
          :empleado-seleccionado="empleadoSeleccionado"
          @back-to-list="clearDetallesEmpleado"
        />
        <div v-if="loadingEmpleado" class="loading-details-message">
          <span class="loading-spinner"></span>
          Cargando expediente del empleado...
        </div>
        <p v-if="errorEmpleado" class="error-details-message">Error al cargar expediente: {{ errorEmpleado }}</p>
      </div>

      <!-- Mensaje inicial -->
      <div v-if="!detallesEmpleado && !showDropdown" class="welcome-message card">
        <div class="welcome-content">
          <h3>👋 Sistema de Expedientes</h3>
          <p>Comience escribiendo el nombre, apellido o documento de identidad del curador o restaurador que desea consultar.</p>
        </div>
      </div>

      <!-- Consejos de búsqueda - Aparecen cuando no hay empleado seleccionado y no se muestra dropdown -->
      <div v-if="!detallesEmpleado && !showDropdown" class="search-tips-section card">
        <div class="search-tips">
          <h4>💡 Consejos de búsqueda:</h4>
          <ul>
            <li>Puede buscar por nombre completo o parcial</li>
            <li>Use el documento de identidad para búsquedas exactas</li>
            <li>Los resultados muestran solo curadores y restauradores activos</li>
            <li>Haga clic en el campo de búsqueda para ver todos los curadores y restauradores</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import EmpleadoDet from '../components/EmpleadoDet.vue';

export default {
  name: 'EmpleadosView',
  components: {
    EmpleadoDet
  },
  data() {
    return {
      searchQuery: '',
      searchResults: [],
      empleadoSeleccionado: null,
      showDropdown: false,
      isSearching: false,
      searchTimeout: null,
      loading: false,
      error: null,
      detallesEmpleado: null,
      loadingEmpleado: false,
      errorEmpleado: null
    };
  },
  methods: {
    handleSearchInput() {
      // Debounce para evitar muchas consultas
      if (this.searchTimeout) {
        clearTimeout(this.searchTimeout);
      }
      
      this.searchTimeout = setTimeout(() => {
        this.performSearch();
      }, 300); // Esperar 300ms después de que el usuario deje de escribir
    },

    async performSearch() {
      const query = this.searchQuery.trim();
      
      if (query.length < 2) {
        this.searchResults = [];
        this.showDropdown = false;
        return;
      }

      this.isSearching = true;
      this.showDropdown = true;
      this.error = null;

      try {
        const response = await fetch(`http://localhost:3000/api/empleados/buscar?q=${encodeURIComponent(query)}`);
        
        if (!response.ok) {
          throw new Error('Error al buscar empleados');
        }

        const empleados = await response.json();
        this.searchResults = empleados;
        
        // Si hay una búsqueda exacta por documento, seleccionar automáticamente
        if (empleados.length === 1 && empleados[0].doc_identidad === query) {
          this.selectEmpleado(empleados[0]);
        }
        
      } catch (error) {
        console.error('Error en búsqueda:', error);
        this.error = error.message;
        this.searchResults = [];
      } finally {
        this.isSearching = false;
      }
    },

    selectEmpleado(empleado) {
      this.empleadoSeleccionado = empleado;
      this.searchQuery = empleado.nombre_completo;
      this.showDropdown = false;
      this.fetchDetallesEmpleado(empleado);
    },

    async fetchDetallesEmpleado(empleado) {
      this.detallesEmpleado = null;
      this.loadingEmpleado = true;
      this.errorEmpleado = null;

      try {
        const response = await fetch(`http://localhost:3000/api/empleados/${empleado.id}`);
        
        if (!response.ok) {
          throw new Error('No se pudieron obtener los detalles del empleado');
        }

        const detalles = await response.json();
        this.detallesEmpleado = detalles;
        
      } catch (error) {
        console.error('Error al cargar detalles:', error);
        this.errorEmpleado = error.message;
      } finally {
        this.loadingEmpleado = false;
      }
    },

    clearSearch() {
      this.searchQuery = '';
      this.searchResults = [];
      this.showDropdown = false;
      this.empleadoSeleccionado = null;
      if (this.searchTimeout) {
        clearTimeout(this.searchTimeout);
      }
    },

    clearDetallesEmpleado() {
      this.detallesEmpleado = null;
      this.errorEmpleado = null;
      this.empleadoSeleccionado = null;
      this.searchQuery = '';
      this.searchResults = [];
    },

    // Click fuera del dropdown para cerrarlo
    handleClickOutside(event) {
      if (!this.$el.contains(event.target)) {
        this.closeDropdown();
      }
    },

    // Mejorar la experiencia cuando se cierra el dropdown
    closeDropdown() {
      this.showDropdown = false;
      // Pequeño delay para que la transición se vea suave
      setTimeout(() => {
        if (!this.searchQuery.trim()) {
          this.searchResults = [];
        }
      }, 200);
    },

    async handleFocus() {
      this.showDropdown = true;
      
      // Si no hay resultados de búsqueda cargados, cargar todos los empleados
      if (this.searchResults.length === 0 && !this.isSearching) {
        await this.loadAllEmployees();
      }
    },

    async loadAllEmployees() {
      this.isSearching = true;
      this.error = null;

      try {
        const response = await fetch('http://localhost:3000/api/empleados/buscar');
        
        if (!response.ok) {
          throw new Error('Error al cargar la lista de empleados');
        }

        const empleados = await response.json();
        this.searchResults = empleados;
        
      } catch (error) {
        console.error('Error al cargar empleados:', error);
        this.error = error.message;
        this.searchResults = [];
      } finally {
        this.isSearching = false;
      }
    }
  },
  
  mounted() {
    document.addEventListener('click', this.handleClickOutside);
  },
  
  beforeUnmount() {
    document.removeEventListener('click', this.handleClickOutside);
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
  }
}
</script>

<style scoped>
.empleados-view {
  padding: 2rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}

.empleados-container {
  max-width: 1200px;
  margin: 0 auto;
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

/* ESTILOS DEL SISTEMA DE BÚSQUEDA */
.search-container {
  position: relative;
}

.search-wrapper {
  position: relative;
}

.search-wrapper label {
  display: block;
  font-weight: 600;
  color: #374151;
  font-size: 1.1rem;
  margin-bottom: 1rem;
}

.search-input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.search-input {
  width: 100%;
  padding: 1rem 1.5rem;
  padding-right: 3rem;
  border: 2px solid #e5e7eb;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background-color: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.search-input:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1), 0 4px 8px rgba(0,0,0,0.1);
  transform: translateY(-1px);
}

.clear-button {
  position: absolute;
  right: 1rem;
  background: none;
  border: none;
  color: #9ca3af;
  font-size: 1.2rem;
  cursor: pointer;
  padding: 0.25rem;
  border-radius: 50%;
  transition: all 0.2s ease;
}

.clear-button:hover {
  color: #ef4444;
  background-color: #fee2e2;
}

/* DROPDOWN DE RESULTADOS */
.search-dropdown {
  position: absolute;
  top: calc(100% + 0.5rem);
  left: 0;
  right: 0;
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.15), 0 4px 10px rgba(0,0,0,0.1);
  border: 1px solid #e5e7eb;
  max-height: 400px;
  overflow-y: auto;
  z-index: 1000;
}

.dropdown-loading, .dropdown-empty {
  padding: 2rem;
  text-align: center;
  color: #6b7280;
  font-style: italic;
}

.dropdown-loading {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.dropdown-results {
  padding: 0.5rem 0;
}

.dropdown-item {
  padding: 1rem 1.5rem;
  cursor: pointer;
  transition: all 0.2s ease;
  border-bottom: 1px solid #f3f4f6;
}

.dropdown-item:hover {
  background-color: #f8fafc;
  border-left: 4px solid #3b82f6;
}

.dropdown-item:last-child {
  border-bottom: none;
}

.dropdown-item.inactive {
  opacity: 0.6;
}

.dropdown-item.inactive:hover {
  border-left-color: #9ca3af;
}

.empleado-info {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.empleado-name {
  font-weight: 600;
  color: #1f2937;
  font-size: 1rem;
}

.empleado-doc {
  font-size: 0.85rem;
  color: #6b7280;
}

.empleado-position {
  font-size: 0.9rem;
  color: #374151;
  margin-top: 0.25rem;
}

.museum-name {
  color: #3b82f6;
  font-weight: 500;
  margin-left: 0.5rem;
}

.department-name {
  color: #6b7280;
  font-size: 0.8rem;
}

.empleado-inactive {
  margin-top: 0.25rem;
}

.inactive-badge {
  background-color: #fca5a5;
  color: #dc2626;
  padding: 0.125rem 0.5rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 500;
}

.dropdown-header {
  padding: 0.75rem 1.5rem;
  background-color: #f8fafc;
  border-bottom: 1px solid #e5e7eb;
  text-align: center;
}

.dropdown-header .result-count {
  font-weight: 600;
  color: #374151;
  font-size: 0.9rem;
}

.dropdown-header small {
  display: block;
  color: #6b7280;
  font-size: 0.8rem;
  margin-top: 0.25rem;
  font-style: italic;
}

.dropdown-footer {
  padding: 0.75rem 1.5rem;
  background-color: #f9fafb;
  color: #6b7280;
  font-size: 0.85rem;
  text-align: center;
  border-top: 1px solid #e5e7eb;
}

/* LOADING SPINNER */
.loading-spinner {
  display: inline-block;
  width: 1rem;
  height: 1rem;
  border: 2px solid #e5e7eb;
  border-top: 2px solid #3b82f6;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* ESTADOS DE CARGA Y ERROR */
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

.loading-details-message, .error-details-message {
  text-align: center;
  margin-top: 2rem;
  padding: 2rem;
  border-radius: 12px;
}

.loading-details-message {
  background-color: #f8fafc;
  color: #6b7280;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.error-details-message {
  background-color: #fef2f2;
  color: #dc2626;
  border: 1px solid #fecaca;
}

/* MENSAJE DE BIENVENIDA */
.welcome-message {
  background: linear-gradient(135deg, #ffffff 0%, #f9fafb 100%);
  text-align: center;
  margin-top: 2rem;
}

.welcome-content h3 {
  color: #1f2937;
  margin-bottom: 1rem;
  font-size: 1.5rem;
}

.welcome-content p {
  color: #6b7280;
  font-size: 1.1rem;
  margin-bottom: 0;
  line-height: 1.6;
}

/* CONSEJOS DE BÚSQUEDA - SECCIÓN SEPARADA */
.search-tips-section {
  background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
  margin-top: 1rem;
  border: 1px solid #bae6fd;
  transition: all 0.3s ease;
  animation: fadeInUp 0.4s ease-out;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.search-tips {
  text-align: left;
  padding: 0;
}

.search-tips h4 {
  color: #1e40af;
  margin-bottom: 1rem;
  font-size: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.search-tips ul {
  color: #374151;
  margin: 0;
  padding-left: 1.5rem;
}

.search-tips li {
  margin-bottom: 0.5rem;
  line-height: 1.5;
}

/* RESPONSIVE */
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

  .search-input {
    padding: 0.875rem 1.25rem;
    font-size: 0.95rem;
  }

  .dropdown-item {
    padding: 1rem;
  }

  .empleado-name {
    font-size: 0.95rem;
  }

  .search-tips {
    padding: 1rem;
  }
}
</style>
