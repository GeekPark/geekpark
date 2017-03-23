require 'rails_helper'

RSpec.describe API::V1::Admin::PostsController, type: :controller do
  let(:column) { create(:column) }
  it_behaves_like(:indicable_with_meta, Post, as: :editor)
  it_behaves_like(:destructible, :post, as: :editor)
  it_behaves_like(:showable, :post, as: :editor)
  it_behaves_like(:creatable, Post, as: :editor) do
    let(:query) {
      Hash[
        title: FFaker::LoremCN.word,
        content_source: '',
        column_id: column.id,
        state: 'unpublished'
      ]
    }
  end
  it_behaves_like(:updatable, :post, as: :editor) do
    let(:query) {
      Hash[
        title: '1',
        content_type: 'markdown',
        content_source: '**2**',
        column_id: column.id,
        state: 'published',
      ]
    }
  end
end
