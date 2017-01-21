RSpec.describe "CommentsRequest", type: :request do
  before do
    @user = create(:user)
    @link = create(:link, user_id: @user.id, username: @user.username)
  end

  describe "create new comment" do
    def login
      post "/login", {:email => @user.email, :password => @user.password}
    end

    it "create new comment" do
      login
      post "/link/#{@link.id}/new-comment", { comment: "Lorem ipsum dolar sit amet." }
      expect(response.code).to eq "200"
      @link.reload
      expect(@link.comments_count).to eq 1
    end
  end

  describe "create new comment without login" do
    it "create new comment without login" do
      post "/link/#{@link.id}/new-comment", { comment: "Lorem ipsum dolar sit amet." }
      expect(response.code).to eq "401"
    end
  end

  describe "get comments" do
    before do
      10.times do
        create(:comment, user_id: @user.id, username: @user.username, link_id: @link.id)
      end
    end

    it "get comments" do
      get "/get-comments/#{@link.id}"
      expect(response.code).to eq "200"
      expect(json["comments"].first["link_id"]).to eq @link.id
      expect(json["comments"].first["user_id"]).to eq @user.id

    end
  end
end