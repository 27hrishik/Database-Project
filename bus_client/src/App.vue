<template>
  <div id="app">
    <!-- NAV BAR-->
  <nav class="navbar" role="navigation" aria-p="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" >
      <img src="https://image.freepik.com/free-vector/bus-logo-abstract_7315-17.jpg" alt="BusYatri">
    </a>
    <a role="button" class="navbar-burger burger" aria-p="menu" aria-expanded="false" data-target="navbarMenu">
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
      <span aria-hidden="true"></span>
    </a>
  </div>

  <div id="navbarMenu" class="navbar-menu is-active">
    <div class="navbar-start">
      <router-link class="navbar-item" to="/">Home</router-link>
      <router-link class="navbar-item" to='/about'>About</router-link>
      <router-link class="navbar-item" to='/contact'>Contact Us</router-link>
    </div>

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <div class="navbar-item has-dropdown" v-bind:class="{'is-hoverable':isLoggedIn}">
        <a v-bind:class="{'navbar-link':isLoggedIn,'button is-primary':!isLoggedIn}" @click="showLoginPage">
          {{isLoggedIn?loggedUsername:"Log In"}}
        </a>
        <div class="navbar-dropdown">
          <a class="navbar-item" @click="goToBooking">
           Bookings
          </a>
          <a class="navbar-item" @click="accountDetail">
            Account
          </a>
          <hr class="navbar-divider">
          <a class="navbar-item" @click="performLogOut">
            Log Out
          </a>
        </div>
      </div>
        </div>
      </div>
    </div>
  </div>
</nav>
    <!--User Modal-->
    <div class="modal" v-bind:class="{'is-active':isLoginWindow}">
    <div class="modal-background"></div>
    <div class="modal-content box">
      <!-- Any other Bulma elements you want -->
      <h1><b>Log In</b></h1>
      <div class="field">
        <p class="control has-icons-left has-icons-right">
          <input class="input" style="width:100%" v-model="loginDetails.username" type="text" placeholder="Username">
          <span class="icon is-small is-left">
            <i class="fas fa-user"></i>
          </span>
          <span class="icon is-small is-right">
            <i class="fas fa-check"></i>
          </span>
        </p>
      </div>
      <div class="field">
        <p class="control has-icons-left">
          <input class="input" style="width:100%" v-model="loginDetails.password" type="password" placeholder="Password">
          <span class="icon is-small is-left">
            <i class="fas fa-lock"></i>
          </span>
        </p>
      </div>
      <div class="field">
        <p class="control">
          <button class="button is-success" @click="performLogin">
            Login
          </button>
        </p>
      </div>
      <div class="box">
        <span disabled class="button is-text">
            Don't Have an Account
        </span> 
        <button class="button is-text" @click="goToCreateAccount">
            Click Here
        </button>
      </div>
    </div>
    <button class="modal-close is-large" @click="hideLoginPage" aria-p="close"></button>
    </div>
    <!-- Router Component-->
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app',
  data: function(){
  return {
    isLoginWindow : false,
    isLoggedIn : false,
    loggedUsername : "default",
    search:null,
    ticket:null,
    loginDetails:{
      username:"",
      password:""
    }
  }
  },
  methods:{
    showLoginPage:function(){
      if(this.isLoggedIn==false)
        this.isLoginWindow = true;
    },
    hideLoginPage:function(){
      this.isLoginWindow = false;
    },
    performLogin:function(){
      window.Axios.get('/user/login',{
            params:this.loginDetails
      })
      .then((response)=>{
        this.isLoggedIn = true;
        this.isLoginWindow = false;
        this.loggedUsername = response.data.username;
        this.loginDetails = {username:"",password:""};
        window.console.log(response.data);
      })
      .catch((error)=>{
          this.loginDetails = {username:"",password:""};
          window.alert(error.response.data);
      });
    },
    performLogOut:function(){
      this.isLoggedIn = false;
      this.loggedUsername = ""
      this.$router.replace({name:'home'});
    },
    goToBooking:function(){
      this.$router.push({name:'booking'});
    },
    accountDetail:function(){
      this.$router.push({name:'account'});
    },
    goToCreateAccount:function(){
        this.$router.push({name:'createAccount'});
        this.isLoginWindow = false;
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
  background-color: rgba(255, 99, 71, 0);
  margin-top: 10px;
}
.modal-content{
  background-color:white;
}
</style>
