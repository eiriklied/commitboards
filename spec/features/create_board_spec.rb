require 'spec_helper'

describe 'create a board' do

  it 'should let users create boards from the front page' do
    visit root_path
    fill_in 'board_name', with: 'Team 1 board'
    click_on 'create_board'

    expect(Board.count).to eq(1)
    @board = Board.last

    expect(current_path).to eq(board_path(@board))
  end
end
