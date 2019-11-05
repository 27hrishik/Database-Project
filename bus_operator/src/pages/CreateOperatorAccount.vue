<template>
    <div class="box">
        <h1><strong>Create Operator Account</strong></h1>
        <div class="box">
            <h2><strong>Login Details</strong></h2>
            <div class="field">
            <label class="label">Operator Username</label>
            <div class="control">
                <input class="input" type="text" v-model="obj.operatorUsername" placeholder="e.g abc21travels">
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
            <label class="label">Operator Name</label>
            <div class="control">
                <input class="input" type="text" v-model="obj.operatorName" placeholder="e.g SRS Travels">
            </div>
            </div>
            <div class="field">
            <label class="label">Mobile No.</label>
            <div class="control">
                <input class="input" type="number" v-model="obj.mobile" placeholder="e.g 7259212564">
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
            <p class="control">
            <button class="button is-success" @click="createOperatorAccount">
                Create Operator Account
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
                operatorName:'',
                mobile:"",
                email:"",
                address:"",
                operatorUsername:"",
                password:""
            }
        }
    },
    methods:{
        createOperatorAccount:function(){
            window.Axios.post('/operator',this.obj)
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
            this.$router.push({name:'home'})
        }
    }
}
</script>

<style scoped>
.input{
    width: 20%;
}
</style>