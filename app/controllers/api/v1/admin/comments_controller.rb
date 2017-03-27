module API::V1::Admin
  class CommentsController < AdminController
    resource_description { short '評論 (管理員介面)' }
    before_action :find_commentable, only: :index_for_commentable
    before_action find_record, only: %i(destroy set_spam unset_spam)

    api :GET, 'admin/comments', 'List comments'
    def index
      success(each_serializer: AdminCommentSerializer) do
        paginated_with_meta Comment.all.new_to_old
      end
    end

    api :GET, 'admin/(ads|posts)/:id/comments', 'List comments for given'
    def index_for_commentable
      success(each_serializer: AdminCommentSerializer) do
        paginate_with_meta(@commentable.comments)
      end
    end

    api :DELETE, 'admin/comments/:id', 'Destroy a comment'
    def destroy
      @comment.destroy
      updated
    end

    api :PATCH, 'admin/comments/:id/spam', 'Set a comment as spam'
    def set_spam
      @comment.spam!
      updated
    end

    api :DELETE, 'admin/comments/:id/spam', 'Set a comment as non-spam'
    def unset_spam
      @comment.normal!
      updated
    end

    api :GET, 'admin/comments/filter', 'Smart filter on comments'
    param :commentable_id,   Integer
    param :commentable_type, %w(Post Ad)
    param :content,          String
    param :state,            %w(normal spam)
    param :parent_id,        Integer
    param :user_id,          Integer
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
