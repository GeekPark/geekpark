module API::V1::Admin
  class TagsController < AdminController
    api :GET, '/admin/tags', 'List or filter on tag'
    param :name, String, desc: 'Some string to search on'
    def index
      tags = Tag.smart_filter(params.permit(:name))
                .order_by_last_used
                .limit(10)
                .pluck(:name)

      success(tags)
    end
  end
end
