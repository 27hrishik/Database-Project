<template>
    <div class="box">
        <h1><strong>Add New Bus</strong></h1>
        <div class="box">
            <h2><strong>Travel Details</strong></h2>
            <div class="field">
            <label class="label">Bus Name</label>
            <div class="control">
                <input class="input" type="text" v-model="busDetail.busName" placeholder="e.g Volvo BX-15">
            </div>
            </div>
            <div class="field">
            <label class="label">From</label>
            <div class="control">
                <input class="input" type="text" v-model="busDetail.from" placeholder="e.g Bangalore">
            </div>
            </div>
            <div class="field">
            <label class="label">To</label>
            <div class="control">
                <input class="input" type="text" v-model="busDetail.to" placeholder="e.g Mysore">
            </div>
            </div>
            <div class="field">
            <label class="label">Pick Up</label>
            <div class="control">
                <input class="input" type="text" v-model="busDetail.pickup" placeholder="e.g mara">
            </div>
            </div>
            <div class="field">
            <label class="label">Drop</label>
            <div class="control">
                <input class="input" type="text" v-model="busDetail.drop" placeholder="e.g rly stn">
            </div>
            </div>
            <div class="field">
            <label class="label">Departure Time</label>
            <div class="control">
                <input class="input" type="time" v-model="busDetail.deptTime" placeholder="e.g 07:30 PM">
            </div>
            </div>
            <div class="field">
            <label class="label">Arrival Time</label>
            <div class="control">
                <input class="input" type="time" v-model="busDetail.arvlTime" placeholder="e.g 06:45 AM">
            </div>
            </div>
        </div>
        <div class="box">
            <h2><strong>General</strong></h2>
            <div class="field">
            <label class="label">Type</label>
            <div class="control">
                <input class="input" type="text" v-model="busDetail.type" placeholder="e.g NON-AC">
            </div>
            </div>
            <div class="field">
            <label class="label">Cost</label>
            <div class="control">
                <input class="input" type="number" v-model="busDetail.cost" placeholder="e.g 900">
            </div>
            </div>
            <div class="field">
            <label class="label">Capacity</label>
            <div class="control">
                <input class="input" type="number" v-model="busDetail.capacity" placeholder="e.g 30">
            </div>
            </div>
            <div class="field">
            <label class="label">Running Days</label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.monday">
            Monday
            </label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.tuesday">
            Tuesday
            </label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.wednesday">
            Wednesday
            </label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.thursday">
            Thrusday
            </label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.friday">
            Friday
            </label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.saturday">
            Saturday
            </label>
            <label class="checkbox">
            <input type="checkbox" v-model="busDetail.sunday">
            Sunday
            </label>
            </div>
            <p class="control">
            <button class="button is-success" @click="createAccount">
                Add Bus
            </button>
            <button class="button is-danger" @click="goToBuses">
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
            busDetail:{
            busOperator:this.$route.params.operatorName,
            busName:'',
            from:"",
            to:"",
            pickup:"",
            drop:"",
            deptTime:"",
            arvlTime:"",
            type:"",
            cost:"",
            capacity:"",
            monday:false,
            tuesday:false,
            wednesday:false,
            thursday:false,
            friday:false,
            saturday:false,
            sunday:false,
            }
        }
    },
    methods:{
        createAccount:function(){
            window.Axios.post('/operator/buses',this.busDetail)
            .then((response)=>{
                window.alert(response.data);
                this.goToBuses();
            })
            .catch((error)=>{
                window.alert(error.response.data);
            });     
        },
        goToBuses:function(){
           this.$router.go(-1); 
        }
    }
}
</script>

<style scoped>
.input{
    width: 20%;
}
</style>