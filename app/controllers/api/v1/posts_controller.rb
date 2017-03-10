module API::V1
  class PostsController < APIController
    before_action :find_post, only: %i(destroy show update)

    def index
      success { paginated Post.all }
    end

    def show
      success(@post)
    end

    private

    def find_post
      @post = Post.find(params[:id] || params[:post_id])
    end
  end
end
