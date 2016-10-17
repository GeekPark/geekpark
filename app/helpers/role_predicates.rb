module RolePredicates
  def self.def_predicate(role)
    define_method "#{role}?" do
      role.intern.in? current_roles
    end
  end

  def_predicate :user
  def_predicate :editor
  def_predicate :admin
  def_predicate :dev

  def manager?
    editor? || admin? || dev?
  end
end
