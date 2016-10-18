require 'rails_helper'

RSpec.describe API::V1::ColumnsController, type: :controller do
  let(:column) { create(:column) }

  it_behaves_like(:indicable, Column)
  it_behaves_like(:creatable, Column, as: :admin) do
    let(:query) {
      Hash[
        title: FFaker::LoremCN.word,
        description: FFaker::LoremCN.words(10).join,
        meta: {
          'theme_color': 'green'
        }
      ]
    }
  end
end
