class BoardsController < ApplicationController
  before_filter :load_board, except: :create
  layout false, only: :incoming

  def show
    unless logged_in?
      flash.alert = "#{view_context.link_to 'Log in', new_session_from_board_path(@board)} to see and make comments!".html_safe
    end
    # same as for CommitsController#show
    @commits = @board.commits.last_week
    @commits_pr_user = @board.top_committers
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
