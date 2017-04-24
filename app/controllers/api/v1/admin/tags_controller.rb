module API::V1::Admin
  class TagsController < AdminController
    def filter
      tags = Tag.smart_filter(name: params[:tag])
                .order_by_last_used
                .limit(10)
                .pluck(:name)
      success(tags)
    end
  end
end
