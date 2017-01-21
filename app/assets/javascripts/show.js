var currentUrl  = window.location.href.split("/");
var currentLinkId = currentUrl[currentUrl.length - 1];

var myMixin = {
    created: function(){
      this.getLink(currentLinkId);
      this.getComments(currentLinkId);
    },
    data: {
        link: {},
        comments: [],
        new_comment: ""
    },
    methods: {
        getLink: function (link_id) {
            this.$http.get('/get-link/' + link_id).then(function (response) {
                this.link = response["body"];
                document.title = this.link["title"] + " " + document.title
            })
        },
        getComments: function (link_id) {
            this.$http.get('/get-comments/' + link_id).then(function (response) {
                this.comments = response["body"]["comments"];
            })
        },
        givePoint: function (id, type, index) {
            this.$http.get('/' + type + '/' + id + '/give-point').then(function(response){
                if(type == 'link'){
                    this.link["points_count"] = response["body"]["totalPoint"];
                }else{
                    this.comments[index]["points_count"] = response["body"]["totalPoint"];
                }
            }, function (response) {
                if(response["status"] == 401){
                    window.location = "/login";
                }else{
                    this.showModal(response["body"]["message"]);
                }

            });
        },
        newComment: function () {
            if(this.new_comment.length == 0 ){
                this.showModal("You can't send empty comment.");
            }else {
                this.$http.post('/link/' + this.link["id"] + '/new-comment', {
                    comment: this.new_comment,
                    link_id: this.link["id"]
                }).then(function () {
                    this.new_comment = "";
                    this.getComments(this.link["id"]);
                }, function (response) {
                    if (response["status"] == 401) {
                        window.location = "/login";
                    }else{
                        this.showModal(response["body"]["message"]);
                    }
                });
            }
        }
    }
};