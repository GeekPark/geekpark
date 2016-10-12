module HasCurrentRoles
  extend ActiveSupport::Concern

  def current_roles
    params[:user_roles] || Role.default_roles
  end
end
