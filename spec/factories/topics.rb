FactoryGirl.define do
  factory :topic do
    title { FFaker::LoremCN.words(3).join }
    description { FFaker::LoremCN.paragraph }

    trait :with_posts do
      posts { create_list(:post, 3) }
    end
  end
end
