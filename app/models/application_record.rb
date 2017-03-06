class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  extend Enumerize
end
