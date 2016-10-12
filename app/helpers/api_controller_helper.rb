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
    head(status: :no_content)
  end
end
