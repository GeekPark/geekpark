class ApplicationSerializer < ActiveModel::Serializer
  include RolePredicates
  include Likeable
end
