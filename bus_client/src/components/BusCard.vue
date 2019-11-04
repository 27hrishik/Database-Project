<template>
    <article class="box columns">
        <div class="column">
            <p><strong>{{busName}}</strong></p>    
        </div>
        <div class="column">
            <p><strong>{{deptTime +"   "+ arvlTime}}</strong></p>
        </div>
        <div class="column">
            <button @click="busSelected" class="button is-success"><small>INR</small><strong>{{price}}</strong></button>
        </div>                     
    </article>    
</template>

<script>
export default {
    name:"buscard",
    props:{
        id:Number,
        busName:String,
        pickUp:String,
        drop:String,
        deptTime:String,
        arvlTime:String,
        type:String,
        price:String
    },
    methods:{
        busSelected:function(){
            this.$emit("bus-selected",this.id);
        }
    }

}
</script>

<style scoped>

</style>