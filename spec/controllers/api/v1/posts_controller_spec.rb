require 'rails_helper'

RSpec.describe API::V1::PostsController, type: :controller do
  # it_behaves_like(:indicable, Post, as: :editor)
  it_behaves_like(:showable, :post, as: :visitor)
end
