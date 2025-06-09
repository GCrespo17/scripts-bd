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
    }
  ]
})

export default router 