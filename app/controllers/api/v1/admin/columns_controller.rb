module API::V1::Admin
  class ColumnsController < AdminController
    resource_description { short '專欄 (管理介面)' }
    before_action find_record, only: %i(destroy show update add_members)

    api :GET, '/admin/columns', 'Get the list of all columns'
    param :post_ids, Array, of: String, desc: 'Indicates the members in a topic'
    def index
      success(each_serializer: AdminColumnSerializer) do
        paginated_with_meta Column.all.new_to_old
      end
    end

    def_param_group :column_params do
      param :title, String, required: true
      param :description, String
      param :content_type, Column.content_types.keys,
            desc: '指示該專欄的內容類型',
            required: true
    end

    api :POST, '/admin/columns', 'Create a column'
    param_group :column_params
    def create
      column = Column.create(column_params)
      created(column)
    end

    api :GET, '/admin/columns/:id', 'Show the details of a column'
    def show
      success(@column)
    end

    api :DELETE, '/admin/columns/:id', 'Destroy a column'
    def destroy
      @column.destroy
      updated
    end

    api :POST, '/admin/columns/:id', 'Update a column'
    param_group :column_params
    def update
      @column.update_attributes(column_params)
      updated
    end

    api :POST, '/admin/columns/:id/members', 'Add new members to a column'
    param :post_ids, Array, of: String, desc: 'Members to add'
    def add_members
      @column.add_members(params[:post_ids])
      updated
    end

    private

    def column_params
      params.permit(:title,
                    :description,
                    :content_type)
    end
  end
end
