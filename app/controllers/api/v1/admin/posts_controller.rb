module API::V1::Admin
  class PostsController < AdminController
    def index
      success do
        paginated_with_meta Post.all
      end
    end

    def create
      post = Post.create(post_params)
      created(post)
    end
  end
end
