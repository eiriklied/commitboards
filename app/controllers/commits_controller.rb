class CommitsController < ApplicationController
  protect_from_forgery with: :null_session # since its an api
  before_filter :load_board

  def create
    render text: 'ok'
  end


private
  def load_board
    @board = Board.find_by!(key: params[:board_id])
  end
end
