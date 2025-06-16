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
        <!-- Form Container -->
        <div class="form-container">
          <div class="form-header">
            <h2>Nuevo Artista</h2>
            <p>Ingrese los datos del artista que desea registrar</p>
          </div>
          <FormularioArtista />
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
  max-width: 800px;
  margin: 0 auto;
  display: flex;
  justify-content: center;
}

.form-container {
  width: 100%;
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

/* Responsive */
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