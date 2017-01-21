var myMixin = {
    data: {
        email: "",
        password: ""
    },
    methods: {
        checkEmpty: function () {
            return this.email.length > 0 && this.password.length > 5
        },
        submitLogin: function () {
            if(this.checkEmpty()){
                this.$http.post('/login', {
                    email: this.email,
                    password: this.password
                }).then(function (response) {
                    window.location = response["body"]["message"];
                }, function (response) {
                    this.showModal(response["body"]["message"]);
                });
            }else{
                this.showModal("Email or passsword can not be empty.");
            }

        }
    }
};