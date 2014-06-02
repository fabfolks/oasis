FactoryGirl.define do
  factory :member do
    email 'foo@bar.com'
    password 'password'
    password_confirmation 'password'

  end

  factory :house do
    name 'house'
  end
end
