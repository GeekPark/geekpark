module HasMembers
  extend ActiveSupport::Concern

  class_methods do
    def def_add_members(field: :posts, member_class: Post)
      define_method :add_members do |member_ids|
        container = public_send(field)
        container << member_class.find(member_ids)
      end
    end

    def def_reset_members(field: :posts, member_class: Post)
      define_method :reset_members do |member_ids|
        container = public_send(field)
        container.replace member_class.find(member_ids)
      end
    end
  end
end
