module API::V1::Admin
  class PostsController < AdminController
    before_action :find_post, only: %i(destroy show update publish)

    def index
      success(each_serializer: ::AdminShortPostSerializer) do
        paginated_with_meta Post.all.includes(:column)
      end
    end

    def show
      success(@post)
    end

    def hot_in_week
      success(Post.order_by_click_count(7.days).take(7))
    end

    def create
      # TODO: params[:auto_publish_at]
      post = Post.create(post_params)
      created(post)
    end

    def publish
      @post.publish!
      updated
    end

    def draft
      @post.draft!
      updated
    end

    def close
      @post.close!
      updated
    end

    def today_statistics
      success do
        {
          publishings: Post.count_publishings(1.day),
          clicks:      Post.count_clicks(1.day),
          sharings:    Post.count_sharings(1.day)
        }
      end
    end

    def update
      @post.update_attributes(post_params)
      updated
    end

    def filter
      posts = Post
              .smart_filter(params.permit(:title, :state))
              .includes(:column)

      success(each_serializer: ::AdminShortPostSerializer) do
        paginated_with_meta posts
      end
    end

    def destroy
      @post.destroy
      updated
    end

    private

    def find_post
      @post = Column.find(params[:id] || params[:post_id])
    end

    def post_params
      params.permit(:title,
                    :abstract,
                    :content_source,
                    :content_type,
                    :tags,
                    :column_id,
                    :picture,
                    :author_ids,
                    :source,
                    :state,
                    meta: Post::DEFAULT_META.keys)
    end
  end
end
