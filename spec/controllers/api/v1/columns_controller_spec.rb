require 'rails_helper'

RSpec.describe API::V1::ColumnsController, type: :controller do
  it_behaves_like(:indicable, Column, as: :editor)
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

  it_behaves_like(:updatable, :column, as: :admin) do
    let(:query) {
      Hash[
        title: '1',
        description: '2',
        meta: {
          'theme_color': 'yellow'
        }
      ]
    }
  end

  it_behaves_like(:destructible, :column, as: :admin)
end
