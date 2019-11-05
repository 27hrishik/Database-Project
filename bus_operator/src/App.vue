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
      <router-link class="navbar-item" to='/'>Home</router-link>
      <router-link class="navbar-item" to='/about'>About</router-link>
      <router-link class="navbar-item" to='/contact'>Contact Us</router-link>
    </div>

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <div class="navbar-item has-dropdown" v-bind:class="{'is-hoverable':isLoggedIn}">
        <a v-bind:class="{'navbar-link':isLoggedIn,'button is-primary':!isLoggedIn}" @click="showLoginPage">
          {{isLoggedIn?loggedOperatorUsername:"Log In"}}
        </a>
        <div class="navbar-dropdown">
          <a class="navbar-item" @click="goToBuses">
           Buses
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
          <input class="input" type="text" v-model="loginDetails.operatorUsername" placeholder="Operator Username">
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
          <input class="input" type="password" v-model="loginDetails.password" placeholder="Password">
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
            Don't Have an Operator Account
        </span> 
        <button class="button is-text" @click="goToCreateOperatorAccount">
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
    loggedOperatorUsername : "default",
    loginDetails:{
      operatorUsername:"",
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
     window.Axios.get('/operator/login',{
            params:this.loginDetails
      })
      .then((response)=>{
        this.isLoggedIn = true;
        this.isLoginWindow = false;
        this.loggedOperatorUsername = response.data.operatorUsername;
        this.loginDetails = {operatorUsername:"",password:""};
        this.$router.push({name:'buses',params:{operatorName:this.loggedOperatorUsername}});
        window.console.log(response.data);
      })
      .catch((error)=>{
          this.loginDetails = {operatorUsername:"",password:""};
          window.alert(error.response.data);
      });
    },
    performLogOut:function(){
      this.isLoggedIn = false;
      this.loggedUsername = "default"
      this.$router.replace({name:'home'});
    },
    goToBuses:function(){
      this.$router.push({name:'buses',params:{operatorName:this.loggedOperatorUsername}});
    },
    accountDetail:function(){
      this.$router.push({name:'account',params:{operatorName:this.loggedOperatorUsername}});
    },
    goToCreateOperatorAccount:function(){
      this.$router.push({name:'operator'});
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
  margin-top: 10px;
}
</style>
