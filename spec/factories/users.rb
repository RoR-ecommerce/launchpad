FactoryGirl.define do
  factory :user do
    full_name { Faker::Name.name }
    email     { Faker::Internet.email }
    password  'secret_word'
  end
end
