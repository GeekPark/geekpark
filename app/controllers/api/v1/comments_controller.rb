module API::V1
  class CommentsController < APIController
    resource_description { short '評論' }
    before_action :find_commentable

    api :GET, '/(posts|ads)/:id/comments',
        'List all comments under given post or ad'
    def index
      success do
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

    private

    def find_commentable
      @commentable = Post.find_by(id: params[:post_id]) ||
                     Ad.  find_by(id: params[:ad_id])
    end

    def comment_params
      params.permit(:content, :parent_id)
    end
  end
end
