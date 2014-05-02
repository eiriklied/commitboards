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
    find('ul.commits .image a').click
    expect(current_path).to eql board_commit_path(@board, @commit)
  end

  it 'should be possible to comment on a commit' do

  end

  it 'should be possible to like a commit' do
    pending
  end

end
