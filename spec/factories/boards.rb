FactoryGirl.define do

  factory :board do
    sequence(:name) { |n| "Board#{n}" }
    association :owner, factory: :user 
  end

end
