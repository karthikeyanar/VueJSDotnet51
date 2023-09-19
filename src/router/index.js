import { createRouter, createWebHistory } from 'vue-router'
import store from '../store';
const templateName = 'default';


const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'homepage',
      component: () => import(`@/views/${templateName}/home`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/home',
      name: 'home',
      component: () => import(`@/views/${templateName}/home`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/login',
      name: 'login',
      component: () => import(`@/views/${templateName}/login`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/blog',
      name: 'blog',
      component: () => import(`@/views/${templateName}/blog`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/services',
      name: 'services',
      component: () => import(`@/views/${templateName}/services`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/contact',
      name: 'contact',
      component: () => import(`@/views/${templateName}/contact`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/details/:Pid',
      name: 'details',
      component: () => import(`@/views/${templateName}/details`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/list',
      name: 'list',
      component: () => import(`@/views/${templateName}/list`),
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/tickerlist',
      name: 'tickerlist',
      component: () => import(`@/views/${templateName}/tickerlist`),
      meta: {
        requiresAuth: false
      }
    }
  ]
});

// eslint-disable-next-line no-unused-vars
router.beforeEach((to, from) => {
  // console.log('beforeEach from=',from);
  // console.log('beforeEach to.meta.requiresAuth=',to.meta.requiresAuth);
  // console.log('beforeEach store.state1=',store.state.loading);
  store.state.loading = true;
  console.log('beforeEach store.state2=', store.state.loading);
  if (to.meta.requiresAuth && !store.state.user) {
    return {
      name: 'login',
    }
  }
});
router.afterEach(() => {
  // console.log('afterEach from=',from);
  // console.log('afterEach to=',to);
  store.state.loading = false;
});

export default router;