require 'spec_helper'

describe 'commits' do
  before :each do
    login_as email: 'jim@test.com'
    @board = Board.create! name: 'My board', owner: User.find_by(email: 'jim@test.com')
  end

  it 'should generate a user_board_key when a user visits a board for the first time' do
    expect(UserBoardToken.count).to eq 0

    visit board_path(@board)

    expect(UserBoardToken.count).to eq 1
    token = extract_token_from_page
    @user_board_token = UserBoardToken.find_by key: token
    expect(@user_board_token.user).to eq User.find_by(email: 'jim@test.com')
    expect(@user_board_token.board).to eq @board
  end

  it 'should not allow commits from unknowns' do
    pending
    visit board_path(@board)
    token = extract_token_from_page
    # commit[sha]=#{commit_sha} -F commit[project]=#{project_name} -F commit[github_path]=#{github_path} -F commit[timestamp]=#{timestamp} -F commit[email]=#{email} -F commit[name]=#{name} -F commit[message]=#{message} -F commit[image]=@#{filename} #{@commits_url}
    page.driver.post(board_commits_path(@board),
      commit: {
        sha: SecureRandom.hex,
        project: 'my-project',
        timestamp: Time.now.to_i,
        user_board_token: token
      }
    )
  end

  it 'should allow commits from an identified user' do
    pending
  end

  def extract_token_from_page
    install_command = page.find('#code-example').value
    install_command =~ /install\/(.*)\s\|\sruby/
    $1
  end
end
