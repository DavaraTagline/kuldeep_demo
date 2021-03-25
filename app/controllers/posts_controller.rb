class PostsController < Api::V1::BaseController
    before_action :process_token
    skip_before_action :verify_authenticity_token

    def users
        @userdetails = GetUsers.new().call
        success_json(@userdetails, "displayed all users")
    end
    
    def save_post
        @postdetails = GetPost.new(params[:id]).call
        @saved_post = []
        if @postdetails.blank?
            err_json(@postdetails, 'There is no post in data!', 204)
        else
            @postdetails.each do |post|
                post = Post.new(title: post["title"], body: post["body"], user_id: @current_user_id)
                post.save
                @saved_post.push(post)   
            end
            success_json(@saved_post, "posts save successfully!")
        end
    end

    def create_post
        post_data = {
            title: 'Hey......!',
            body: 'ABCDEFGHIJKLMNOP........!',
            user_id: params[:id]
        }
        @created_post = CreatePost.new(params[:id],post_data).call
        success_json(@created_post, "Post created successfully!")
    end
end