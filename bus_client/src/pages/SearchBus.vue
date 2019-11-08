<template>
  <div class="searchbox">
    <div>
      <h1 > Search Bus </h1>
    </div>
    <div>
      <p>Source</p>
      <input v-model="source" class="input" type="text" placeholder="From*" >
    </div>
    <br>
    <div>
      <p>Destination</p>
      <input v-model="destination" class="input" type="text" placeholder="To*" >
    </div>
    <br>
    <div>
      <form>
        <p>Date of Journey</p>
        <input v-model="dateOfJourney" class="input" type="date" placeholder="DD MM YYYY">
      </form>
    <br>
    </div>
      <button class="button is-success" type="submit" @click="searchBuses">Search availability</button>
  </div>
</template>

<script>
export default {
  name: 'SearchBus',
  data:function(){
    return{
      source:"",
      destination:"",
      dateOfJourney:""
    }
  },
  methods:{
    searchBuses:function(){
      //window.console.log("Searching for Buses....");
      let passingObj = {
          source:this.source,
          destination:this.destination,
          dateOfJourney:this.dateOfJourney
        };
      this.$parent.search = passingObj;  
      this.$router.push({name:'buses'});
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.searchbox {
  width: 400px;
  padding: 50px;
  margin: 20px;
  border: none;
  position: absolute;
  top: 40%;
  left: 15%;
  margin-top: -50px;
  margin-left: -100px;
  background-color: #66ffcc;
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}
h1{
  text-align: center;
  font-size: 20px;
  font-weight: bold;
}
.input{
  width: 100%;
}
</style>
