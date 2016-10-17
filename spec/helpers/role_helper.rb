module RoleHelper
  def as(*roles)
    { user_roles: roles.map(&:intern) }
  end
end
