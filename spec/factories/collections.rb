FactoryGirl.define do
  factory :collection do
    title { FFaker::LoremCN.words(2).join }
    description { FFaker::LoremCN.sentence }

    trait :with_posts do
      posts { create_list(:post, 3) }
    end
  end
end
