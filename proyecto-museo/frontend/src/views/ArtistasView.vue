<script setup>
import FormularioArtista from '../components/FormularioArtista.vue'
</script>

<template>
  <div class="artistas-view">
    <h2>Gestión de Artistas</h2>
    <p>Utilice este formulario para añadir nuevos artistas a la base de datos.</p>
    <FormularioArtista />
  </div>
</template>

<style scoped>
.artistas-view {
  max-width: 600px;
}
.artistas-view h2 {
    margin-bottom: 0.5rem;
}
.artistas-view p {
    margin-bottom: 2rem;
}
</style> 