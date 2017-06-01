module Likeable
  extend ActiveSupport::Concern

  include AccountAPIHelper

  class_methods do
    def add_likeable_for
      define_method "like" do |user_id|
        unless find_like(user_id)
          Like.create(user_id: user_id, target: self)
          { message: 'success'}
        else
          { error: 'already liked' }
        end
      end

      define_method "unlike" do |user_id|
        if find_like(user_id)
          find_like(user_id).destroy
          { message: 'success' }
        else
          { error: 'already unliked' }
        end
      end

      define_method "find_like" do |user_id| 
        @action ||= Like.where(user_id: user_id, target: self).first
      end
    end
  end
end
