class BoardsController < ApplicationController
  before_filter :load_board
  
  def show
  end

  def install
    render 'scripts/project_install.rb.erb'
  end

private
  def load_board
    @board = Board.find_by!(key: params[:id])
  end
end