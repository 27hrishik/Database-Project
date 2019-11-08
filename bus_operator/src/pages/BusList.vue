<template>
    <div class="box">
        <p>Showing <strong>{{listOfBuses.length}}</strong> Buses Operated by <strong>{{operatorName}}</strong></p>
        <hr>
        <article class="columns">
            <div class="column">
                <p><strong>Bus Name</strong></p>    
            </div>
            <div class="column">
                <p><strong>Type</strong></p>    
            </div>
            <div class="column">
                <p><strong>From</strong></p>
            </div>
            <div class="column">
                <p><strong>To</strong></p>
            </div>
            <div class="column">
                <p><strong>Capacity</strong></p>
            </div>
            <div class="column">
                <p><strong>Price</strong></p>
            </div>
             <div class="column">
                <p><strong>Update Availability</strong></p>
            </div>
            <div class="column">
                <p><strong>Remove</strong></p>
            </div>                     
            </article>
        <p v-if="listOfBuses.length==0"><strong>No Buses Found</strong></p>    
        <div class="box" v-for="bus in listOfBuses" v-bind:key="bus.id">
        <article class="columns">
            <div class="column">
                <p><strong>{{bus.busName}}</strong></p>    
            </div>
            <div class="column">
                <p><strong>{{bus.type}}</strong></p>    
            </div>
            <div class="column">
                <p><strong>{{bus.from +" - "+ bus.deptTime}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{bus.to +" - "+ bus.arvlTime}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{bus.capacity}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{bus.price}}</strong></p>
            </div>
            <div class="column">
                <button @click="updateAvailability" :value='bus.id' class="button is-info"><strong>Update</strong></button>
            </div>
            <div class="column">
                <button @click="deleteBus" :value='bus.id' class="button is-danger"><strong>Remove</strong></button>
            </div>                     
            </article>    
        </div>
        <button @click="addBus" class="button is-success"><strong>Add Bus</strong></button>  
    </div>   
</template>

<script>
export default {
    name:"buslist",
    components:{
    },
    mounted:function(){
        this.getOperatorBus();
        //call searchBus
    },
    data:function(){
        return {
            operatorUsername:this.$route.params.operatorName,
            operatorName:"",
            listOfBuses:[
                {
                    id:1,
                    busName:"Scania Multi-Axle",
                    from:"bang",
                    to:"mys",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    capacity:"",
                    type:"NON-AC SLEEPER",
                    price:"970"
                },
                {
                    id:2,
                    busName:"Volvo B-25",
                    from:"bang",
                    to:"mys",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    capacity:"",
                    type:"NON-AC SLEEPER",
                    price:"1070"
                }
            ]
        }
    },
    methods:{
        getOperatorBus:function(){
            //window.console.log('modified search');
            window.Axios.get('/operator/buses',{params:{operatorUsername:this.operatorUsername}})
            .then((response)=>{
                this.operatorName = response.data.operatorName;
                this.listOfBuses = response.data.listOfBuses;
                window.console.log(response.data);
            })
            .catch((error)=>{
                window.alert(error.response.data);
            });  
        },
        deleteBus:function(){
            window.Axios.delete('/operator/buses',{params:{id:event.currentTarget.value}})
            .then((response)=>{
                window.alert(response.data);
                this.getOperatorBus();
            })
            .catch((error)=>{
                window.alert(error.response.data);
            });
        },
        addBus:function(){
            this.$router.push({name:'addbus',params:{operatorName:this.$route.params.operatorName}});
        },
        updateAvailability:function(){
            window.Axios.post('/operator/buses/availability',{id:event.currentTarget.value})
            .then((response)=>{
                window.alert(response.data);
            })
            .catch((error)=>{
                window.alert(error.response.data);
            });
        }
    }
}
</script>

<style scoped>
.modal-content{
    text-align: center;
}
.input{
    width: 20%;
}
</style>