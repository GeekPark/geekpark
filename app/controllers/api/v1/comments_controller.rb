module API::V1
  class CommentsController < APIController
    before_action :find_commentable

    def index
      success do
        paginated(@commentable.comments.normal)
      end
    end

    def create
      comment = Comment.create(
        comment_params.merge(commentable: @commentable)
      )
      created(comment)
    end

    private

    def find_commentable
      @commentable = Post.find_by(id: params[:post_id]) ||
                     Ad.find_by(id: params[:ad_id])
    end

    def comment_params
      params.permit(:content, :parent_id)
    end
  end
end
