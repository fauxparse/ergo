FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user.#{n}@example.com" }
    sequence(:avatar) { |n| "http://lorempixel.com/200/200/cats/#{n % 10 + 1}" }
  end
end
