module HasCurrentRoles
  extend ActiveSupport::Concern

  included do |clazz|
    clazz.serialization_scope :current_roles
  end

  def current_roles
    roles = params[:user_roles]&.map(&:intern) || []
    roles.concat(Role.default_roles)
    roles
  end
end
