class AdminAdSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :position,
             :link,
             :cover_url,
             :active_at,
             :active_through,
             :is_active

  def is_active
    object.active?
  end
end
