module API::V1
  class CommentsController < APIController
    resource_description { short '評論' }
    before_action :find_commentable
    before_action :find_comment, only: %i(like unlike)

    api :GET, '/(posts|ads)/:id/comments',
        'List all comments under given post or ad'
    def index
      success(user_id: current_user_id) do
        paginated(@commentable.comments.normal)
      end
    end

    api :POST, '/(posts|ads)/:id/comments', 'Post a comment'
    param :content,   String,  desc: 'Comment content', required: true
    param :parent_id, Integer, desc: 'Reply to given comment (nullable)'
    def create
      comment = Comment.create(
        comment_params.merge(commentable: @commentable)
      )
      created(comment)
    end

    api :POST, '/posts/:post_id/comments/:comment_id/like', 'like specfic comment'
    param :post_id, Integer, desc: 'post id', required: true
    param :comment_id, Integer, desc: 'comment id', required: true
    def like
      if @comment.like(current_user_id)
        render json: { message: 'success' }
      else
        render json: { error: 'already liked' }
      end
    end

    api :POST, '/posts/:post_id/comments/:comment_id/unlike', 'unlike specfic comment'
    param :post_id, Integer, desc: 'post id', required: true
    param :comment_id, Integer, desc: 'comment id', required: true
    def unlike
      if @comment.unlike(current_user_id)
        render json: { message: 'success' }
      else
        render json: { error: 'already unliked' }
      end
    end

    private

    def find_commentable
      @commentable = Post.find_by(id: params[:post_id]) ||
                     Ad.  find_by(id: params[:ad_id])
    end

    def find_comment
      @comment = Comment.find_by(id: params[:comment_id])
    end

    def comment_params
      params.permit(:content, :parent_id)
    end
  end
end
