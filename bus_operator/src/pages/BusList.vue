<template>
    <div class="box">
        <p>Showing <strong>{{listOfBuses.length}}</strong> Buses Operated by <strong>{{operatorName}}</strong></p>
        <div class="box" v-for="bus in listOfBuses" v-bind:key="bus.id">
        <article class="columns">
            <div class="column">
                <p><strong>{{bus.busName}}</strong></p>    
            </div>
            <div class="column">
                <p><strong>{{bus.deptTime +"   "+ bus.arvlTime}}</strong></p>
            </div>
            <div class="column">
                <button @click="deleteBus" class="button is-danger"><strong>Remove</strong></button>
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
    created:function(){
        let obj = JSON.parse(this.$route.params.busDetails);
        this.source = obj.source;
        this.destination = obj.destination;
        this.dateOfJourney = obj.dateOfJourney;
        //call searchBus
    },
    data:function(){
        return {
            operatorUsername:"",
            operatorName:"SRS Travels",
            listOfBuses:[
                {
                    id:1,
                    busName:"Scania Multi-Axle",
                    from:"bang",
                    to:"mys",
                    pickUp:"Majestic",
                    drop:"JP Nagar",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    capacity:"",
                    type:"NON-AC SLEEPER",
                    runningDays:"",
                    price:"970"
                },
                {
                    id:1,
                    busName:"Volvo B-25",
                    from:"bang",
                    to:"mys",
                    pickUp:"Majestic",
                    drop:"JP Nagar",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    capacity:"",
                    type:"NON-AC SLEEPER",
                    runningDays:"",
                    price:"1070"
                }
            ]
        }
    },
    methods:{
        searchOperatorBus:function(){
            //window.console.log('modified search');
        },
        deleteBus:function(){

        },
        addBus:function(){
            this.$router.push({name:'addbus',params:{operatorName:this.$route.params.operatorName}});
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