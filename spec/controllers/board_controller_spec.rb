require 'rails_helper'

describe BoardsController do
  let(:board) { Board.first }
  
  before :all do
    create :user_with_board
    create_list :user_with_commits, 4
  end

  after :all do
    User.destroy_all
    Board.destroy_all
  end
  
  describe 'GET show' do
    
    it 'responds with map of top three users with the most commits the last week' do
      get :show, id: board.key
      expect(assigns(:commits_pr_user).length).to eq(3)
    end

    it 'sets the top user correctly' do
      get :show, id: board.key
      expect(assigns(:commits_pr_user).keys[0]).to eq(User.last)
      expect(assigns(:commits_pr_user).values[0]).to eq(8) 
    end 
    
    it 'sets the third user correctly' do
      get :show, id: board.key
      expect(assigns(:commits_pr_user).keys[2]).to eq(User.third)
      expect(assigns(:commits_pr_user).values[2]).to eq(4) 
    end

    it 'should not consider commits that was made more than a week ago' do
      create :old_commit, board: board, user: User.last
      get :show, id: board.key
      expect(assigns(:commits_pr_user).values[0]).to eq(8)
    end
  end

end
