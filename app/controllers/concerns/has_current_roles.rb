module HasCurrentRoles
  extend ActiveSupport::Concern

  included do |clazz|
    clazz.serialization_scope :current_roles
  end

  def current_roles
    params[:user_roles] || Role.default_roles
  end
end
