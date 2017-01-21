RSpec.describe "LinksRequest", type: :request do
  before do
    @user = create(:user)
  end

  describe '#create' do
    def login
      post "/login", {:email => @user.email, :password => @user.password}
    end

    def share_link
      post '/link/create', { title: "The History of the iPhone on its 10th Anniversary",
                             url: "http://www.internethistorypodcast.com/2017/01/the-history-of-the-iphone/" }
    end

    it "share new link" do
      login
      share_link
      expect(response.code).to eq "200"
      expect(Link.count).to eq 1
    end

    it "share new link without login" do
      share_link
      expect(response.code).to eq "401"
    end
  end

  describe "get links" do
    before do
      15.times do
        create(:link, username: @user.username, user_id: @user.id)
      end
    end

    it "get popular links" do
      get '/get-popular-links/0'
      expect(response.code).to eq "200"
      expect(json["links"].first["popularity"]).to be >  json["links"].last["popularity"]
    end

    it "get newest links" do
      get '/get-newest-links/0'
      expect(response.code).to eq "200"
      expect(json["links"].first["created_at"]).to be >  json["links"].last["created_at"]
    end
  end

  describe "get link" do
    before do
      @link = create(:link, username: @user.username, user_id: @user.id)
    end

    it "get link" do
      get "/get-link/#{@link.id}"
      expect(response.code).to eq "200"
      expect(json["id"]).to eq @link.id
    end
  end
end