require 'rails_helper'

describe User do
  it 'should always downcase email' do
    @user = User.new(email: 'Tom.Doe@test.com')
    expect(@user.email).to eq 'tom.doe@test.com'
  end
end
