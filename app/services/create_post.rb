class CreatePost

    def initialize(id,post_data)
        @user_id = id
        @post_data = post_data
    end

    def call
        @response = Faraday.post("https://gorest.co.in/public-api/users/#{@user_id}/posts", @post_data) do |req|
            req.headers['Authorization'] = "Bearer db882f9c605a220d8d3571a4203a5fc117ae5fdfd7ef1444653d8675763a384c"
        end
        data = JSON.parse(@response.body)
        @post = data["data"]
        return @post
    end

end