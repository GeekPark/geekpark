module API::V1::Admin
  class ColumnsController < AdminController
    before_action :find_column, only: %i(destroy show update add_members)

    def create
      column = Column.create(column_params)
      created(column)
    end

    def destroy
      @column.destroy
      updated
    end

    def update
      @column.update_attributes(column_params)
      updated
    end

    def add_members
      @column.add_members(params[:post_ids])
      updated
    end

    private

    def find_column
      @olumn = Post.find(params[:id] || params[:column_id])
    end

    def column_params
      params.permit(:title,
                    :description,
                    :content_type,
                    meta: Column::DEFAULT_META.keys)
    end
  end
end
