<template>
<div class="row justify-content-center">
    <div class="col-4">
        <form @submit.prevent="submitForm" class="px-4 py-3">
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="text" id="Username" ref="Username" placeholder="Email" v-model="Username" class="form-control" :class="{'is-invalid':!userNameIsValid}">
                <div class="invalid-feedback">Email is required</div>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" id="Password" placeholder="Password" v-model="Password" class="form-control" :class="{'is-invalid':!userNameIsValid}">
                <div class="invalid-feedback">Password is required</div>
            </div>
            <div class="mb-3">
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="RememberMe" name="RememberMe" v-model="RememberMe" true-value="true" false-value="false">
                    <label class="form-check-label" for="dropdownCheck">
                        Remember me
                    </label>
                </div>
            </div>
            <div class="alert alert-danger" role="alert" v-if="Errors && Errors.length>0">
                <span v-for="item in Errors" v-bind:key="item">
                    {{item}}
                </span>
            </div>
            <button type="submit" class="btn btn-primary me-2" :disabled="IsLoading">
                Sign in
            </button>
            <!--<a href="javascript:;" @click="changeRegister" class="btn btn-danger ms-2">
                Register
            </a>-->
        </form>
    </div>
</div>
</template>

<script>
import {
    mapActions
} from "vuex";
import $ from "jquery";
export default {
    name: 'Login',
    data() {
        return {
            Username: '',
            Password: '',
            RememberMe: true,
            IsSubmitted: false,
            Errors: null,
            IsLoading: false
        }
    },
    computed: {
        userNameIsValid() {
            if (this.IsSubmitted == true)
                return !!this.Username;
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
    mounted() {             
        this.$refs.Username.focus();
  },
    methods: {
        ...mapActions(["LogIn", "GetUser"]),
        async submitForm() {
            this.IsSubmitted = true;
            const userNameIsValid = !!this.Username;
            const passwordIsValid = !!this.Password;
            const formIsValid = userNameIsValid && passwordIsValid;
            if (formIsValid) {
                console.log('form is valid');
                var reqData = {
                    "Username": this.Username,
                    "Password": this.Password,
                    "RememberMe": this.RememberMe
                };

                this.IsLoading = true;
                this.Errors = [];
                await this.LogIn($.param(reqData));
                await this.GetUser();
                this.IsLoading = false;
                if (this.$store.getters.Error != '') {
                    this.Errors.push(this.$store.getters.Error);
                }
                console.log('StateUser=', this.$store.getters.User);
            } else {
                console.log('form is invalid');
            }
        }
        ,changeRegister() {
                this.$parent.isRegister = true;
            }
    }
}
</script>

<style scoped>
</style>
