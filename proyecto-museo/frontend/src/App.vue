<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="app-layout">
    <header class="sidebar">
      <h1>Museo</h1>
      <nav>
        <RouterLink to="/">Inicio</RouterLink>
        <RouterLink to="/artistas">Artistas</RouterLink>
      </nav>
    </header>

    <main class="content">
      <RouterView />
    </main>
  </div>
</template>

<style>
/* Estilos globales para resetear */
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
}
</style>

<style scoped>
.app-layout {
  display: flex;
  height: 100vh;
}

.sidebar {
  width: 250px;
  background-color: #2c3e50;
  color: white;
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
}

.sidebar h1 {
  margin: 0 0 2rem 0;
  text-align: center;
}

.sidebar nav {
  display: flex;
  flex-direction: column;
}

.sidebar nav a {
  color: #bdc3c7;
  text-decoration: none;
  padding: 0.75rem 1rem;
  margin-bottom: 0.5rem;
  border-radius: 4px;
  transition: background-color 0.2s, color 0.2s;
}

.sidebar nav a:hover,
.sidebar nav a.router-link-exact-active {
  background-color: #34495e;
  color: white;
}

.content {
  flex: 1;
  padding: 2rem;
  overflow-y: auto;
  background-color: #f4f6f9;
}
</style> 