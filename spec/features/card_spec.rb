require 'spec_helper'

describe 'Card' do
  before :each do
    login_as email: 'jim@test.com'
    @user = User.find_by(email: 'jim@test.com')
    @board = Board.create! name: 'My board', owner: @user
    @commit = create_commit(@board, @user)
    visit board_path(@board)
  end

  it 'should be possible to open a card for a commit' do

    link_to_commit = find('ul.commits .image a')[:href]

    expect(link_to_commit).to eql board_commit_path(@board, @commit)
  end
end
