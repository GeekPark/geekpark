module API::V1
  class PostsController < APIController
    resource_description { short '文章/視頻 API' }
    before_action find_record, only: %i(show like unlike)

    api :GET, '/posts', 'List all posts'
    def index
      success { paginated Post.all }
    end

    api :GET, '/posts/:id', 'Show specific post'
    def show
      @post.increment
      success(serializer: ::PostSerializer, user_id: current_user_id) do
        @post
      end
    end

    api :GET, '/posts/hot_in_week', 'Show a list of hot posts in recent 7-day'
    def hot_in_week
      success(Post.order_by_click_count(7.days).take(7))
    end

    api :GET, '/posts/by-tag/:tag', 'Show a list of posts with given tag'
    def index_by_tag
      tag = params[:tag]
      success { Post.with_tag(tag).published }
    end

    api :POST, '/posts/:id/like', 'Like specfic post'
    def like
      render json: @post.like(current_user_id)
    end

    api :POST, '/posts/:id/unlike', 'Unlike specfic post'
    def unlike
      render json: @post.unlike(current_user_id)
    end
  end
end
