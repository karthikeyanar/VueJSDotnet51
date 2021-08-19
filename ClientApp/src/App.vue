<template>
  <login v-if="!isLoggedIn && !isRegister"></login>
  <register v-if="isRegister"></register>
  <nav-menu v-if="isLoggedIn"></nav-menu>
  <router-view v-if="isLoggedIn"></router-view>
</template>

<script>
import NavMenu from '@/components/NavMenu.vue';
import Login from '@/components/Login.vue';
import Register from '@/components/Register.vue';
import { mapActions } from "vuex";
export default {
  name: 'App',
  data() {
      return {
          isRegister: false
      }
  },
  components: {
      NavMenu,
      Login,
      Register
  },
  computed: {
      isLoggedIn: function() {
          return this.$store.getters.isAuthenticated;
      }, 
  },
  methods: {
    ...mapActions(["GetUser"]),
  },
  async mounted() {             
         console.log('mounted!');
       await this.GetUser();   
       var isAuth = this.$store.getters.isAuthenticated;
       console.log('isAuth=',isAuth);
      // if(isAuth==false){
         //this.$router.push('/Login');
      // }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
