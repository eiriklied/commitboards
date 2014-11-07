FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "User#{n}" }
    email 'ola@nordmann.no'
    github_url 'test'
    avatar_url 'test'
  end

end
