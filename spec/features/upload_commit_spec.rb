require 'rails_helper'

describe 'commits' do
  let(:user)   { User.find_by(email: 'jim@test.com') }
  let(:board)  { create :board, owner: user  }

  before :each do
    login_as email: 'jim@test.com'
  end

  it 'should generate a user_board_key when a user visits a board for the first time' do
    expect(UserBoardToken.count).to eq 0
    visit board_path(board)

    expect(UserBoardToken.count).to eq 1
    token = extract_token_from_page
    user_board_token = UserBoardToken.find_by key: token
    expect(user_board_token.user).to eq user
    expect(user_board_token.board).to eq board
  end

  it 'should not allow commits from unknowns' do
    page.driver.post(board_commits_path(board),
      commit: {
        sha: SecureRandom.hex,
        project: 'my-project',
        timestamp: Time.now.to_i,
        user_board_token: nil  # LOOK: no token!!
      }
    )
    expect(page.status_code).to eq 403 # forbidden
  end

  it 'should allow commits from an identified user' do
    visit board_path(board)
    token_from_page = extract_token_from_page

    expect(all('ul.commits li').count).to eql 0

    page.driver.post(board_commits_path(board),
      commit: {
        sha: SecureRandom.hex,
        project: 'my-project',
        timestamp: Time.now.to_i,
        user_board_token: token_from_page,
        image: file_upload('spec/support/files/image.jpg')
      }
    )

    expect(page.status_code).to eql 200

    visit board_path(board)
    expect(all('ul.commits li').count).to eql 1
  end

  # since we are using the driver instead of vanilla capybara,
  # we borrowed some code from capybara at
  # https://github.com/jnicklas/capybara/blob/master/lib/capybara/rack_test/form.rb#L44
  def file_upload(path)
    content_type = MIME::Types.type_for(path).first.to_s
    Rack::Test::UploadedFile.new(path, content_type)
  end

  def extract_token_from_page
    install_command = page.find('#code-example').value
    install_command =~ /install\/(.*)\s\|\sruby/
    $1
  end
end
