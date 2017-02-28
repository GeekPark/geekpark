module APIControllerHelper
  def success(object = nil, **opts)
    object = yield if block_given?
    render json: object, status: :ok, **opts
  end

  def created(object = nil)
    object = yield if block_given?
    render(json: { id: object.id }, status: :created)
  end

  def updated
    head(:no_content)
  end

  def variable_result(*vars, **keywords)
    result = {}
    vars.each do |k|
      v = instance_variable_get("@#{k}")
      result[k] = v if v
    end

    keywords.each do |k, v|
      result[k] = v if v
    end
    success(result)
  end

  def paginated(collection = nil, per = 10)
    collection = yield if block_given?
    page = params[:page] if defined? params
    per  = params[:per] || per if defined? params
    collection.page(page || 1).per([per, 100].min)
  end

  def paginated_with_meta(collection = nil, per = 10, &block)
    data = paginated(collection, per, &block)

    {
      meta: {
        current_page: data.current_page,
        total_pages: data.total_pages,
        total_count: data.total_count
      },
      data: data
    }
  end
end
