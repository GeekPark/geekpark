module HasResetMembers
  extend ActiveSupport::Concern

  class_methods do
    def def_reset_members(into: :posts)
      define_method :reset_members do |post_ids|
        container = public_send(into)
        container.replace Post.find(post_ids)
      end
    end
  end
end
