import Vue from 'vue'
import VueRouter from 'vue-router'
import Axios from 'axios'
import App from './App.vue'
import About from '../../bus_client/src/pages/About.vue'
import Contact from '../../bus_client/src/pages/Contact.vue'
import OperatorDetail from './pages/OperatorDetail.vue'
import CreateOperatorAccount from './pages/CreateOperatorAccount.vue'
import BusList from './pages/BusList.vue'
import AddBus from './pages/AddBus.vue'

window.Axios = Axios;
Axios.defaults.baseURL = "http://127.0.0.1:3000/"
Vue.config.productionTip = false
Vue.use(VueRouter);

const routes = [
  {path:'/',name:'home',component:About},
  {path:'/about',name:'about',component:About},
  {path:'/contact',name:'contact',component:Contact},
  {path:'/operator/',name:'operator',component:CreateOperatorAccount},
  {path:'/operator/:operatorName/buses',name:'buses',component:BusList},
  {path:'/operator/:operatorName/buses/add',name:'addbus',component:AddBus},
  {path:'/operator/:operatorName/account',name:'account',component:OperatorDetail},
]

var router = new VueRouter({
  routes
})
let vm = new Vue({
  render: h => h(App),
  router
});
vm.$mount("#app");
