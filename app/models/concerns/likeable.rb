module Likeable
  extend ActiveSupport::Concern

  include AccountAPIHelper

  class_methods do
    def add_likeable
      define_method 'like' do |user_id|
        unless find_like(user_id)
          Like.create(user_id: user_id, target: self)
          return true
        end
      end

      define_method 'unlike' do |user_id|
        if find_like(user_id)
          find_like(user_id).destroy
          return true
        end
      end

      define_method 'find_like' do |user_id|
        @first_like_cached ||= Like.find_by(user_id: user_id, target: self)
      end
    end
  end

  def liked
    !!(Like.find_by(user_id: @instance_options[:user_id], target: object))
  end
end
