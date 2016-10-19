require 'rails_helper'

RSpec.describe Column, type: :model do
  let!(:column) { create(:column) }

  describe 'add members' do
    it 'correctly add members' do
      n = 3
      create_list(:topic, 3, column: column)
      topics = create_list(:topic, n)
      expect {
        column.add_members(topics.pluck(:id))
      }.to change { column.topics.count }.by(n)
      expect(column.topics).to include(*topics)
    end

    it 'denies invalid members' do
      create_list(:topic, 3, column: column)
      topics = create_list(:topic, 4)
      expect {
        expect {
          column.add_members([*topics.pluck(:id), 999_999_999 + 1])
        }.to raise_error(ActiveRecord::RecordNotFound)
      }.not_to change { column.topics.count }
    end
  end
end
