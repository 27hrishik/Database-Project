<template>
    <div class="box">
        <div class="columns" v-for="i in rows" :key="i">
             <button class="column button" :class="{'is-success':isSelected(i,j),'is-dark':isBooked(i,j)}" :disabled="isBooked(i,j)" v-for="j in columns" :key="j" v-model="computeSeatIndex(i,j)" @click="passSelectedSeat($event)">
            {{computeSeatIndex(i,j)}}  
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
        selectedSeats:{
            type:Array,
            default:function(){
                return [];
            }
        },
        bookedSeats:{
            type:Array,
            default:function(){
                return [];
            }
        }
    },
    methods:
    {
        passSelectedSeat:function(event){
            //window.console.log("selected seats "+this.selectedSeats);
            this.$emit("seat-selected",event.target.value);
        },
        computeSeatIndex:function(i,j){
            return String.fromCharCode(64+i)+j;
        },
        isSelected:function(i,j){
            let seatId = this.computeSeatIndex(i,j);
            return this.selectedSeats.indexOf(seatId)!=-1; 
        },
        isBooked:function(i,j){
            let seatId = this.computeSeatIndex(i,j);
            return this.bookedSeats.indexOf(seatId)!=-1;
        }
    }
}
</script>
<style >
</style>