class GetUsers 

    def initialize
    end


    def call
        @response = Faraday.get("https://gorest.co.in/public-api/users")
        users_data = JSON.parse(@response.body)
        @details = users_data["data"]
        return @details
    end
end