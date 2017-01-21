var myMixin = {
    data: {
        email: "",
        password: "",
        username: ""
    },
    methods: {
        checkEmpty: function () {
            return this.email.length > 0 && this.password.length > 0 && this.username.length > 0;
        },
        submitRegister: function () {
            if(this.checkEmpty()){
                this.$http.post('/register', {
                    email: this.email,
                    password: this.password,
                    username: this.username
                }).then(function () {
                    window.location = "/";
                }, function (response) {
                    this.showModal(response["body"]["message"]);
                });
            }else{
                this.showModal("Email, username or passsword can not be empty.");
            }

        }
    }
};