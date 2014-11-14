FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "User#{n}" }
    email 'ola@nordmann.no'
    github_url 'test'
    avatar_url 'test'

    factory :user_with_board do
      after(:create) do |user|
        create :board, owner: user
      end
    end

    factory :user_with_commits do
      
      transient do
        sequence(:count) { |n| n*2 }
      end

      after(:create) do |user, evaluator|
        create_list :commit, evaluator.count, user: user, board: Board.first
      end

    end
  end
end
