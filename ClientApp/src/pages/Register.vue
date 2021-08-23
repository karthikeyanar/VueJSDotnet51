<template>
<div class="row justify-content-center">
    <div class="col-4">
        <form @submit.prevent="submitForm" class="px-4 py-3">
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="text" id="Email" placeholder="Email" v-model="Email" class="form-control" :class="{'is-invalid':!emailIsValid}">
                <div class="invalid-feedback">Email is required</div>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" id="Password" placeholder="Password" v-model="Password" class="form-control" :class="{'is-invalid':!emailIsValid}">
                <div class="invalid-feedback">Password is required</div>
            </div>
            <div class="alert alert-danger" role="alert" v-if="Errors && Errors.length>0">
                <div v-for="item in Errors" v-bind:key="item">
                    {{item}}
                </div>
            </div>
            <button type="submit" class="btn btn-primary me-2" :disabled="IsLoading">
                Submit
            </button>
            <button type="button" @click="changeLogin" class="btn btn-danger ms-2" :disabled="IsLoading">
                Cancel
            </button>
        </form>
    </div>
</div>
</template>

<script>
import axios from "axios";
import $ from "jquery";
export default {
    name: 'Register',
    data() {
        return {
            Email: '',
            Password: '',
            IsSubmitted: false,
            Errors: null,
            IsLoading: false
        }
    },
    computed: {
        emailIsValid() {
            if (this.IsSubmitted == true)
                return !!this.Email;
            else
                return true;
        },
        passwordIsValid() {
            if (this.IsSubmitted == true)
                return !!this.Password;
            else
                return true;
        }
    },
    methods: {
        async submitForm() {
            this.IsSubmitted = true;
            const emailIsValid = !!this.Email;
            const passwordIsValid = !!this.Password;
            const formIsValid = emailIsValid && passwordIsValid;
            if (formIsValid) {
                console.log('form is valid');
                var reqData = {
                    "Email": this.Email,
                    "Username": this.Email,
                    "Password": this.Password,
                    "Role": "M"
                };

                this.IsLoading = true;
                this.Errors = [];
                var data = $.param(reqData);
                await axios({
                    method: 'post',
                    url: '/api/Auth/Register',
                    withCredentials: true,
                    crossdomain: true,
                    data: data,
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                        'Cache-Control': 'no-cache'
                    }
                }).then((response) => {
                    console.log('response=', response.data); 
                })
                .catch((error) => {
                    console.log('error=', error.response.data.errors); 
                    if (error.response) {
                        this.Errors = error.response.data.errors;
                }
                });
                this.IsLoading = false;
            } else {
                console.log('form is invalid');
            }
        }
        ,changeLogin() {
                this.$parent.isRegister = false;
            }
    }
}
</script>

<style scoped>
</style>
