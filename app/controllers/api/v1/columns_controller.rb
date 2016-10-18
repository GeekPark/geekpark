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
      column.destroy
      updated
    end

    def show
      success(@column)
    end

    def update
      @column.update_attributes(column_params)
      updated
    end

    def reset_members
      @column.reset_members(params[:topic_ids])
    end

    def add_members
      @column.add_members(params[:topic_ids])
    end

    private

    def find_column
      @column = Collection.find(params[:id] || params[:collection_id])
    end

    def collection_params
      params.permit(:title,
                    :description,
                    :banner,
                    :banner_mobile,
                    meta: Collection::META_VARIABLES.keys)
    end
  end
end