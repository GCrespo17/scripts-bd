<template>
  <div class="home-container">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-content">
        <div class="hero-icon">🏛️</div>
        <h1 class="hero-title">Sistema de Gestión de Museos</h1>
        <p class="hero-subtitle">Plataforma integral para la administración y gestión de colecciones, personal y actividades museísticas</p>
        
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-icon">🎨</div>
            <div class="stat-number">{{ loading ? '...' : stats.totalArtistas }}</div>
            <div class="stat-label">Artistas Registrados</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-number">{{ loading ? '...' : stats.totalEmpleados }}</div>
            <div class="stat-label">Empleados Activos</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon">🏢</div>
            <div class="stat-number">{{ loading ? '...' : stats.totalMuseos }}</div>
            <div class="stat-label">Museos Registrados</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon">🎭</div>
            <div class="stat-number">{{ loading ? '...' : stats.totalExposiciones }}</div>
            <div class="stat-label">Exposiciones Activas</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
      <h2 class="section-title">Funcionalidades Principales</h2>
      <div class="features-grid">
        <RouterLink to="/artistas" class="feature-card">
          <div class="feature-icon">🎨</div>
          <h3>Gestión de Artistas</h3>
          <p>Registro y administración completa de artistas, incluyendo biografías, obras y trayectorias profesionales.</p>
          <div class="feature-arrow">→</div>
        </RouterLink>

        <RouterLink to="/organigrama" class="feature-card">
          <div class="feature-icon">📊</div>
          <h3>Estructura Organizacional</h3>
          <p>Visualización jerárquica del personal y departamentos, con información de empleados y cargos.</p>
          <div class="feature-arrow">→</div>
        </RouterLink>

        <RouterLink to="/empleados" class="feature-card">
          <div class="feature-icon">👤</div>
          <h3>Gestión de Empleados</h3>
          <p>Control completo del personal, cargos, departamentos y información profesional de cada empleado.</p>
          <div class="feature-arrow">→</div>
        </RouterLink>

        <RouterLink to="/exposiciones" class="feature-card">
          <div class="feature-icon">🎭</div>
          <h3>Exposiciones y Eventos</h3>
          <p>Planificación y gestión de exposiciones temporales, eventos culturales y actividades educativas.</p>
          <div class="feature-arrow">→</div>
        </RouterLink>

        <RouterLink to="/reporte-estructura" class="feature-card">
          <div class="feature-icon">🏗️</div>
          <h3>Estructura Física</h3>
          <p>Análisis detallado de la infraestructura del museo, edificios, pisos y distribución de espacios.</p>
          <div class="feature-arrow">→</div>
        </RouterLink>

        <RouterLink to="/programa-mantenimiento" class="feature-card">
          <div class="feature-icon">🔧</div>
          <h3>Programa de Mantenimiento</h3>
          <p>Seguimiento y planificación de actividades de mantenimiento preventivo y correctivo.</p>
          <div class="feature-arrow">→</div>
        </RouterLink>
      </div>
    </section>

    <!-- Quick Actions Section -->
    <section class="quick-actions-section">
      <h2 class="section-title">Acciones Rápidas</h2>
      <div class="actions-grid">
        <div class="action-card" @click="navigateToArtistas">
          <div class="action-icon">🎨</div>
          <h4>Ver Artistas</h4>
          <p>Consultar y gestionar artistas registrados</p>
        </div>
        <div class="action-card" @click="navigateToOrganigrama">
          <div class="action-icon">📊</div>
          <h4>Ver Organigrama</h4>
          <p>Consultar la estructura organizacional</p>
        </div>
        <div class="action-card" @click="navigateToEmpleados">
          <div class="action-icon">👥</div>
          <h4>Gestión de Personal</h4>
          <p>Ver y administrar empleados</p>
        </div>
        <div class="action-card" @click="navigateToEstructura">
          <div class="action-icon">🏗️</div>
          <h4>Estructura Física</h4>
          <p>Revisar infraestructura del museo</p>
        </div>
      </div>
    </section>

    <!-- Recent Activity Section -->
    <section v-if="recentActivity.length > 0" class="recent-activity-section">
      <h2 class="section-title">Actividad Reciente</h2>
      <div class="activity-card">
        <div class="activity-list">
          <div v-for="activity in recentActivity" :key="activity.id" class="activity-item">
            <div class="activity-icon">{{ activity.icon }}</div>
            <div class="activity-content">
              <h4>{{ activity.title }}</h4>
              <p>{{ activity.description }}</p>
              <span class="activity-time">{{ activity.time }}</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

