import { createWebHistory, createRouter } from "vue-router";
import store from "../store";

const routes = [{
        path: "/",
        name: "Home",
        component: () =>
            import ('@/pages/Home.vue')
    },
    {
        path: "/Counter",
        name: "Counter",
        component: () =>
            import ('@/pages/Counter.vue')
    },  
    {
        path: "/Users",
        name: "Users",
        component: () =>
            import ('@/pages/Users.vue'),
        meta: { requiresAuth: true },
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach((to, from, next) => {
    if (to.matched.some((record) => record.meta.requiresAuth)) {
        if (store.getters.isAuthenticated) {
            next();
            return;
        }
        next("/Login");
    } else {
        next();
    }
});

export default router;