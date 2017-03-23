FactoryGirl.define do
  factory :post do
    title { FFaker::LoremCN.words(3).join }
    column
    content_type :plain
    content_source { FFaker::LoremCN.paragraph }
    state :published
    published_at { 1.day.ago }

    trait :draft do
      state :unpublished
    end
    trait :empty do
      content ''
    end
    trait :markdown do
      content_source '## *hello* _world_'
      content_type :markdown
    end
  end
end
