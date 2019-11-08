<template>
    <div class='box'>
        <h1><strong>Account Detail</strong></h1>
        <hr>
        <div class="field">
        <label class="label">Username</label>
        <div class="control">
            <input disabled class="input" type="text" v-model='old.username'>
        </div>
        </div>
        <fieldset :disabled="!isUpdatable">
        <div class="field">
        <label class="label">Name</label>
        <div class="control">
            <input class="input" type="text" v-model="updated.customerName" :placeholder="old.customerName">
        </div>
        </div>
        <div class="field">
        <label class="label">Mobile No.</label>
        <div class="control">
            <input class="input" type="text" v-model="updated.mobile" :placeholder="old.mobile">
        </div>
        </div>
        <div class="field">
        <label class="label">Email</label>
        <div class="control">
            <input class="input" type="text" v-model="updated.email" :placeholder="old.email">
        </div>
        </div>
        <div class="field">
        <label class="label">Address</label>
        <div class="control">
            <input class="input" type="text" v-model="updated.address" :placeholder="old.address">
        </div>
        </div>
        <div class="field">
            <label class="label">Gender</label>
            <div class="control">
                <p class="radio">
                <input type="radio" v-model="updated.gender" value="M" name="question">
                Male
                </p>
                <p class="radio">
                <input type="radio" v-model="updated.gender" value="F" name="question">
                Female
                </p>
            </div>
        </div>
        <div class="field">
        <label class="label">Age</label>
        <div class="control">
            <input class="input" type="number" v-model="updated.age" :placeholder="old.age">
        </div>
        </div>
        </fieldset>
        <hr>
        <button class="button is-info" @click="toggleUpdate">
            {{isUpdatable?"Save Changes":"Update"}}
        </button>
        <button class="button is-info" @click="resetDetails">
            Reset
        </button>
        <button class="button is-info" @click="isPasswordWindow=true">
            Update Password
        </button>
        <button class="button is-danger" @click="deleteAccount">
            Delete Account
        </button>
        <!-- Update Password-->
        <div class="modal" v-bind:class="{'is-active':isPasswordWindow}">
        <div class="modal-background"></div>
        <div class="modal-content box">
        <!-- Any other Bulma elements you want -->
        <h1><b>Update Password</b></h1>
        <p>Old Password</p>
        <input class="input" type="password" v-model="updatedPassword.oldPassword" placeholder="Enter Old Password">
        <p>New Password</p>
        <input class="input" type="password" v-model="updatedPassword.newPassword" placeholder="Enter New Password">
        <hr>
        <button class="button is-info" @click="passUpdate">Update</button>
        </div>
        <button class="modal-close is-large" @click="isPasswordWindow=false" aria-p="close"></button>
        </div> 
    </div>
</template>

<script>
export default {
    name:'accountdetail',
    data:function(){
        return{
            isPasswordWindow:false,
            isUpdatable:false,
            old:{
                username: 'UserName',
                customerName:'Customer Name',
                mobile:'Mobile',email:'Email',
                address:'address',
                gender:'Gender',
                age:12 
            },
            updated:{
                username: 'UserName',
                customerName:'Customer Name',
                mobile:'Mobile',email:'Email',
                address:'address',
                gender:'Gender',
                age:12 
            },
            updatedPassword:{
                oldPassword:'',
                newPassword:''
            }
        }
    },
    created:function(){
        this.getAccountDetail();
    },
    methods:{
        toggleUpdate:function(){
            this.isUpdatable = !this.isUpdatable;
            if(this.isUpdatable==false)
                this.updateDetail();
        },
        passUpdate:function(){
            window.Axios.post('/user/account/password',{
              username:this.old.username,  
              oldPassword:this.updatedPassword.oldPassword,
              newPassword:this.updatedPassword.newPassword
            })
            .then((response)=>{
                this.isPasswordWindow = false;
                this.updatedPassword = {oldPassword:'',newPassword:''};
                window.alert(response.data);
            })
            .catch((error)=>{
                this.updatedPassword = {oldPassword:"",newPassword:""};
                window.alert(error.response.data);
            });      
        },
        updateDetail:function(){
            window.Axios.post('/user/account/',this.updated)
            .then((response)=>{
                this.old = response.data;
                this.updated = Object.assign({},this.old);
                window.alert("Account Details Updated ");
            })
            .catch((error)=>{
                window.alert(error.response.data);
            });
        },
        getAccountDetail:function(){
            window.Axios.get('/user/account',{
            params:{
              username:this.$parent.loggedUsername
            }})
            .then((response)=>{
                this.old = response.data;
                this.updated = Object.assign({},this.old);
                //window.console.log(response.data);
            })
            .catch((error)=>{
                this.$router.push({name:'home'});
                window.alert(error.response.data);
            });
        },
        deleteAccount:function(){
            window.Axios.delete('/user/account',{
            params:{
              username:this.$parent.loggedUsername,
            }})
            .then((response)=>{
                this.$parent.performLogOut();
                window.alert(response.data);
            })
            .catch((error)=>{
                window.console.log(error);
            });
        },
        resetDetails:function(){
            this.updated = Object.assign({},this.old);
        }
    }
}
</script>

<style scoped>
.input{
    width: 30%;
}
</style>