<template>
    <div class="box">
        <h1><strong>Create Account</strong></h1>
        <div class="box">
            <h2><strong>Login Details</strong></h2>
            <div class="field">
            <label class="label">Username</label>
            <div class="control">
                <input class="input" required type="text" v-model="obj.username" placeholder="e.g alex123">
            </div>
            </div>
            <div class="field">
            <label class="label">password</label>
            <div class="control">
                <input class="input" type="password" v-model="obj.password" placeholder="e.g ax123#ads">
            </div>
            </div>
        </div>
        <div class="box">
            <h2><strong>General</strong></h2>
            <div class="field">
            <label class="label">Name</label>
            <div class="control">
                <input class="input" type="text" v-model="obj.customerName" placeholder="e.g Alex Smith">
            </div>
            </div>
            <div class="field">
            <label class="label">Mobile No.</label>
            <div class="control">
                <input class="input" type="number" v-model="obj.mobile" placeholder="e.g 72594">
            </div>
            </div>
            <div class="field">
            <label class="label">Email</label>
            <div class="control">
                <input class="input" type="text" v-model="obj.email" placeholder="e.g alex.smith@gmail.com">
            </div>
            </div>
            <div class="field">
            <label class="label">Address</label>
            <div class="control">
                <input class="input" type="text" v-model="obj.address" placeholder="e.g 1st Block,NY">
            </div>
            </div>
           <div class="field">
               <label class="label">Gender</label>
                <div class="control">
                    <p class="radio">
                    <input type="radio" v-model="obj.gender" value="M" name="question">
                    Male
                    </p>
                    <p class="radio">
                    <input type="radio" v-model="obj.gender" value="F" name="question">
                    Female
                    </p>
                </div>
            </div>
            <div class="field">
            <label class="label">Age</label>
            <div class="control">
                <input class="input" type="number" v-model="obj.age" placeholder="e.g 18">
            </div>
            </div>
            <div class="field">
            <p class="control">
            <button class="button is-success" @click="createAccount">
                Create Account
            </button>
            <button class="button is-danger" @click="goToHome">
                Cancel
            </button>
            </p>
            </div>
        </div>
        <hr>
    </div>
</template>

<script>
export default {
    name:'',
    data:function(){
        return{
            obj:{
                customerName:'',
                mobile:"",
                email:"",
                address:"",
                gender:"",
                age:"",
                username:"",
                password:""
            }
        }
    },
    methods:{
        createAccount:function(){
            window.Axios.post('/user',this.obj)
            .then((response)=>{
                this.$router.push({name:'home'});
                window.alert(response.data);
            })
            .catch((error)=>{
                window.alert(error.response.data);
            })
            .finally(()=>{
            });     
        },
        goToHome:function(){
           this.$router.push({name:'home'}); 
        }
    }
}
</script>

<style scoped>
.input{
    width: 20%;
}
</style>