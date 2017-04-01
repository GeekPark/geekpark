class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  extend Enumerize

  def self.new_to_old
    all.order(created_at: :desc)
  end

  def self.old_to_new
    all.order(created_at: :asc)
  end

  def self.serialized(**options)
    ser = ActiveModelSerializers::SerializableResource.new(all, options)
    ser.as_json
  end

  def serialized(**options)
    ser = ActiveModelSerializers::SerializableResource.new(self, options)
    ser.as_json
  end
end
