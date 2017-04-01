module API::V1
  class CollectionsController < APIController
    resource_description { short '合集，用於特別目的，與文章呈多對多關係' }
    before_action find_record,
                  only: %i(destroy show update reset_members add_members)

    api :GET, '/collections', 'Get a list of all collections'
    def index
      success(Collection.all)
    end

    api :GET, '/collections/:id', 'View a collection and its contents'
    def show
      success(@collection)
    end
  end
end
