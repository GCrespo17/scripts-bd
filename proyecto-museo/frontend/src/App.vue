<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="app-layout">
    <header class="sidebar">
      <div class="logo-section">
        <div class="logo-icon">🏛️</div>
        <h1>Museo Digital</h1>
        <p class="logo-subtitle">Sistema de Gestión</p>
      </div>
      
      <nav>
        <RouterLink to="/" class="nav-link">
          <span class="nav-icon">🏠</span>
          <span class="nav-text">Inicio</span>
        </RouterLink>

        <RouterLink to="/organigrama" class="nav-link">
          <span class="nav-icon">📊</span>
          <span class="nav-text">Reporte Organigrama</span>
        </RouterLink>
        <RouterLink to="/reporte-estructura" class="nav-link">
          <span class="nav-icon">📊</span>
          <span class="nav-text">Reporte Estructura Física</span>
        </RouterLink>
        <RouterLink to="/ficha-museo" class="nav-link">
          <span class="nav-icon">📄</span>
          <span class="nav-text">Reporte Ficha de Museo</span>
        </RouterLink>
                <RouterLink to="/empleados" class="nav-link">
          <span class="nav-icon">👤</span>
          <span class="nav-text">Reporte Empleados</span>
        </RouterLink>
        <RouterLink to="/artistas" class="nav-link">
          <span class="nav-icon">🎨</span>
          <span class="nav-text">Formulario Artistas</span>
        </RouterLink>
        <RouterLink to="/estructura" class="nav-link">
          <span class="nav-icon">🏗️</span>
          <span class="nav-text">Formulario Estructura Física</span>
        </RouterLink>
        <RouterLink to="/exposiciones" class="nav-link">
          <span class="nav-icon">🎭</span>
          <span class="nav-text">Formulario Exposiciones</span>
        </RouterLink>
        <RouterLink to="/programa-mantenimiento" class="nav-link">
          <span class="nav-icon">🔧</span>
          <span class="nav-text">Formulario Mantenimiento</span>
        </RouterLink>
      </nav>
      
      <div class="sidebar-footer">
        <div class="version-info">
          <small>Sistema de BD</small>
          <small>v2024.2</small>
        </div>
      </div>
    </header>

    <main class="content">
      <RouterView />
    </main>
  </div>
</template>

<style>
/* Estilos globales para resetear */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: #f8fafc;
  line-height: 1.6;
}

/* Variables CSS globales */
:root {
  --primary-color: #3b82f6;
  --primary-dark: #1d4ed8;
  --secondary-color: #64748b;
  --success-color: #10b981;
  --warning-color: #f59e0b;
  --error-color: #ef4444;
  --gray-50: #f9fafb;
  --gray-100: #f3f4f6;
  --gray-200: #e5e7eb;
  --gray-300: #d1d5db;
  --gray-400: #9ca3af;
  --gray-500: #6b7280;
  --gray-600: #4b5563;
  --gray-700: #374151;
  --gray-800: #1f2937;
  --gray-900: #111827;
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}
</style>

<style scoped>
.app-layout {
  display: flex;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.sidebar {
  width: 280px;
  background: linear-gradient(145deg, #1e293b 0%, #334155 100%);
  color: white;
  padding: 0;
  display: flex;
  flex-direction: column;
  box-shadow: var(--shadow-xl);
  border-right: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
}

.logo-section {
  padding: 2rem 1.5rem;
  text-align: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  background: linear-gradient(145deg, rgba(59, 130, 246, 0.1) 0%, rgba(147, 51, 234, 0.1) 100%);
}

.logo-icon {
  font-size: 3rem;
  margin-bottom: 0.5rem;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
}

.logo-section h1 {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: 0.25rem;
  background: linear-gradient(135deg, #60a5fa 0%, #a78bfa 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.logo-subtitle {
  font-size: 0.8rem;
  color: #cbd5e1;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: 500;
}

nav {
  flex: 1;
  padding: 1.5rem 0;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 1rem;
  color: #cbd5e1;
  text-decoration: none;
  padding: 1rem 1.5rem;
  margin: 0.25rem 1rem;
  border-radius: 12px;
  transition: all 0.3s ease;
  font-weight: 500;
  position: relative;
  overflow: hidden;
}

.nav-link::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.5s ease;
}

.nav-link:hover::before {
  left: 100%;
}

.nav-link:hover {
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.2) 0%, rgba(147, 51, 234, 0.2) 100%);
  color: white;
  transform: translateX(8px);
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.nav-link.router-link-exact-active {
  background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
  transform: translateX(4px);
}

.nav-link.router-link-exact-active::after {
  content: '';
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 70%;
  background: white;
  border-radius: 2px 0 0 2px;
}

.nav-icon {
  font-size: 1.2rem;
  filter: drop-shadow(0 1px 2px rgba(0, 0, 0, 0.2));
}

.nav-text {
  font-size: 0.95rem;
}

.sidebar-footer {
  padding: 1.5rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  background: linear-gradient(145deg, rgba(0, 0, 0, 0.1) 0%, rgba(0, 0, 0, 0.2) 100%);
}

.version-info {
  text-align: center;
  color: #94a3b8;
}

.version-info small {
  display: block;
  font-size: 0.7rem;
  line-height: 1.3;
}

.content {
  flex: 1;
  overflow-y: auto;
  background: var(--gray-100);
  position: relative;
}

/* Responsive */
@media (max-width: 768px) {
  .sidebar {
    width: 100%;
    height: auto;
    flex-direction: row;
    padding: 1rem;
  }
  
  .logo-section {
    flex: 1;
    padding: 1rem;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    border-bottom: none;
  }
  
  .logo-section h1 {
    font-size: 1.2rem;
  }
  
  nav {
    flex: 2;
    display: flex;
    gap: 0.5rem;
    padding: 1rem;
  }
  
  .nav-link {
    margin: 0;
    flex-direction: column;
    gap: 0.25rem;
    padding: 0.75rem;
    text-align: center;
  }
  
  .nav-text {
    font-size: 0.8rem;
  }
  
  .sidebar-footer {
    display: none;
  }
  
  .app-layout {
    flex-direction: column;
  }
  
  .content {
    padding: 1rem;
  }
}
</style> 