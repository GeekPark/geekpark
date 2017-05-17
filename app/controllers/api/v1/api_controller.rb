module API::V1
  class APIController < ActionController::API
    include AccountAPIHelper
    include HasCurrentRoles
    include APIControllerHelper
    include StructuredCache
    extend APIFindModelHelper

    rescue_from CantCantCant::PermissionDenied do |e|
      render plain: "permission denied #{e}", status: 403
    end

    rescue_from ActiveRecord::RecordNotFound do |_|
      render plain: 'not found', status: 404
    end
  end
end
