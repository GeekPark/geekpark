module API::V1
  class APIController < ActionController::API
    include HasCurrentRoles
    include APIControllerHelper

    rescue_from CantCantCant::PermissionDenied do |e|
      render plain: "permission denied #{e}", status: 403
    end
  end
end
