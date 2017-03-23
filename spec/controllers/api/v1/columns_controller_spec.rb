require 'rails_helper'

RSpec.describe API::V1::ColumnsController, type: :controller do
  it_behaves_like(:indicable, Column, as: :editor)
  it_behaves_like(:showable, :column, as: :visitor)
end
