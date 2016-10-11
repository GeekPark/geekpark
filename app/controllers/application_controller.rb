class ApplicationController < ActionController::Base
  include HasCurrentRoles

  protect_from_forgery with: :exception

  rescue_from CantCantCant::PermissionDenied do
    render plain: 'permission denied', status: 403
  end
end
