FactoryGirl.define do
  factory :comment do
    content     { FFaker::LoremCN.words(3).join }
    commentable { create(:post) }

    trait :for_ad do
      commentable { create(:ad) }
    end
  end
end
