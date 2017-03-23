module API::V1
  class AdsController < APIController
    def index
      success do
        Ad.currently_active.group_by(&:position)
      end
    end
  end
end
