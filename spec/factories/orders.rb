FactoryGirl.define do
  factory :order do
    name    { Faker::Name.name }
    email   { Faker::Internet.email }
    address { Faker::Address.street_address }
    tel     { Faker::PhoneNumber.cell_phone }
    remark  { Faker::Lorem.paragraph }
    comment { Faker::Lorem.paragraph }
  end

  Settings.order.statuses.keys.each do |type|
    trait type do
      status type
    end
  end

  trait :with_one_item do
    after(:create) { |order| create(:order_item, order: order) }
  end

  trait :with_order_items do
    after(:create) do |order|
      rand(1..10).times { create(:order_item, order: order) }
    end
  end
end
