require 'rails_helper'

describe Tag do
  context "touch" do
    it "should insert into tags table correctly" do
      expect {
        Tag.touch(%w[a b])
      }.to change { Tag.count }.by(2)
    end

    it "should properly increase page_count" do
      Tag.touch(%w[a b])
      expect(Tag.all.map(&:post_count)).to eq([1, 1])
    end
  end

  context "untouch" do
    it "should decrease post_count correctly" do
      Tag.touch(%w[a b])
      Tag.untouch(%w[a b])
      expect(Tag.all.map(&:post_count)).to eq([0, 0])
    end
  end
end
