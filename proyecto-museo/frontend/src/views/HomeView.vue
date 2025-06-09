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
            <div class="stat-number">1,247</div>
            <div class="stat-label">Obras Registradas</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-number">89</div>
            <div class="stat-label">Empleados Activos</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon">🏢</div>
            <div class="stat-number">5</div>
            <div class="stat-label">Museos Registrados</div>
          </div>
          <div class="stat-card">
            <div class="stat-icon">📊</div>
            <div class="stat-number">342</div>
            <div class="stat-label">Reportes Generados</div>
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

        <div class="feature-card coming-soon">
          <div class="feature-icon">🖼️</div>
          <h3>Gestión de Obras</h3>
          <p>Control exhaustivo de colecciones, movimientos de obras, estado de conservación y ubicaciones.</p>
          <div class="coming-soon-badge">Próximamente</div>
        </div>

        <div class="feature-card coming-soon">
          <div class="feature-icon">🎪</div>
          <h3>Exposiciones y Eventos</h3>
          <p>Planificación y gestión de exposiciones temporales, eventos culturales y actividades educativas.</p>
          <div class="coming-soon-badge">Próximamente</div>
        </div>

        <div class="feature-card coming-soon">
          <div class="feature-icon">💰</div>
          <h3>Control Financiero</h3>
          <p>Seguimiento de ingresos por tickets, gastos operativos y análisis financiero detallado.</p>
          <div class="coming-soon-badge">Próximamente</div>
        </div>

        <div class="feature-card coming-soon">
          <div class="feature-icon">📈</div>
          <h3>Reportes y Analytics</h3>
          <p>Generación de reportes avanzados, métricas de desempeño y análisis de datos operativos.</p>
          <div class="coming-soon-badge">Próximamente</div>
        </div>
      </div>
    </section>

    <!-- Quick Actions Section -->
    <section class="quick-actions-section">
      <h2 class="section-title">Acciones Rápidas</h2>
      <div class="actions-grid">
        <div class="action-card">
          <div class="action-icon">➕</div>
          <h4>Nuevo Artista</h4>
          <p>Registrar un nuevo artista en el sistema</p>
        </div>
        <div class="action-card">
          <div class="action-icon">📋</div>
          <h4>Ver Organigrama</h4>
          <p>Consultar la estructura organizacional</p>
        </div>
        <div class="action-card">
          <div class="action-icon">📊</div>
          <h4>Generar Reporte</h4>
          <p>Crear reportes de gestión y control</p>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'HomeView'
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

.features-section, .quick-actions-section {
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

.feature-card.coming-soon {
  opacity: 0.7;
  pointer-events: none;
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

.coming-soon-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: linear-gradient(135deg, var(--warning-color) 0%, #f97316 100%);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 15px;
  font-size: 0.8rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.actions-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  max-width: 800px;
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
  
  .features-section, .quick-actions-section {
    padding: 3rem 1rem;
  }
}
</style> 