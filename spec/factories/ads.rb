FactoryGirl.define do
  factory :ad do
    title { FFaker::LoremCN.words(3).join }
    position { Ad.position.values.sample }
    link 't66y.com'
    active_at      { Time.now - 3.days }
    active_through { Time.now - 1.minute }

    trait :active do
      active_at      { Time.now - 3.days }
      active_through { Time.now + 3.days }
    end
    trait :expired do
      active_at      { Time.now - 6.days }
      active_through { Time.now - 3.days }
    end
    trait :planned do
      active_at      { Time.now + 3.days }
      active_through { Time.now + 6.days }
    end
  end
end
