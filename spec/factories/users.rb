require 'faker'

FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.last_name}
    email {'ab@gmail.com'}
    password {'1234567'}
    password_confirmation {'1234567'}
  end
end
