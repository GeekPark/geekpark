module APIControllerHelper
  def success(object, **opts)
    render json: object, status: :ok, **opts
  end

  def created(object)
    render(json: {
             id: object.id
           },
           status: :created)
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
end
