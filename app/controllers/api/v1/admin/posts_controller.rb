module API::V1::Admin
  class PostsController < AdminController
    resource_description { short '管理介面文章/視頻 API' }
    before_action find_record, only: %i(destroy show update publish)

    api :GET, '/admin/posts', 'List or filter on posts'
    param :title, String, desc: '标题'
    param :state, String, desc: '状态 unpublished, published, closed'
    def index
      posts = Post
              .smart_filter(params.permit(:title, :state))
              .includes(:column)
              .new_to_old

      success(each_serializer: ::AdminShortPostSerializer) do
        paginated_with_meta posts
      end
    end

    api :GET, '/admin/posts/:id', 'Show a specific post'
    def show
      success(serializer: ::AdminPostSerializer) { @post }
    end

    def_param_group :post_params do
      param :title, String, required: true
      param :abstract, String, desc: '摘要'
      param :content_type, %w(html markdown plain),
            required: true, desc: '正文格式'
      param :content_source, String, desc: '正文'
      param :tags, Array, of: String
      param :column_id, Integer, required: true
      param :cover_id, Integer, desc: '封面圖片'
      param :author_ids, Integer, required: true
      param :source, String, '消息來源'
      param :state, %w(unpublished published closed)
    end

    api :POST, '/admin/posts', 'Create a post'
    param_group :post_params
    param :auto_publish_at, Time, desc: '定時發布的文章'
    def create
      post = Post.create!(post_params)

      if params[:auto_publish_at]
        till = Time.parse(params[:auto_publish_at])
        post.publish_later(till: till)
      end

      created(post)
    end

    api :PATCH, '/admin/posts/:id/publish', 'Publish a post'
    def publish
      @post.publish!
      updated
    end

    api :PATCH, '/admin/posts/:id/unpublish', 'Un-publish a post'
    def unpublish
      @post.unpublish!
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
      @post.update_attributes!(post_params)
      updated
    end

    def destroy
      @post.destroy!
      updated
    end

    private

    def post_params
      params.permit(:title,
                    :abstract,
                    :content_source,
                    :content_type,
                    :tags,
                    :column_id,
                    :cover_id,
                    :author_ids,
                    :source,
                    :state)
    end
  end
end
