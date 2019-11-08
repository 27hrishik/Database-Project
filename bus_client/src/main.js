import Vue from 'vue'
import VueRouter from 'vue-router'
import Axios from 'axios'
import App from './App.vue'
import SearchBus from './pages/SearchBus.vue'
import About from './pages/About.vue'
import Contact from './pages/Contact.vue'
import SearchedBusList from './pages/SearchedBusList.vue'
import BookTicket from './pages/BookTicket.vue'
import YourBooking from './pages/YourBooking.vue'
import AccountDetail from './pages/AccountDetail.vue'
import CreateAccount from './pages/CreateAccount.vue'

window.Axios = Axios;
Axios.defaults.baseURL = "http://127.0.0.1:3000/";
Vue.config.productionTip = false
Vue.use(VueRouter);

const routes = [
  {path:'/' , name:'home',component:SearchBus},
  {path:'/about',name:'about',component:About},
  {path:'/contact',name:'contact',component:Contact},
  {path:'/user/',name:'createAccount',component:CreateAccount},
  {path:'/buses/',name:'buses',component:SearchedBusList},
  {path:'/buses/ticket',name:'ticket',component:BookTicket},
  {path:'/user/booking',name:'booking',component:YourBooking},
  {path:'/user/account',name:'account',component:AccountDetail},
]

var router = new VueRouter({
  routes
})
let vm = new Vue({
  render: h => h(App),
  router
});
vm.$mount("#app");