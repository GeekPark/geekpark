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

    def post_params
      params.permit(:title,
                    :content,
                    :abstract,
                    :source,
                    :picture,
                    :tags,
                    :column_id,
                    :state,
                    meta: Post::DEFAULT_META.keys)
    end
  end
end
