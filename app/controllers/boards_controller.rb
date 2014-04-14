class BoardsController < ApplicationController
  before_filter :load_board, except: :create
  layout false, only: :incoming

  def show
  end

  def incoming
    @last_commit = @board.commits.find_by(sha: params[:commit_sha])
    if  @last_commit.blank?
      render nothing: true
    else
      @incoming_commits = @board.commits.where('committed_at > ?', @last_commit.committed_at)
    end
  end

  def create
    @board = Board.new(board_params.merge(owner: current_user))
    if @board.save
      redirect_to board_url(@board)
    else
      redirect_to root_url
    end
  end

private
  def load_board
    @board = Board.find_by!(key: params[:id])
  end

  def board_params
    params.require(:board).permit(:name)
  end
end
