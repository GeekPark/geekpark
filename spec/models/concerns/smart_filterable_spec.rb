require 'rails_helper'

describe SmartFilterable do
  before(:all) do
    FactoryGirl.create(:comment)
    FactoryGirl.create(:post)
  end

  it "can filter string correctly" do
    result = Comment.smart_filter(content: "万")
    expect(result).to eq(Comment.all.where('content LIKE ?', '%万%'))
  end

  it "can filter datetime correctly" do
    result = Post.smart_filter(created_at: "today")
    expect(result).to eq(Post.all.where(created_at: \
      Date.today.beginning_of_day..Date.today.end_of_day))
  end

  it "can filter enum correctly" do
    result = Post.smart_filter(state: "unpublished")
    expect(result).to eq(Post.all.where(state: 0))
  end
end
