module API::V1
  class CollectionsController < APIController
    before_action :find_collection,
                  only: %i(destroy show update reset_members add_members)

    def index
      success(Collection.all)
    end

    def create
      collection = Collection.create(*collection_params)
      created(collection)
    end

    def destroy
      @collection.destroy
      updated
    end

    def show
      success(@collection)
    end

    def update
      @collection.update_attributes(collection_params)
      updated
    end

    def reset_members
      @collection.reset_members(params[:topic_ids])
    end

    def add_members
      @collection.add_members(params[:topic_ids])
    end

    private

    def find_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:title)
            .permit(:description, :banner, :banner_mobile, :meta)
    end
  end
end
