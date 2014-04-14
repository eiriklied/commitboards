require 'spec_helper'

describe 'create a board' do

  before :each do
    login_as email: 'jim@test.com'
  end

  it 'should let users create boards from the front page' do
    visit root_path
    fill_in 'board_name', with: 'Team 1 board'
    click_on 'create_board'

    expect(Board.count).to eq(1)
    @board = Board.last

    expect(current_path).to eq(board_path @board)
    expect(@board.owner).to eq User.find_by(email: 'jim@test.com')
  end
end
