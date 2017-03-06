module API::V1::Admin
  class PostsController < AdminController
    before_action :find_post, only: %i(destroy show update)

    def index
      success do
        paginated_with_meta Post.all
      end
    end

    def show
      success(@post)
    end

    def create
      post = Post.create(post_params)
      created(post)
    end

    def update
      @post.update_attributes(post_params)
      updated
    end

    def destroy
      @post.destroy
      updated
    end

    private

    def find_post
      @post = Post.find(params[:id] || params[:post_id])
    end

    def post_params
      params.permit(:title,
                    :content_source,
                    :content_type,
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
