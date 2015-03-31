require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :sitcom do
    sequence(:name) { |n| "Futurama#{n}" }
    description "The funniest show since The Simpsons"
    start_year 2001
    user
  end
end
