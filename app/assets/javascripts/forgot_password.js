var myMixin = {
    data: {
        email: ""
    },
    methods: {
        checkEmpty: function () {
            return this.email.length > 0
        },
        recoverPassword: function () {
            if(this.checkEmpty()){
                this.$http.post('/password-recovery', {
                    email: this.email
                }).then(function (response) {
                    window.location = response["body"]["message"];
                }, function (response) {
                    this.message(response["body"]["message"]);
                });
            }else{
                this.showModal("Email can not be empty.");
            }
        }
    },
    computed: {
        validateForgotSubmit: function () {
            return {
                disabled: this.validateEmail["warning"] || this.email.length == 0
            }
        }
    }
};