FactoryGirl.define do

  factory :commit do 
    user
    board
    sha SecureRandom.hex
    project 'my-project'
    timestamp Time.now.to_i
    image File.new('spec/support/files/image.jpg')

    factory :old_commit do
      timestamp Time.now - 2.week
    end
  end

end
