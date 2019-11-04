<template>
    <div>
        <div >
            <div >
                <input class="input" v-model="source" type="text" placeholder="From*" >
                <input class="input" v-model="destination" type="text" placeholder="To*" >
                <input class="input" v-model="dateOfJourney" type="date" placeholder="Date of Journey">
                <button class="button is-success" type="submit" @click="searchBus">Modify</button>
            </div>    
        </div>
        <p>Showing <strong>{{listOfBuses.length}}</strong> Buses from <strong>{{source}}</strong> to <strong>{{destination}}</strong></p>
        <div class="buslist" v-for="bus in listOfBuses" v-bind:key="bus.id">
        <BusCard @bus-selected="busSelected" v-bind:id="bus.id" v-bind:busName="bus.busName" v-bind:arvlTime="bus.arvlTime" v-bind:deptTime="bus.deptTime" v-bind:price="bus.price"></BusCard>    
        </div>  
        <div class="modal" v-bind:class="{'is-active':selectSeat}">
        <div class="modal-background"></div>
        <div class="modal-content box">
        <!-- Any other Bulma elements you want -->
        <h1><b>Select Seat</b></h1>
        <SeatGrid :rows="10" :columns="4" v-bind:selectedSeats="selectedSeats" v-bind:bookedSeats="bookedSeats" @seat-selected="addToSelectedSeats"></SeatGrid>
        <hr>
        <button class="button is-info" type="submit" :disabled="selectedSeats<1" @click="bookTicket">Book Seats ({{selectedSeats.length}})</button>
        <button class="button is-danger" type="submit" @click="seatDeselect">Cancel</button> 
        </div>
        <button class="modal-close is-large" @click="seatDeselect" aria-p="close"></button>
        </div>  
    </div>   
</template>

<script>
import BusCard from '../components/BusCard.vue'
import SeatGrid from '../components/SeatGrid.vue'
export default {
    name:"searchedbuslist",
    components:{
        BusCard,
        SeatGrid
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
            source:"",
            destination:"",
            dateOfJourney:"",
            selectSeat:false,
            selectedBus:Number,
            selectedSeats:[],
            bookedSeats:["A3","C2","C3"],
            listOfBuses:[
                {
                    id:1,
                    busName:"SRS",
                    pickUp:"Majestic",
                    drop:"JP Nagar",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    type:"NON-AC SLEEPER",
                    price:"970"
                },
                {
                    id:2,
                    busName:"ORANGE",
                    pickUp:"KR Puram",
                    drop:"Electronic City",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    type:"AC SLEEPER",
                    price:"1350"
                }
            ]
        }
    },
    methods:{
        searchBus:function(){
            //window.console.log('modified search');
        },
        busSelected:function(id){
            //window.console.log('Bus selected '+id);
            this.selectedBus = id;
            this.selectSeat = true;
        },
        seatDeselect:function(){
            this.selectedSeats = [];
            this.selectSeat = false;
        },
        bookTicket:function(){
            //window.console.log(`selected ${this.selectedSeats} are booked`);
            this.selectSeat = false;
            this.$router.push({name:'ticket',params:{busDetails:this.$route.params.busDetails,ticketDetails:'default'}});
        },
        addToSelectedSeats(e){
            let index = this.selectedSeats.indexOf(e) 
            if(index ==-1)
                this.selectedSeats.push(e);
            else
                this.selectedSeats.splice(index,1);    
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