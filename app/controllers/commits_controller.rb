class CommitsController < ApplicationController
  protect_from_forgery with: :null_session # since its an api

  before_filter :load_user_board

  def create
    logger.info "Incoming commit with script version #{request.headers['X-script-version']}"

    success = Commit.create!(commit_params.merge(
      user: @user_board.user,
      board: @user_board.board
    ))
    render text: 'ok'
  end


private
  def load_user_board
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
