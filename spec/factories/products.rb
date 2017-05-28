FactoryGirl.define do
  factory :product do
    title       { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price       { Faker::Commerce.price.to_i }
    category    { create(:category) }
    status      { 'available' }
  end

  Product.statuses.keys.each do |type|
    trait type do
      status type.to_s
    end
  end
end
