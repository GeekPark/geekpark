module API::V1
  class CollectionsController < APIController
    def index
      collections = Collection.all
      render(json: collections)
    end
  end
end
