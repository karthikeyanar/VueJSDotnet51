// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import { createApp } from 'vue';

import 'jquery';
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import './assets/datepicker/bootstrap-datepicker.standalone.min.css';
import './assets/datepicker/bootstrap-datepicker.min';

import './assets/ajaxcombobox/jquery-ui.min.css';
import './assets/ajaxcombobox/jquery-ui.structure.min.css';
import './assets/ajaxcombobox/jquery-ui.theme.min.css';
import './assets/ajaxcombobox/jquery-ui.min.js';
import './assets/ajaxcombobox/ajaxcombobox';
import './assets/select2/select2.css';
import './assets/select2/select2.js';
import './assets/font-awesome/css/font-awesome.css';

import store from './store';
import App from './App'
import router from './router'
import myMixin from "@/common/mixin";
import pagination from "@/common/pagination.vue"; 
import datepicker from "@/components/datepicker";
import select2 from "@/components/select2";
//Vue.config.productionTip = false
 
// new Vue({
//   el: '#app',
//   router,
//   components: { App },
//   template: '<App/>'
// })
var app = createApp(App);
app.component('pagination',pagination); 
app.component('datepicker', datepicker); 
app.component('select2', select2);
app.mixin(myMixin).use(router).use(store).mount('#app')


