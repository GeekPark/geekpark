require 'rails_helper'

RSpec.describe Collection, type: :model do
  let!(:collection) { create(:collection, :with_topics) }

  describe 'reset_members' do
    it 'reset members correctly' do
      n = 2
      some_topics = create_list(:topic, n).pluck(:id)

      collection.reset_members(some_topics)

      expect(collection.topics.count).to eq(n)
      expect(collection.topics.pluck(:id)).to match_array(some_topics)
    end

    it 'reject invalid members' do
      topic = create(:topic)
      expect {
        expect {
          collection.reset_members([topic.id, 999_999])
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.not_to change { collection.topics.count }
    end
  end


  describe 'add_members' do
    it 'add members correctly' do
      n = 3
      topic = create_list(:topic, n)
      expect {
        collection.add_members([topic.pluck(:id)])
      }.to change { collection.topics.count }.by(3)
    end

    it 'reject invalid members' do
      topic = create(:topic)
      expect {
        expect {
          collection.add_members([topic.id, 999_999])
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.not_to change { collection.topics.count }
    end
  end
end
