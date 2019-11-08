<template>
    <div>
        <div >
            <div >
                <input class="input" v-model="search.source" type="text" placeholder="From*" >
                <input class="input" v-model="search.destination" type="text" placeholder="To*" >
                <input class="input" v-model="search.dateOfJourney" type="date" placeholder="Date of Journey">
                <button class="button is-success" type="submit" @click="searchBus">Modify</button>
            </div>    
        </div>
        <p>Showing <strong>{{listOfBuses.length}}</strong> Buses from <strong>{{search.source}}</strong> to <strong>{{search.destination}}</strong></p>
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
                <p><strong>Seat Available</strong></p>
            </div>
            <div class="column">
                <p><strong>Price</strong></p>
            </div>
            <div class="column">
                <p><strong>Book</strong></p>
            </div>                   
        </article>
        <p v-if="listOfBuses.length==0"><strong>No Buses Found</strong></p>    
        <div class="box" v-for="bus in listOfBuses" v-bind:key="bus.id">
        <article class="columns">
            <div class="column">
                <p><strong>{{bus.operatorName+" "+bus.busName}}</strong></p>    
            </div>
            <div class="column">
                <p><strong>{{bus.type}}</strong></p>    
            </div>
            <div class="column">
                <p><strong>{{bus.pickup +" - "+ bus.deptTime}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{bus.drop +" - "+ bus.arvlTime}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{bus.seatAvailable}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{bus.price}}</strong></p>
            </div>
            <div class="column">
                <button @click="bookSelected" :value='bus.id' class="button is-info"><strong>Book</strong></button>
            </div>                 
            </article>    
        </div> 
        <div class="modal" v-bind:class="{'is-active':selectSeat}">
        <div class="modal-background"></div>
        <div class="modal-content box">
        <!-- Any other Bulma elements you want -->
        <h1><b>Select Seat</b></h1>
        <SeatGrid :rows="select.capacity/3" :columns="3" v-bind:select="select" @seat-selected="addToSelectedSeats"></SeatGrid>
        <hr>
        <button class="button is-info" type="submit" :disabled="select.selectedSeats<1" @click="bookTicket">Book Seats ({{select.selectedSeats.length}})</button>
        <button class="button is-danger" type="submit" @click="seatDeselect">Cancel</button> 
        </div>
        <button class="modal-close is-large" @click="seatDeselect" aria-p="close"></button>
        </div>  
    </div>   
</template>

<script>
import SeatGrid from '../components/SeatGrid.vue'
export default {
    name:"searchedbuslist",
    components:{
        SeatGrid
    },
    created:function(){
        let obj = this.$parent.search;
        this.search.source = obj.source;
        this.search.destination = obj.destination;
        this.search.dateOfJourney = obj.dateOfJourney;
        this.searchBus();
    },
    data:function(){
        return {
            search:{
                source:"",
                destination:"",
                dateOfJourney:""
            },
            selectSeat:false,
            selectedBus:'',
            select:{
                selectedSeats:[],
                bookedSeats:[],
                searchedDate:'',
                capacity:Number
            },
            listOfBuses:[]
        }
    },
    methods:{
        searchBus:function(){
            window.Axios.get('/user/buses',{params:this.search})
            .then((response)=>{
                this.listOfBuses = response.data.listOfBuses;
                this.select.searchedDate = response.data.date;
            }).catch((error)=>{
                window.alert(error);
            });
            this.$parent.search = this.search;
        },
        bookSelected:function(){
            if(this.$parent.isLoggedIn==true)
            {
                this.selectedBus = event.currentTarget.value;
            window.Axios.get('/user/buses/availability',{params:{
                id:event.currentTarget.value,
                date:this.select.searchedDate
            }})
            .then((response)=>{
                this.select.bookedSeats = response.data.booked;
                this.select.capacity = response.data.capacity;
                window.console.log('Booked Seats Fetched');
            }).catch((error)=>{
                window.alert(error.response.data);
            });
            this.selectSeat = true;
            }
            else
                window.alert('Log In to Book Seats');
        },
        seatDeselect:function(){
            this.select.selectedSeats = [];
            this.selectSeat = false;
        },
        bookTicket:function(){
            //window.console.log(`selected ${this.selectedSeats} are booked`);
            this.selectSeat = false;
            let obj = {
                bus:this.listOfBuses.filter((val)=>{
                    return this.selectedBus == val.id;
                }),
                dateOfJourney:this.select.searchedDate,
                seats:this.select.selectedSeats
            };
            this.$parent.ticket = obj;
            this.$router.push({name:'ticket'});
        },
        addToSelectedSeats(e){
            let index = this.select.selectedSeats.indexOf(e) 
            if(index ==-1)
                this.select.selectedSeats.push(e);
            else
                this.select.selectedSeats.splice(index,1);    
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