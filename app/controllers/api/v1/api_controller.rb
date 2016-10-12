module API::V1
  class APIController < ActionController::API
    include HasCurrentRoles
    include APIControllerHelper

    rescue_from CantCantCant::PermissionDenied do
      render plain: 'permission denied', status: 403
    end
  end
end
