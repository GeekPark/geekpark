require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  it 'is video iff video_provider is provided' do
    topic.meta = { video_provider: :youku }
    expect(topic.article?).to be_falsey
    expect(topic.video?).to be_truthy

    topic.meta = {}
    expect(topic.article?).to be_truthy
    expect(topic.video?).to be_falsey
  end
end
