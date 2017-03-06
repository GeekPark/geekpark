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

  it 'renders markdown' do
    post.content_type = 'markdown'
    post.content_source = '**bold** _italic_ `code`'
    post.save
    expect(post.content).to eq('<p><strong>bold</strong> ' \
                               '<u>italic</u> ' \
                               '<code>code</code></p>' "\n")
  end

  it 'renders plain text' do
    post.content_type = 'plain'
    post.content_source = '*text*'
    post.save
    expect(post.content).to eq('<p>*text*</p>')
  end

  it 'renders html' do
    post.content_type = 'html'
    post.content_source = '*text* <br>'
    post.save
    expect(post.content).to eq('*text* <br>')
  end
end
