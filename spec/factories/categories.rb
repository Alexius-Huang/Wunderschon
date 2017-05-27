FactoryGirl.define do
  factory :category do
    title       { Faker::Commerce.department }
    description { Faker::Lorem.paragraph }
  end
end
