require 'spec_helper'

describe BoardsController do

  before :each do
    @user1 = User.create!(name: 'User1', email: 'ola@nordmann.no', github_url: 'test', avatar_url: 'test')
    @user2 = User.create!(name: 'User2', email: 'ola@nordmann.no', github_url: 'test', avatar_url: 'test')
    @user3 = User.create!(name: 'User3', email: 'ola@nordmann.no', github_url: 'test', avatar_url: 'test')
    @user4 = User.create!(name: 'User4', email: 'ola@nordmann.no', github_url: 'test', avatar_url: 'test')

    @board = Board.create!(id: 1, name: 'Test', owner: @user1)    
  end

  describe 'GET show' do
    it 'responds with map of top three users with the most commits the last week' do
      create_multiple_commits(@board, @user1, 5);   
      create_multiple_commits(@board, @user2, 2);
      create_multiple_commits(@board, @user3, 10);
      create_multiple_commits(@board, @user4, 3);

      get :show, id: @board.key
      commits_pr_user =  assigns(:commits_pr_user)
      expect(commits_pr_user.length).to eq(3)

      expect(commits_pr_user.keys[0]).to eq(@user3)
      expect(commits_pr_user.values[0]).to eq(10)

      expect(commits_pr_user.keys[1]).to eq(@user1)
      expect(commits_pr_user.values[1]).to eq(5)

      expect(commits_pr_user.keys[2]).to eq(@user4)
      expect(commits_pr_user.values[2]).to eq(3)
    end

    it 'should not consider commits that was made more than a week ago' do
      create_multiple_commits(@board, @user2, 3)
      create_multiple_commits(@board, @user1, 2)
      commit = create_commit(@board, @user1)
      commit.committed_at = Time.now - 2.week
      commit.save!

      get :show, id: @board.key

      commits_pr_user =  assigns(:commits_pr_user)
      expect(commits_pr_user.length).to eq(2)

      expect(commits_pr_user.keys[0]).to eq(@user2)
      expect(commits_pr_user.values[0]).to eq(3)

      expect(commits_pr_user.keys[1]).to eq(@user1)
      expect(commits_pr_user.values[1]).to eq(2)
    end
  end


  private

  def create_multiple_commits(board, user, number_of_commits)
    number_of_commits.times do
      create_commit(board, user)
    end
  end

end