FactoryGirl.define do
  factory :column do
    title { FFaker::LoremCN.words(3).join }
    description { FFaker::LoremCN.paragraph }
    content_type :normal
  end
end
