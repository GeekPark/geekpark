module Countable
  extend ActiveSupport::Concern

  class_methods do
    def add_instance_counter_for(action)
      action = action.to_s

      has_many(:"#{action}_counts",
               as: :countable,
               class_name: 'Count',
               dependent: :destroy,
               inverse_of: :countable)

      define_method "incr_#{action}_count" do |count = 1|
        Count.create(countable: self, count: count)
      end

      define_singleton_method "order_by_#{action}_count" do
          |length = 1.week, desc = true|
        all.joins(:"#{action}_counts")
           .where(published_at: length.ago..Time.now)
           .group(:id)
           .order("sum(counts.count) #{'desc' if desc}")
      end

      define_singleton_method "count_#{action.pluralize}" do |length = 1.week|
        all.joins(:"#{action}_counts")
           .where(published_at: length.ago..Time.now)
           .sum('counts.count')
      end
    end
  end
end
