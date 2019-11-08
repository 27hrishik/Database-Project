<template>
    <div class="box">
        <div class="columns" v-for="i in rows" :key="i">
             <button class="column button" :class="{'is-success':isSelected(i,j),'is-dark':isBooked(i,j)}" :disabled="isBooked(i,j)" v-for="j in columns" :key="j" :value="computeSeatNumber(i,j)" @click="passSelectedSeat">
            {{computeSeatNumber(i,j)}}  
            </button>
        </div>
    </div>            
</template>

<script>
export default {
    name:"seatgrid",
    props:{
        rows:Number,
        columns:Number,
        select:Object
    },
    methods:
    {
        passSelectedSeat:function(){
            this.$emit("seat-selected",event.currentTarget.value);
        },
        computeSeatIndex:function(i,j){
            return String.fromCharCode(64+i)+j;
        },
        computeSeatNumber(i,j){
            return (i-1) * this.columns + j;
        },
        isSelected:function(i,j){
            let seatId = this.computeSeatNumber(i,j);
            return this.select.selectedSeats.indexOf(seatId.toString())!=-1; 
        },
        isBooked:function(i,j){
            let seatId = this.computeSeatNumber(i,j);
            return this.select.bookedSeats.indexOf(seatId)!=-1;
        }
    }
}
</script>
<style >
</style>