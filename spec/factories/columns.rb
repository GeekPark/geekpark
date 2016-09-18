FactoryGirl.define do
  factory :column do
    title { FFaker::LoremCN.words(3).join }
    description { FFaker::LoremCN.paragraph }
    type :normal
  end
end
