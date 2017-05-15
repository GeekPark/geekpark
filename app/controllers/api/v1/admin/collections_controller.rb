module API::V1::Admin
  class CollectionsController < AdminController
    resource_description { short '管理介面 合集 API' }

    before_action find_record,
                  only: %i(destroy show update reset_members add_members)

    api :GET, '/admin/collections', 'Get a list of all collections'
    def index
      success(Collection.all)
    end

    def_param_group :collection_params do
      param :title, String, required: true
      param :description, String
      param :banner_id, Integer, desc: 'banner 圖片'
    end

    api :POST, '/admin/collections', 'Create a collection'
    param_group :collection_params
    def create
      collection = Collection.create!(collection_params)
      created(collection)
    end

    api :DELETE, '/admin/collections/:id', 'Destroy a collection'
    def destroy
      @collection.destroy!
      updated
    end

    api :PATCH, '/admin/collections/:id', 'modify collection properties'
    param_group :collection_params
    def update
      @collection.update_attributes!(collection_params)
      updated
    end

    api :POST, '/admin/collections/:id/members', 'Add members to a collection'
    param :post_ids, Array, of: Integer
    def add_members
      @collection.add_members(params[:post_ids])
    end

    api :PUT, '/admin/collections/:id/members', 'Reset members for a collection'
    param :post_ids, Array, of: Integer
    def reset_members
      @collection.reset_members(params[:post_ids])
    end

    private

    def collection_params
      params.permit(:title,
                    :description,
                    :banner_id)
    end
  end
end
