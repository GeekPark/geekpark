require 'rails_helper'

RSpec.describe API::V1::ColumnsController, type: :controller do
  it_behaves_like(:indicable, Column, as: :editor)
  it_behaves_like(:destructible, :column, as: :admin)
  it_behaves_like(:showable, :column, as: :visitor)
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

  describe 'add_members' do
    it 'adds members successfully' do
      n = 3
      column = create(:column)
      topics = create_list(:topic, n)

      expect {
        post :add_members,
             params: {
               column_id: column.id,
               topic_ids: topics.pluck(:id),
               **as(:editor),
               format: :json
             }
        expect(response).to be_no_content
      }.to change { column.topics.count }.by(n)
      expect(column.topics).to include(*topics)
    end
  end
end
