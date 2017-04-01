module API::V1
  class AdsController < APIController
    resource_description do
      short 'User API about Advertisements'
    end

    api :GET, '/ads', 'Get currently active ads grouped by positions'
    def index
      success do
        Ad.currently_active.group_by(&:position)
      end
    end
  end
end
