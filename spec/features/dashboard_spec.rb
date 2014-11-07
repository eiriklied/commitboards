require 'rails_helper'

describe 'dashboard' do
  it 'should require login' do
    visit dashboard_path
    expect_logged_out
  end

  it 'should show a users dashboard after logging in' do
    login_as email: 'user@test.com'
    visit dashboard_path
    expect(current_path).to eql dashboard_path
  end

  it 'should send user to front page after logging out' do
    login_as email: 'user@test.com'
    visit dashboard_path
    click_on 'log-out'

    expect(current_path).to eql root_path

    visit dashboard_path
    expect_logged_out
  end

  def expect_logged_out
    expect(current_path).to eql root_path
    expect(page).to have_selector('.alert') # not logged in message
  end
end
