FactoryGirl.define do
  factory :tag do
    name { FFaker::LoremCN.words(4).join }
  end
end
