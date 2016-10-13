module RolePredicates
  def manager?
    :manager.in? current_roles
  end

  def admin?
    :admin.in? current_roles
  end

  def developer?
    :developer.in? current_roles
  end
end
