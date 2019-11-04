<template>
    <div class="box">
        <h1><strong>Add New Bus</strong></h1>
        <div class="box">
            <h2><strong>Travel Details</strong></h2>
            <div class="field">
            <label class="label">Bus Name</label>
            <div class="control">
                <input class="input" type="text" v-model="busName" placeholder="e.g Volvo BX-15">
            </div>
            </div>
            <div class="field">
            <label class="label">From</label>
            <div class="control">
                <input class="input" type="text" v-model="from" placeholder="e.g ax123#ads">
            </div>
            </div>
            <div class="field">
            <label class="label">To</label>
            <div class="control">
                <input class="input" type="text" v-model="to" placeholder="e.g ax123#ads">
            </div>
            </div>
            <div class="field">
            <label class="label">Pick Up</label>
            <div class="control">
                <input class="input" type="text" v-model="pickup" placeholder="e.g ax123#ads">
            </div>
            </div>
            <div class="field">
            <label class="label">Drop</label>
            <div class="control">
                <input class="input" type="text" v-model="drop" placeholder="e.g ax123#ads">
            </div>
            </div>
            <div class="field">
            <label class="label">Departure Time</label>
            <div class="control">
                <input class="input" type="time" v-model="deptTime" placeholder="e.g ax123#ads">
            </div>
            </div>
            <div class="field">
            <label class="label">Arrival Time</label>
            <div class="control">
                <input class="input" type="time" v-model="arvlTime" placeholder="e.g ax123#ads">
            </div>
            </div>
        </div>
        <div class="box">
            <h2><strong>General</strong></h2>
            <div class="field">
            <label class="label">Type</label>
            <div class="control">
                <input class="input" type="text" v-model="type" placeholder="e.g Alex Smith">
            </div>
            </div>
            <div class="field">
            <label class="label">Cost</label>
            <div class="control">
                <input class="input" type="text" v-model="cost" placeholder="e.g ax123#ads">
            </div>
            </div>
            <div class="field">
            <label class="label">Capacity</label>
            <div class="control">
                <input class="input" type="text" v-model="capacity" placeholder="e.g alex.smith@gmail.com">
            </div>
            </div>
            <div class="field">
            <label class="label">Running Days</label>
            <label class="checkbox">
            <input type="checkbox">
            Monday
            </label>
            <label class="checkbox">
            <input type="checkbox">
            Tuesday
            </label>
            <label class="checkbox">
            <input type="checkbox">
            Wednesday
            </label>
            <label class="checkbox">
            <input type="checkbox">
            Thrusday
            </label>
            <label class="checkbox">
            <input type="checkbox">
            Friday
            </label>
            <label class="checkbox">
            <input type="checkbox">
            Saturday
            </label>
            <label class="checkbox">
            <input type="checkbox">
            Sunday
            </label>
            </div>
            <p class="control">
            <button class="button is-success" @click="createAccount">
                Add Bus
            </button>
            <button class="button is-danger" @click="goToHome">
                Cancel
            </button>
            </p>
        </div>
    </div>
</template>

<script>
export default {
    name:'',
    data:function(){
        return{
            busDetails:{
            busName:'',
            from:"",
            to:"",
            pickup:"",
            drop:"",
            deptTime:"",
            arvlTime:"",
            type:"",
            cost:"",
            capacity:""
            }
        }
    },
    methods:{
        createAccount:function(){
            window.Axios.post('/user',{
              updatedObj:this.updated
            })
            .then((response)=>{
                window.console.log(response.data);
            })
            .catch((error)=>{
                window.console.log(error);
            })
            .finally(()=>{
            });     
        },
        goToHome:function(){
           this.$router.push({name:'home'}); 
        }
    }
}
</script>

<style scoped>
.input{
    width: 20%;
}
</style>