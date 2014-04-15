class CommitsController < ApplicationController
  protect_from_forgery with: :null_session # since its an api

  def create
    logger.info "Incoming commit with script version #{request.headers['X-script-version']}"
    @user_board = UserBoardToken.find_by! key: params[:commit][:user_board_token]
    success = Commit.create!(commit_params.merge(
      user: @user_board.user,
      board: @user_board.board
    ))
    render text: 'ok'
  end


private
  def commit_params
    params.require(:commit).permit(:sha, :project, :github_path, :timestamp,
      :email, :name, :message, :image)
  end
end