export default {
  name: 'HomeView',
  setup() {
    const router = useRouter()
    const loading = ref(true)
    const stats = ref({
      totalArtistas: 0,
      totalEmpleados: 0,
      totalMuseos: 0,
      totalExposiciones: 0
    })
    const recentActivity = ref([])

    const fetchStats = async () => {
      try {
        loading.value = true
        
        // Usar el endpoint optimizado que hace COUNT en la base de datos
        const response = await fetch('http://localhost:3000/api/estadisticas')
        
        if (response.ok) {
          const estadisticas = await response.json()
          stats.value = estadisticas
          generateRecentActivity()
        } else {
          console.error('Error al obtener estadísticas:', response.status, response.statusText)
          // Mantener valores por defecto (0) si hay error
        }

      } catch (error) {
        console.error('Error al obtener estadísticas:', error)
        // Mantener valores por defecto (0) si hay error
      } finally {
        loading.value = false
      }
    }

    const generateRecentActivity = () => {
      const activities = []
      
      if (stats.value.totalArtistas > 0) {
        activities.push({
          id: 1,
          icon: '🎨',
          title: 'Artistas Actualizados',
          description: `${stats.value.totalArtistas} artistas registrados en el sistema`,
          time: 'Hace 2 horas'
        })
      }

      if (stats.value.totalEmpleados > 0) {
        activities.push({
          id: 2,
          icon: '👥',
          title: 'Personal Activo',
          description: `${stats.value.totalEmpleados} empleados activos en nómina`,
          time: 'Hace 1 día'
        })
      }

      if (stats.value.totalExposiciones > 0) {
        activities.push({
          id: 3,
          icon: '🎭',
          title: 'Exposiciones en Curso',
          description: `${stats.value.totalExposiciones} exposiciones actualmente abiertas`,
          time: 'Hace 3 días'
        })
      }

      recentActivity.value = activities.slice(0, 3) // Mostrar máximo 3 actividades
    }

    // Métodos de navegación
    const navigateToArtistas = () => {
      router.push('/artistas')
    }

    const navigateToOrganigrama = () => {
      router.push('/organigrama')
    }

    const navigateToEmpleados = () => {
      router.push('/empleados')
    }

    const navigateToEstructura = () => {
      router.push('/reporte-estructura')
    }

    onMounted(() => {
      fetchStats()
    })

    return {
      loading,
      stats,
      recentActivity,
      navigateToArtistas,
      navigateToOrganigrama,
      navigateToEmpleados,
      navigateToEstructura
    }
  }
}
</script>

<style scoped>
.home-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 0;
}

.hero-section {
  padding: 4rem 2rem 6rem 2rem;
  text-align: center;
  color: white;
}

.hero-content {
  max-width: 1200px;
  margin: 0 auto;
}

.hero-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  background: linear-gradient(135deg, #ffffff 0%, #f1f5f9 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 1.3rem;
  margin-bottom: 3rem;
  opacity: 0.9;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.stat-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 16px;
  padding: 2rem;
  text-align: center;
  transition: all 0.3s ease;
}

.stat-card:hover {
  transform: translateY(-8px);
  background: rgba(255, 255, 255, 0.15);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
}

.stat-icon {
  font-size: 2.5rem;
  margin-bottom: 1rem;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
}

.stat-number {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  color: #fbbf24;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.stat-label {
  font-size: 0.9rem;
  opacity: 0.9;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: 500;
}

.features-section, .quick-actions-section, .recent-activity-section {
  background: var(--gray-100);
  padding: 4rem 2rem;
}

.section-title {
  text-align: center;
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--gray-800);
  margin-bottom: 3rem;
  position: relative;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: -1rem;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 4px;
  background: linear-gradient(90deg, var(--primary-color) 0%, #8b5cf6 100%);
  border-radius: 2px;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.feature-card {
  background: white;
  border-radius: 20px;
  padding: 2.5rem;
  box-shadow: var(--shadow-lg);
  transition: all 0.3s ease;
  text-decoration: none;
  color: inherit;
  position: relative;
  overflow: hidden;
  border: 1px solid var(--gray-200);
}

.feature-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.1), transparent);
  transition: left 0.5s ease;
}

.feature-card:hover::before {
  left: 100%;
}

.feature-card:hover {
  transform: translateY(-8px);
  box-shadow: var(--shadow-xl);
  border-color: var(--primary-color);
}

.feature-icon {
  font-size: 3rem;
  margin-bottom: 1.5rem;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

.feature-card h3 {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--gray-800);
  margin-bottom: 1rem;
}

.feature-card p {
  color: var(--gray-600);
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.feature-arrow {
  position: absolute;
  bottom: 1.5rem;
  right: 1.5rem;
  font-size: 1.5rem;
  color: var(--primary-color);
  transition: transform 0.3s ease;
}

.feature-card:hover .feature-arrow {
  transform: translateX(5px);
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  max-width: 1000px;
  margin: 0 auto;
}

.action-card {
  background: white;
  border-radius: 16px;
  padding: 2rem;
  text-align: center;
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;
  cursor: pointer;
  border: 1px solid var(--gray-200);
}

.action-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: var(--primary-color);
}

.action-icon {
  font-size: 2.5rem;
  margin-bottom: 1rem;
  color: var(--primary-color);
}

.action-card h4 {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--gray-800);
  margin-bottom: 0.5rem;
}

.action-card p {
  color: var(--gray-600);
  font-size: 0.9rem;
}

/* Recent Activity Section */
.recent-activity-section {
  background: white;
}

.activity-card {
  max-width: 800px;
  margin: 0 auto;
  background: var(--gray-50);
  border-radius: 16px;
  padding: 2rem;
  box-shadow: var(--shadow-md);
}

.activity-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.activity-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.5rem;
  background: white;
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--gray-200);
}

.activity-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.activity-content {
  flex: 1;
}

.activity-content h4 {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--gray-800);
  margin-bottom: 0.5rem;
}

.activity-content p {
  color: var(--gray-600);
  margin-bottom: 0.5rem;
}

.activity-time {
  font-size: 0.8rem;
  color: var(--gray-500);
}

/* Responsive */
@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-subtitle {
    font-size: 1.1rem;
  }
  
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
  }
  
  .features-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .feature-card {
    padding: 2rem;
  }
  
  .hero-section {
    padding: 3rem 1rem 4rem 1rem;
  }
  
  .features-section, .quick-actions-section, .recent-activity-section {
    padding: 3rem 1rem;
  }
  
  .actions-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .actions-grid {
    grid-template-columns: 1fr;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
  }
}
</style> 