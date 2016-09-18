FactoryGirl.define do
  factory :topic do
    title { FFaker::LoremCN.words(3).join }
    column
    content { FFaker::LoremCN.paragraph }
    state :published

    trait :draft do
      state :draft
    end
    trait :empty do
      content ''
    end
  end
end
