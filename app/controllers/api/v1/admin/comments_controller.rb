module API::V1::Admin
  class CommentsController < AdminController
    before_action :find_commentable, only: :index_for_commentable
    before_action find_record, only: %i(destroy)

    def index
      success(each_serializer: AdminCommentSerializer) do
        paginated_with_meta Comment.all.new_to_old
      end
    end

    def index_for_commentable
      success(each_serializer: AdminCommentSerializer) do
        paginate_with_meta(@commentable.comments)
      end
    end

    def destroy
      @comment.destroy
      updated
    end

    def set_spam
      @comment.spam!
      updated
    end

    def unset_spam
      @comment.normal!
      updated
    end

    def filter
      comments = Comment.smart_filter(filter_params)
      success(each_serializer: AdminCommentSerializer) do
        paginated_with_meta comments
      end
    end

    private

    def filter_params
      params.permit(:commentable_id,
                    :commentable_type,
                    :content,
                    :state,
                    :parent_id,
                    :user_id)
    end
  end
end
