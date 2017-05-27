FactoryGirl.define do
  factory :order_item do
    order    { create(:order) }
    product  { create(:product) }
    quantity { Faker::Number.between(1, 10) }
    price    { Faker::Commerce.price.to_i }
  end
end
