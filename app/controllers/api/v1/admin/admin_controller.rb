module API::V1::Admin
  class AdminController < ::API::V1::APIController
    rescue_from ActiveRecord::RecordInvalid do |e|
      error(:invalid_record, e.record.errors, status: :unprocessable_entity)
    end
  end
end
