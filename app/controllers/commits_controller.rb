class CommitsController < ApplicationController
  protect_from_forgery with: :null_session # since its an api
  before_filter :load_board

  def create
    success = @board.commits.create!(commit_params)
    render text: 'ok'
  end


private
  def load_board
    @board = Board.find_by!(key: params[:board_id])
  end

  def commit_params
    params.require(:commit).permit(:sha, :project, :timestamp,
      :email, :name, :message, :image)
  end
end
