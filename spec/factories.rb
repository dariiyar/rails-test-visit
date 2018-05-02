FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    number { FFaker::IdentificationBR.rg }
    date { FFaker::Time.date }
    description { FFaker::Lorem.sentence }
  end
end