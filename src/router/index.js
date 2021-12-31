import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Project from '../views/Project.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/project/:id',
    name: 'Project',
    component: Project
  },
  { path: '/:pathMatch(.*)*', name: 'not-found', redirect: { name: 'Home' } }
  // {
  //   path: '*',
  //   redirect: { name: 'Home' }
  // }
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

export default router;
