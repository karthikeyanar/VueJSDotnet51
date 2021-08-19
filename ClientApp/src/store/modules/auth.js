import axios from 'axios';
import helper from '@/common/helper';

const state = {
    user: null,
    error: ''
};

const getters = {
    isAuthenticated: (state) => !!state.user,
    User: (state) => state.user,
    Error: (state) => state.error,
};

const actions = {
    
    async LogIn({ commit }, data) {
       
        await axios({
                method: 'post',
                url: '/api/Auth/Login',
                withCredentials: true,
                crossdomain: true,
                data: data,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                    'Cache-Control': 'no-cache'
                }
            }).then((response) => {
                console.log('response=', response.data);
                localStorage.setItem('token',response.data.token);
                localStorage.setItem('type',response.data.type);
                commit("setError", "");
                //commit("setToken", response.data.token);
                //commit("setToken", response.data.type);
                //console.log('this.$store.token=',that.$store.token);
                //axios.defaults.headers.common['Authorization'] = response.data.type + ' ' + response.data.token;
            })
            .catch((error) => {
                console.log('error=', error);
                if (error.response) {
                    commit("setError", error.response.data.message);
                }
            });
             
    },

    async GetUser({ commit }) {
        await helper.ajax({
            url: 'api/Account/User',
            onUnAuthorized: function () {
                console.log('onUnAuthorized');
                 //window.location.href = '/login';
            },
            onSuccess: function (result) {
                console.log('result=',result);
                commit("setUser", result);
            },
            onError: function (error) {
                commit("setUser", null);
                console.log('error=', error);
            }
        }); 
    },

    async LogOut({ commit }) {
        console.log('logout true');
        localStorage.setItem('token','');
        localStorage.setItem('type','');
        commit("logout");
    },
};

const mutations = {
    setUser(state, data) {
        state.user = data;
    }, 
    setError(state, data) {
        state.error = data;
    },
    logout(state) {
        state.user = null;
        state.error = '';
    },
};

export default {
    state,
    getters,
    actions,
    mutations,
};