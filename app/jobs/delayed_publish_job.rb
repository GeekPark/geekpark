class DelayedPublishJob < ApplicationJob
  queue_as :default

  rescue_from ActiveRecord::RecordNotFound do
    # The post seems go disappeared, do nothing then
  end

  def perform(record)
    return if record.published?
    record.publish!
  end
end
