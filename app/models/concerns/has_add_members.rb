module HasAddMembers
  extend ActiveSupport::Concern

  class_methods do
    def def_add_members(into: :posts)
      define_method :add_members do |post_ids|
        container = public_send(into)
        container << Post.find(post_ids)
      end
    end
  end
end
