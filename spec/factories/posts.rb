FactoryGirl.define do
  factory :post do
    title { FFaker::LoremCN.words(3).join }
    column
    content_type :plain
    content_source { FFaker::LoremCN.paragraph }
    state :published

    trait :draft do
      state :draft
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
