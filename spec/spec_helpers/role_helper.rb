module RoleHelper
  def as(*roles)
    { roles: roles.join(' ') }
  end
end
