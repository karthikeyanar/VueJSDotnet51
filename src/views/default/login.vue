<template>
  <div>
    <h1>{{title}}</h1>
  </div>
</template>

<script>
import store from '../../store';
export default {
  name: "Login",
  data() {
    return {
      title: "Login",
    };
  },
  created: function () {
    //this.$root.isNotCheckUser = true;
    console.log('store=',store.user);
  },
  methods: {
  },
};
</script>

<style scoped>
</style>
