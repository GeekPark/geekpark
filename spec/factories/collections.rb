FactoryGirl.define do
  factory :collection do
    title { FFaker::LoremCN.words(2).join }
    description { FFaker::LoremCN.sentence }

    trait :with_topics do
      topics { create_list(:topic, 3) }
    end
  end
end
