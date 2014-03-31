class BoardsController < ApplicationController
  before_filter :load_board, except: :create

  def show
  end

  def create
    @board = Board.new(params.require(:board).permit(:name))
    if @board.save
      redirect_to board_url(@board)
    else
      redirect_to root_url
    end
  end

  def install
    render 'scripts/project_install.rb.erb', layout: false
  end

private
  def load_board
    @board = Board.find_by!(key: params[:id])
  end
end
