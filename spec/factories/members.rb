FactoryGirl.define do
  factory :member do
    email 'foo@bar.com'
    password 'password'
    password_confirmation 'password'
    username 'foo'
    name 'bar'
    role 'member'
  end
end
