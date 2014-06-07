class CommitsController < ApplicationController
  protect_from_forgery with: :null_session # since its an api

  before_filter :load_user_board_from_token, only: :create
  before_filter :load_board, except: :create

  def create
    logger.info "Incoming commit with script version #{request.headers['X-script-version']}"

    success = Commit.create!(commit_params.merge(
      user: @user_board.user,
      board: @user_board.board
    ))
    render text: 'ok'
  end

  def show
    @commit = @board.commits.find_by(sha: params[:id])
    # Same as for BoardsController#show
    @commits = @board.commits.last_week
    @commits_pr_user = @board.top_committers

    if request.xhr?
      render '_show.html.haml', layout: false
    else
      render 'boards/show'
    end
  end


private

  def load_board
    @board = Board.find_by key: params[:board_id]
  end

  def load_user_board_from_token
    @user_board = UserBoardToken.find_by key: params[:commit][:user_board_token]
    if @user_board.blank?
      render nothing: true, status: :forbidden
    end
  end

  def commit_params
    params.require(:commit).permit(:sha, :project, :github_path, :timestamp,
      :email, :name, :message, :image)
  end
end
