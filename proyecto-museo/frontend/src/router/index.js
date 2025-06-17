import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/artistas',
      name: 'artistas',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/ArtistasView.vue')
    },
    {
      path: '/organigrama',
      name: 'organigrama',
      component: () => import('../views/OrganigramaView.vue')
    },
    {
      path: '/estructura',
      name: 'estructura',
      component: () => import('../views/EstructuraFisica.vue')
    },
    {
      path: '/reporte-estructura',
      name: 'reporte-estructura',
      component: () => import('../views/ReporteEstructuraFisica.vue')
    },
    {
      path: '/ficha-museo',
      name: 'ficha-museo',
      component: () => import('../views/FichaMuseoView.vue')
    },
    {
      path: '/empleados',
      name: 'empleados',
      component: ()=> import('../views/EmpleadosView.vue')
    },
    {
      path: '/exposiciones',
      name: 'exposiciones',
      component: () => import('../views/ExposicionEventoView.vue')
    },
    {
      path: '/programa-mantenimiento',
      name: 'programa-mantenimiento',
      component: () => import('../views/ProgramaMantenimientoView.vue')
    },
    {
      path: '/test-procedures',
      name: 'test-procedures',
      component: () => import('../views/TestProceduresView.vue')
    }
  ]
})

export default router 