require 'spec_helper'

describe User do
  it 'should always downcase email' do
    @user = User.new(email: 'Tom.Doe@test.com')
    @user.valid? # trigger callback
    expect(@user.email).to eq 'tom.doe@test.com'
  end
end
