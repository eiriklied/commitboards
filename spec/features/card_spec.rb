require 'rails_helper'

describe 'Card' do
  let(:user)    { User.find_by email: 'jim@test.com' }
  let(:board)   { create :board, owner: user }
  let(:commit)  { board.commits.last }

  before :each do
    login_as email: 'jim@test.com'
    create :commit, user: user, board: board
    visit board_path(board)
  end

  it 'should be possible to open a card for a commit' do
    find('ul.commits .image a').click # actually following the link that is usually fetched with js
    expect(current_path).to eql board_commit_path(board, commit)
  end

  it 'should be possible to comment on a commit', js: true do
    visit board_commit_path(board, commit, _show_commit_card: true)

    fill_in 'comment_body', with: 'Haha nice selfie :+1:!'
    click_on 'add-comment'

    reload board_commit_path(board, commit, _show_commit_card: true)
    expect(page).to have_content 'Haha nice selfie!'
    expect(commit.comments.length).to eql 1
    expect(commit.reload.comments_count).to eql 1 # counter_cache
  end

  #it 'should be possible to edit your own commit comment', js: true  do
    #comment = create :comment, commit: commit, user: user
    #visit board_commit_path(board, commit, _show_commit_card: true)
    #first('.comment').click_on 'edit'
    #save_and_open_page
    #fill_in "comment-#{comment.id}", with: 'new text!'
    #expect(commit.comments.last.body).to eq('new text!')
  #end

  it 'should be possible to delete your own commit comment'
  it 'should be possible to like a commit'

end
