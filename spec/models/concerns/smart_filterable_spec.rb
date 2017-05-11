require 'rails_helper'

describe SmartFilterable do

	it "can filter string correctly" do
		result = Comment.smart_filter(content: "test")
		expect(result.to_sql).to eq(Comment.all.where('content LIKE ?', '%test%').to_sql)
	end

	it "can filter datetime correctly" do
		result = Tag.smart_filter(created_at: "today")
		expect(result.to_sql).to eq(Tag.all.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day).to_sql)
	end

	it "can filter enum correctly" do
		result = Post.smart_filter(state: "unpublished")
		expect(result.to_sql).to eq(Post.all.where(state: 0).to_sql)
	end
end