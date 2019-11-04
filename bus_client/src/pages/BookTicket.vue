<template>
    <div class='box'>
        <h1><strong>Ticket Details</strong></h1> 
        <p><strong>Name : </strong>{{customerName}}<br>
        <strong>Mobile No : </strong>{{mobile}}<br>
        <strong>Email : </strong><br>
        <strong>Date Of Journey : </strong>{{dateOfJourney}}<br>
        <strong>From : </strong>{{from}} <br>
        <strong>To : </strong>{{to}} <br> 
        </p>
        <hr>
        <h1><strong>Bus Details</strong></h1> 
        <p>
            <strong>Bus Name : </strong>{{busObj.busName}}<br>
            <strong>Bus Type : </strong>{{busObj.type}}<br>
            <strong>Pick-Up: </strong>{{busObj.pickUp}}<br>
            <strong>Drop : </strong>{{busObj.drop}}<br>
            <strong>Departure Time: </strong>{{busObj.deptTime}}<br>
            <strong>Arrival Time : </strong>{{busObj.arvlTime}} <br>
            <strong>Price : </strong>{{busObj.price * seatNo.length}} <br>
        </p> 
        <hr>
        <h1><strong>Add Passenger Details</strong></h1>
        <div class="box" v-for="(seat,index) in seatNo" :key="index">
            <span>
                <strong>{{index + 1}}.</strong><b>   Seat No :</b> {{seat}} 
                <div >
                    <div >
                        <input class="input" type="text" placeholder="Name">
                        <input class="input" type="text" placeholder="Age">
                    </div>
                </div>
                <div class="field">
                    <div class="control">
                        <p class="radio">
                        <input type="radio" name="question">
                        Male
                        </p>
                        <p class="radio">
                        <input type="radio" name="question">
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
            customerName:'abac',
            mobile:'932',
            dateOfJourney:'2019-12-17',
            from:"bng",
            to:"mys",
            busObj:{
                    id:1,
                    busName:"SRS",
                    pickUp:"Majestic",
                    drop:"JP Nagar",
                    deptTime:"19:30",
                    arvlTime:"06:30",
                    type:"NON-AC SLEEPER",
                    price:"970"
            },
            seatNo:["A3","A4"],
            passengerDetails:[]
        }
    },
    methods:{
        confirmTicket:function(){
            this.paymentWindow = true;
        },
        paymentSuccessful:function(){
            this.paymentWindow = false;
            //go to Home successful
        },
        paymentFailed:function(){
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