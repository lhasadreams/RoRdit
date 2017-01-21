RSpec.describe "PointsRequest", type: :request do
  describe "give point" do
    before do
      @user = create(:user)
      @link = create(:link, username: @user.username, user_id: @user.id)
      @comment = create(:comment, link_id: @link.id, user_id: @user.id)
    end

    def login
      post "/login", {:email => @user.email, :password => @user.password}
    end

    it "give point to link" do
      login
      get "/link/#{@link.id}/give-point"
      expect(response.code).to eq "200"
      @link.reload
      expect(@link.points_count).to eq 1
    end

    it "give point to link which is already given" do
      login
      Point.create(link_id: @link.id, user_id: @user.id)
      get "/link/#{@link.id}/give-point"
      expect(response.code).to eq "422"
    end

    it "give point to comment" do
      login
      get "/comment/#{@comment.id}/give-point"
      expect(response.code).to eq "200"
      @comment.reload
      expect(@comment.points_count).to eq 1
    end

    it "give point to comment which is already given" do
      login
      Point.create(comment_id: @comment.id, user_id: @user.id)
      get "/comment/#{@comment.id}/give-point"
      expect(response.code).to eq "422"
    end

    it "give point to link without login" do
      get "/link/#{@link.id}/give-point"
      expect(response.code).to eq "401"
    end

    it "give point to comment without login" do
      get "/comment/#{@comment.id}/give-point"
      expect(response.code).to eq "401"
    end
  end
end