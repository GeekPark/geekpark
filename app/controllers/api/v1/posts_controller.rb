module API::V1
  class PostsController < APIController
    before_action :find_post, only: %i(destroy show update)

    def index
      success(Post.all)
    end

    def create
      post = Post.create(post_params)
      created(post)
    end

    def destroy
      @post.destroy
      updated
    end

    def show
      success(@post)
    end

    def update
      @post.update_attributes(post_params)
      updated
    end

    def add_members
      @post.add_members(params[:post_ids])
    end

    private

    def find_post
      @post = Post.find(params[:id] || params[:post_id])
    end

    def post_params
      params.permit(:title,
                    :content,
                    :column_id,
                    :state,
                    meta: Post::META_VARIABLES.keys)
    end
  end
end
