class AdminAdSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :position,
             :link,
             :picture,
             :active_at,
             :active_through,
             :is_active

  def is_active
    object.active?
  end
end
