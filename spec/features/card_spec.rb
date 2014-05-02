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
    find('ul.commits .image a').click # actually following the link that is usually fetched with js
    expect(current_path).to eql board_commit_path(@board, @commit)
  end

  it 'should be possible to comment on a commit' do
    visit board_commit_path(@board, @commit)

    fill_in 'comment_body', with: 'Haha nice selfie!'
    click_on 'add-comment'

    reload board_commit_path(@board, @commit)
    expect(page).to have_content 'Haha nice selfie!'
    expect(@commit.comments.length).to eql 1
    expect(@commit.reload.comments_count).to eql 1 # counter_cache
  end

  it 'should be possible to edit your own commit comment'
  it 'should be possible to delete your own commit comment'
  it 'should be possible to like a commit'

end
