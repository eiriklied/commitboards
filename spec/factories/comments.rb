FactoryGirl.define do

  factory :comment do
    user
    commit
    sequence(:body) { |n| "This is the #{n}th comment." }
  end

end
