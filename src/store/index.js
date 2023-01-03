import { reactive } from "vue";

const store = {
  debug: true,

  state: reactive({
    user: null,
    loading:false
  }),

  setUser(newValue) {
    if (this.debug) {
      console.log('setUser triggered with', newValue)
    }

    this.state.user = newValue
  },

  clearUser() {
    if (this.debug) {
      console.log('clearUser triggered')
    }

    this.state.user = null;
  }
}

export default store;