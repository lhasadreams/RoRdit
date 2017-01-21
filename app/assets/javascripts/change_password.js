var myMixin = {
    data: {
        email: "",
        password: "",
        recoveryToken: ""
    },
    methods: {
        checkEmpty: function () {
            return this.email.length > 0 && this.password.length > 0 && this.recoveryToken.length > 0
        },
        changePassword: function () {
            if(this.checkEmpty()){
                this.$http.post('/changing-password', {
                    email: this.email,
                    token: this.recoveryToken,
                    new_password: this.password
                }).then(function (response) {
                    window.location = response["body"]["message"];
                }, function (response) {
                    this.showModal(response["body"]["message"]);
                });
            }else{
                this.showModal("Email, new password or token  can not be empty.");
            }
        }
    },
    computed: {
        validateToken: function () {
          return {
              warning: this.recoveryToken.length > 0 && this.recoveryToken.length < 6
          }
        },
        validateChangeSubmit: function () {
            return {
                disabled: this.validateEmail["warning"] || this.validatePassword["warning"]
                          || this.validateToken["warning"] || this.email.length == 0
                            || this.password.length == 0 || this.recoveryToken.length == 0
            }
        }
    }
};