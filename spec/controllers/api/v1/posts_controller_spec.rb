require 'rails_helper'

RSpec.describe API::V1::PostsController, type: :controller do
  let(:column) { create(:column) }
  it_behaves_like(:indicable, Post, as: :editor)
  it_behaves_like(:destructible, :post, as: :editor)
  it_behaves_like(:showable, :post, as: :visitor)
  it_behaves_like(:creatable, Post, as: :editor) do
    let(:query) {
      Hash[
        title: FFaker::LoremCN.word,
        content: '',
        column_id: column.id,
        state: 'draft',
      ]
    }
  end
  it_behaves_like(:updatable, :post, as: :editor) do
    let(:query) {
      Hash[
        title: '1',
        content: '2',
        column_id: column.id,
        state: 'published',
      ]
    }
  end
end
