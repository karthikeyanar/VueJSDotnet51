import { createWebHistory, createRouter } from "vue-router";
import store from "../store";

const routes = [{
        path: "/",
        name: "Home",
        component: () =>
            import ('@/components/Home.vue')
    },
    {
        path: "/Counter",
        name: "Counter",
        component: () =>
            import ('@/components/Counter.vue')
    },  
    {
        path: "/Users",
        name: "Users",
        component: () =>
            import ('@/components/Users.vue'),
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