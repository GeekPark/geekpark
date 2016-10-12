module Role
  def self.visitor
    :visitor
  end

  def self.default_roles
    [visitor]
  end
end
