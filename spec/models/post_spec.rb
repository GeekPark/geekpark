require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  it 'is video iff video_provider is provided' do
    post.meta = { video_provider: :youku }
    expect(post.article?).to be_falsey
    expect(post.video?).to be_truthy

    post.meta = {}
    expect(post.article?).to be_truthy
    expect(post.video?).to be_falsey
  end
end
