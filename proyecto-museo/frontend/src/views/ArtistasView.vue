<script setup>
import FormularioArtista from '../components/FormularioArtista.vue'
</script>

<template>
  <div class="artistas-container">
    <!-- Header Section -->
    <section class="page-header">
      <div class="header-content">
        <div class="header-icon">🎨</div>
        <div class="header-text">
          <h1 class="page-title">Gestión de Artistas</h1>
          <p class="page-subtitle">Registro y administración completa de artistas en el sistema</p>
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
            <h3>Registro de Nuevos Artistas</h3>
            <p>Complete el formulario con la información del artista. Los campos marcados con asterisco (*) son obligatorios.</p>
          </div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
          <div class="form-header">
            <h2>Nuevo Artista</h2>
            <p>Ingrese los datos del artista que desea registrar</p>
          </div>
          <FormularioArtista />
        </div>

        <!-- Quick Stats -->
        <div class="stats-container">
          <div class="stat-item">
            <div class="stat-icon">📈</div>
            <div class="stat-content">
              <div class="stat-number">247</div>
              <div class="stat-label">Artistas Registrados</div>
            </div>
          </div>
          <div class="stat-item">
            <div class="stat-icon">🎭</div>
            <div class="stat-content">
              <div class="stat-number">18</div>
              <div class="stat-label">Países Representados</div>
            </div>
          </div>
          <div class="stat-item">
            <div class="stat-icon">⭐</div>
            <div class="stat-content">
              <div class="stat-number">89</div>
              <div class="stat-label">Artistas Destacados</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.artistas-container {
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
  transition: all 0.3s ease;
}

.stat-item:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-xl);
  border-color: var(--primary-color);
}

.stat-icon {
  font-size: 2.5rem;
  color: var(--primary-color);
}

.stat-content {
  flex: 1;
}

.stat-number {
  font-size: 2rem;
  font-weight: 700;
  color: var(--gray-800);
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.9rem;
  color: var(--gray-600);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: 500;
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
    flex-direction: column;
    text-align: center;
    gap: 0.5rem;
  }
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }
  
  .page-title {
    font-size: 2.5rem;
  }
  
  .page-subtitle {
    font-size: 1.1rem;
  }
  
  .main-content {
    padding: 2rem 1rem;
  }
  
  .form-container {
    padding: 1.5rem;
  }
  
  .stats-container {
    flex-direction: column;
  }
  
  .stat-item {
    flex-direction: row;
    text-align: left;
  }
}

@media (max-width: 480px) {
  .page-header {
    padding: 2rem 1rem;
  }
  
  .header-icon {
    font-size: 3rem;
  }
  
  .page-title {
    font-size: 2rem;
  }
}
</style> 