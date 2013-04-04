FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password 'secret_word'
  end
end
