FactoryGirl.define do
  factory :product do
    title       Faker::Commerce.product_name
    description Faker::Lorem.paragraph 
    price       Faker::Commerce.price.to_i
    category    { create(:category) }
  end

  trait :available do
    status 'available'
  end
end
