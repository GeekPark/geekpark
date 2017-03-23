module API::V1::Admin
  class AdsController < AdminController
    before_action find_record, only: %i(destroy show update)

    def index
      success do
        paginated_with_meta Ad.all.new_to_old
      end
    end

    def create
      created Ad.create(ad_params)
    end

    def show
      success(serializer: AdminAdSerializer) { @ad }
    end

    def update
      Ad.update_attributes(ad_params)
      updated
    end

    def destroy
      @ad.destroy
      updated
    end

    private

    def ad_params
      params.permit(
        :title,
        :position,
        :link,
        :picture,
        :active_at,
        :active_through
      )
    end
  end
end
