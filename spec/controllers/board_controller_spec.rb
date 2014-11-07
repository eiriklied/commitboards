require 'rails_helper'

describe BoardsController do
    
  before :each do
    create_list :user, 4
  end

  let(:board)       { create :board, owner: User.first }
  
  describe 'GET show' do
    
    before :each do
      4.times do |index| 
        create_list :commit, (index+1)*2, board: board, user: User.find(index+1)
      end
    end

    it 'responds with map of top three users with the most commits the last week' do
      get :show, id: board.key
      expect(assigns(:commits_pr_user).length).to eq(3)
    end

    it 'sets the top user correctly' do
      get :show, id: board.key
      expect(assigns(:commits_pr_user).keys[0]).to eq(User.fourth)
      expect(assigns(:commits_pr_user).values[0]).to eq(8) 
    end 
    
    it 'sets the third user correctly' do
      get :show, id: board.key
      expect(assigns(:commits_pr_user).keys[2]).to eq(User.second)
      expect(assigns(:commits_pr_user).values[2]).to eq(4) 
    end

    it 'should not consider commits that was made more than a week ago' do
      create :old_commit, board: board, user: User.last
      get :show, id: board.key
      expect(assigns(:commits_pr_user).values[0]).to eq(8)
    end
  end

end
