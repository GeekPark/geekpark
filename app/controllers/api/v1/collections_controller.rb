module API::V1
  class CollectionsController < APIController
    before_action :find_collection, only: %i(destroy show)

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
