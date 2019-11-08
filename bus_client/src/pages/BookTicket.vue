<template>
    <div class='box'>
        <h1><strong>Bus Details</strong></h1> 
        <p>
            <strong>Bus Name : </strong>{{busObj.busName}}<br>
            <strong>Bus Type : </strong>{{busObj.type}}<br>
            <strong>Date Of Journey : </strong>{{dateOfJourney}}<br>
            <strong>From : </strong>{{from}} <br>
            <strong>To : </strong>{{to}} <br> 
            <strong>Pick-Up: </strong>{{busObj.pickup}}<br>
            <strong>Drop : </strong>{{busObj.drop}}<br>
            <strong>Departure Time: </strong>{{busObj.deptTime}}<br>
            <strong>Arrival Time : </strong>{{busObj.arvlTime}} <br>
            <strong>Price : </strong>{{busObj.price * passengerDetails.length}} <br>
        </p> 
        <hr>
        <h1><strong>Add Passenger Details</strong></h1>
        <div class="box" v-for="(passenger,index) in passengerDetails" :key="index">
            <span>
                <strong>{{index + 1}}.</strong><b>   Seat No :</b> {{passenger.seatno}} 
                <div >
                    <div >
                        <input class="input" v-model='passenger.name' type="text" placeholder="Name">
                        <input class="input" v-model='passenger.age' type="number" placeholder="Age">
                    </div>
                </div>
                <div class="field">
                    <div class="control">
                        <p class="radio">
                        <input type="radio" v-model='passenger.gender' value='M' name="question">
                        Male
                        </p>
                        <p class="radio">
                        <input type="radio" v-model='passenger.gender' value='F' name="question">
                        Female
                        </p>
                    </div>
                </div>
            </span>
        </div>
        <button class="button is-info" type="submit" @click="confirmTicket">Book Ticket</button>
        <button class="button is-danger" type="submit" @click="$router.go(-1)">Cancel</button>    
        <!--Payment Consfirmation-->
        <div class="modal" v-bind:class="{'is-active':paymentWindow}">
        <div class="modal-background"></div>
        <div class="modal-content box">
        <!-- Any other Bulma elements you want -->
        <h1><b>paymentWindow</b></h1>
        <hr>
        <p>This is a sample Payment Confirmation window</p>
        <button class="button is-success" type="submit" @click="paymentSuccessful">Accept</button>
        <button class="button is-danger" type="submit" @click="paymentFailed">Decline</button>
        </div>
        <button class="modal-close is-large" @click="paymentFailed" aria-p="close"></button>
        </div>
    </div>
</template>

<script>
export default {
    name:'bookticket',
    data:function(){
        return {
            paymentWindow:false,
            dateOfJourney:'',
            from:"",
            to:"",
            busObj:{
                    id:1,
                    busName:"",
                    pickup:"",
                    drop:"",
                    deptTime:"",
                    arvlTime:"",
                    type:"",
                    price:0
            },
            passengerDetails:[]
        }
    },
    created:function(){
        let obj = this.$parent.ticket;
        window.console.log(obj);
        this.$parent.ticket = null;
        this.busObj = obj.bus[0];
        this.from = this.$parent.search.source;
        this.to = this.$parent.search.destination;
        this.dateOfJourney = obj.dateOfJourney;
        this.passengerDetails = []
        obj.seats.forEach((value)=>{
        this.passengerDetails.push({
                seatno:value,
                name:'',
                age:Number,
                gender:''
            });
        });
    },
    methods:{
        confirmTicket:function(){
            this.paymentWindow = true;
        },
        paymentSuccessful:function(){
            this.paymentWindow = false;
            window.Axios.post('/user/buses/ticket',{
                id:this.busObj.id,
                username:this.$parent.loggedUsername,
                dateOfJourney:this.dateOfJourney,
                passengers:this.passengerDetails
            }).then((response)=>{
                window.alert(response.data);
                this.$router.go(-1);
            }).catch((error)=>{
                window.alert(error.response.data);
            });
        },
        paymentFailed:function(){
            window.alert('Payment Failed');
            this.paymentWindow = false;
            //go back Failed
        }
    }

}
</script>

<style>
.input{
    width: 20%;
}
</style>