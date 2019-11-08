<template>
    <div class="box">
        <h1><strong>Bookings</strong></h1>
        <hr>
        <article class="columns">
            <div class="column">
                <p><strong>Bus Name</strong></p>    
            </div>
            <div class="column">
                <p><strong>From</strong></p>
            </div>
            <div class="column">
                <p><strong>To</strong></p>
            </div>
            <div class="column">
                <p><strong>Seats Booked</strong></p>
            </div>
            <div class="column">
                <p><strong>Price</strong></p>
            </div>                   
        </article>
        <p v-if="listOfTickets.length==0"><strong>No Bookings</strong></p>    
        <div class="box" v-for="ticket in listOfTickets" v-bind:key="ticket.id">
        <article class="columns">
            <div class="column">
                <p><strong>{{ticket.busName}}</strong></p>    
            </div>
            <div class="column">
                <p><strong>{{ticket.from +" - "+ ticket.deptTime}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{ticket.to +" - "+ ticket.arvlTime}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{ticket.seatsBooked}}</strong></p>
            </div>
            <div class="column">
                <p><strong>{{ticket.price}}</strong></p>
            </div>               
        </article>    
        </div> 
    </div>
</template>

<script>
export default {
    name:'yourbooking',
    data:function(){
        return{
            listOfTickets:[]
        }
    },
    created:function(){
        window.Axios.get('/user/booking',{params:{
            username:this.$parent.loggedUsername
        }}).then((response)=>{
            this.listOfTickets = response.data.listOfTickets;
        }).catch((error)=>{
            window.alert(error.response.data);
        });
    }
}
</script>