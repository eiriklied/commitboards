require 'spec_helper'

describe 'dashboard' do
  it 'should require login' do
    visit dashboard_path
    expect(current_path).to eql root_path
    expect(page).to have_selector('.alert')
  end
end
