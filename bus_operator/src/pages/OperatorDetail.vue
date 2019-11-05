<template>
    <div class='box'>
        <h1><strong>Operator Detail</strong></h1>
        <hr>
        <div class="field">
        <label class="label">Operator Username</label>
        <div class="control">
            <input disabled class="input" type="text" v-model="old.operatorUsername" placeholder="e.g smith277">
        </div>
        </div>
        <fieldset :disabled="!isUpdatable">
        <div class="field">
        <label class="label">Operator Name</label>
        <div class="control">
            <input class="input" type="text" v-model="updated.operatorName" :placeholder="old.operatorName">
        </div>
        </div>
        <div class="field">
        <label class="label">Mobile No.</label>
        <div class="control">
            <input class="input" type="number" v-model="updated.mobile" :placeholder="old.mobile">
        </div>
        </div>
        <div class="field">
        <label class="label">Email</label>
        <div class="control">
            <input class="input" type="email" v-model="updated.email" :placeholder="old.email">
        </div>
        </div>
        <div class="field">
        <label class="label">Address</label>
        <div class="control">
            <input class="input" type="address" v-model="updated.address" :placeholder="old.address">
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
        <input class="input" v-model="updatedPassword.oldPassword" type="password" placeholder="Enter Old Password">
        <p>New Password</p>
        <input class="input" v-model="updatedPassword.newPassword" type="password" placeholder="Enter New Password">
        <hr>
        <button class="button is-info" type="submit" @click="updatePassword">Update</button>
        </div>
        <button class="modal-close is-large" @click="isPasswordWindow=false" aria-p="close"></button>
        </div> 
    </div>
</template>

<script>
export default {
    name:'operatordetail',
    data:function(){
        return{
            isPasswordWindow:false,
            isUpdatable:false,
            old:{
                operatorName:'',
                mobile:"",
                email:"",
                address:"",
                operatorUsername:""
            },
            updated:{
                operatorName:'',
                mobile:"",
                email:"",
                address:"",
                operatorUsername:""
            },
            updatedPassword:{
                oldPassword:"",
                newPassword:""
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
        updatePassword:function(){
            window.Axios.post('/operator/account/password',
            {
                operatorUsername:this.old.operatorUsername,
                oldPassword:this.updatedPassword.oldPassword,
                newPassword:this.updatedPassword.newPassword
            })
            .then((response)=>{
                this.updatedPassword = {oldPassword:'',newPassword:''};
                this.isPasswordWindow = false;
                window.alert(response.data);
            })
            .catch((error)=>{
                this.updatedPassword = {oldPassword:'',newPassword:''};
                window.alert(error.response.data);
            });
        },
        updateDetail:function(){
            window.Axios.post('/operator/account',this.updated)
            .then((response)=>{
                this.old = response.data;
                this.updated = Object.assign({},this.old);
                window.alert("Operator Account Details Updated");
            })
            .catch((error)=>{
                window.alert(error.response.data);
            });
        },
        getAccountDetail:function(){
            window.Axios.get('/operator/account',{
            params:{
              operatorUsername:this.$route.params.operatorName
            }})
            .then((response)=>{
                this.old = response.data;
                this.updated = Object.assign({},this.old);
                window.console.log('should be updated');
            })
            .catch((error)=>{
                //this.$router.push({name:'home'});
                window.alert(error.response.data);
            });
        },
        deleteAccount:function(){
            window.Axios.delete('/operator/account',{
            params:{
              operatorUsername:this.$route.params.operatorName
            }})
            .then((response)=>{
                this.$parent.performLogOut();
                window.alert(response.data);
            })
            .catch((error)=>{
                this.$router.push({name:'home'});
                window.alert(error.response.data);
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