module API::V1::Admin
  class TagsController < AdminController
    api :GET, '/admin/tags/filter', '過濾 tag'
    param :tag, String, desc: 'Some string to search on'
    def filter
      tags = Tag.smart_filter(name: params[:tag])
                .order_by_last_used
                .limit(10)
                .pluck(:name)
      success(tags)
    end
  end
end
