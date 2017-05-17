module HasCurrentRoles
  extend ActiveSupport::Concern

  included do |clazz|
    clazz.serialization_scope :current_roles
  end

  def current_roles
    if Rails.env.development? || Rails.env.test?
      roles = params[:roles]&.split&.map(&:intern) || []
    else
      roles = current_user_roles || []
    end
    roles.concat(Role.default_roles)
    roles
  end
end
