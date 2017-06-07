# frozen_string_literal: true
FactoryGirl.define do
  factory :category do
    title       { Faker::Commerce.department(1) }
    description { Faker::Lorem.paragraph }
  end

  trait :with_products do
    after(:create) do |category|
      rand(1..10).times { create(:product, category: category) }
    end
  end
end
