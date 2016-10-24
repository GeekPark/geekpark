module API::V1
  class ColumnsController < APIController
    before_action :find_column,
                  only: %i(destroy show update reset_members add_members)

    def index
      success(Column.all)
    end

    def create
      column = Column.create(column_params)
      created(column)
    end

    def destroy
      @column.destroy
      updated
    end

    def show
      success(@column)
    end

    def update
      @column.update_attributes(column_params)
      updated
    end

    def add_members
      @column.add_members(params[:post_ids])
    end

    private

    def find_column
      @column = Column.find(params[:id] || params[:column_id])
    end

    def column_params
      params.permit(:title,
                    :description,
                    :content_type,
                    meta: Column::META_VARIABLES.keys)
    end
  end
end
