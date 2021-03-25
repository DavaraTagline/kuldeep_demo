class GetPost

    def initialize(id)
        @user_id = id
    end

    def call
        @response = Faraday.get("https://gorest.co.in/public-api/users/#{@user_id}/posts")
        posts_data = JSON.parse(@response.body)
        @postdetails = posts_data["data"]
        return @postdetails
    end
end