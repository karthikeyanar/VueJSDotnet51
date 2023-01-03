<template>
  <div id="app">
    <!-- navbar -->
    <div
      class="navbar navbar-expand-lg fixed-top bg-light"
    >
      <div class="container">
        <router-link
          to="/"
          class="navbar-brand"
        >Home</router-link>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarResponsive"
          aria-controls="navbarResponsive"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div
          class="collapse navbar-collapse"
          id="navbarResponsive"
        >
          <ul class="navbar-nav">
            <li class="nav-item">
              <router-link
                class="nav-link"
                to="/blog"
              >Blog</router-link>
            </li>
            <li class="nav-item">
              <router-link
                class="nav-link"
                to="/services"
              >Services</router-link>
            </li>
            <li class="nav-item">
              <router-link
                class="nav-link"
                to="/contact"
              >contact</router-link>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div v-if="store.state.loading" style="position: fixed;top: 3px;left: 46%;width: 100px;background: yellow;color: rgb(51, 51, 51);height: 28px;z-index: 1032;text-align: center;border-radius: 5px;line-height: 26px;">Loading...</div>
    <div class="container" style="margin-top:70px;">
      <router-view />
    </div>
  </div>
</template>

<script>
import store from './store';
import helper from "./common/helper"; 

export default {
  name: "App", 
  data() {
    return {
      user: null,
      store: store
    };
  },
  created: function () {
    console.log('store=',store.state.loading);
       //this.loadUser();
  },
  methods: {
    loadUser: function () {
      helper.ajax({
        url: "api/Account/User",
        onUnAuthorized: function () {
          console.log("onUnAuthorized");
          //window.location.href = '/login';
        },
        onSuccess: function (result) {
          this.user = result;
        },
        onError: function (error) {
          console.log("error=", error);
        },
      });
    },
  },
};
</script>

<style>
:root {
  --bs-body-font-size: 14px;
  --bs-font-sans-serif: 'Inter', sans-serif;
}
th {
  font-weight: 500;
}
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap');
</style>
