require 'rails_helper'

describe API::V1::Admin::AdminController, type: :controller do
  controller do
    def raise_recordinvalid
      test_post = Post.new
      test_post.errors.add(:test, "test")
      raise ActiveRecord::RecordInvalid, test_post
    end
  end

  describe "handling ActiveRecord::RecordInvalid exceptions" do
    it "should properly return error info" do
      routes.draw {
        get "raise_recordinvalid" => "api/v1/admin/admin#raise_recordinvalid"
      }
      get :raise_recordinvalid
      expect(response).to be_unprocessable
      result = '{"errors":{"type":"invalid_record",' \
               '"info":{"test":["test"]},"message":null}}'
      expect(JSON.parse(response.body)).to eq(JSON.parse(result))
    end
  end
end
