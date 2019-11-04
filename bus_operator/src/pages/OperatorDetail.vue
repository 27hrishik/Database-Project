<template>
    <div class='box'>
        <h1><strong>Operator Detail</strong></h1>
        <hr>
        <div class="field">
        <label class="label">Operator Username</label>
        <div class="control">
            <input disabled class="input" type="text" v-model="operatorUsername" placeholder="e.g smith277">
        </div>
        </div>
        <fieldset :disabled="!isUpdatable">
        <div class="field">
        <label class="label">Operator Name</label>
        <div class="control">
            <input class="input" type="text" v-model="operatorName" placeholder="e.g Alex Smith">
        </div>
        </div>
        <div class="field">
        <label class="label">Mobile No.</label>
        <div class="control">
            <input class="input" type="text" v-model="mobile" placeholder="e.g 7258002212">
        </div>
        </div>
        <div class="field">
        <label class="label">Email</label>
        <div class="control">
            <input class="input" type="text" v-model="email" placeholder="e.g alex.smith@gmail.com">
        </div>
        </div>
        <div class="field">
        <label class="label">Address</label>
        <div class="control">
            <input class="input" type="text" v-model="address" placeholder="e.g 1st Block">
        </div>
        </div>
        </fieldset>
        <hr>
        <button class="button is-info" @click="isUpdatable=!isUpdatable">
            {{isUpdatable?"Save Changes":"Update"}}
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
        <input class="input" type="password" placeholder="Enter Old Password">
        <p>New Password</p>
        <input class="input" type="password" placeholder="Enter New Password">
        <input class="input" type="password" placeholder="Re-Enter New Password">
        <hr>
        <button class="button is-info" type="submit" @click="updatePassword">Log in</button>
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
            operatorName:'Hrishi',
            mobile:"968",
            email:"abc@gmail.com",
            address:"marathahalli",
            operatorUsername:"27hrishik",
        }
    },
    methods:{
        updatePassword:function(){

        },
        updateDetail:function(){

        },
        getAccountDetail:function(){

        },
        deleteAccount:function(){

        }
    }
}
</script>

<style scoped>
.input{
    width: 30%;
}
</style>