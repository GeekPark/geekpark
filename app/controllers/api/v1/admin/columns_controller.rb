module API::V1::Admin
  class ColumnsController < AdminController
    before_action find_record, only: %i(destroy show update add_members)

    def index
      success(each_serializer: AdminColumnSerializer) do
        paginated_with_meta Column.all.new_to_old
      end
    end

    def create
      column = Column.create(column_params)
      created(column)
    end

    def show
      success(@column)
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

    def column_params
      params.permit(:title,
                    :description,
                    :content_type,
                    meta: Column::DEFAULT_META.keys)
    end
  end
end
