class CommentsController < ApplicationController
  before_filter :require_login
  before_filter :load_board
  before_filter :load_commit
  respond_to :html, :json
  layout false

  def create
    @comment = @commit.comments.build comment_params.merge({ user: current_user })
    @comment.save
    render '_comment'  
  end

  def update
    @comment = @commit.comments.find(params[:id])
    return render nothing: true, status: 401 unless @comment.user  == current_user
    @comment.update(comment_params)
    render '_comment'
  end

private
  def comment_params
    params.require(:comment).permit(:body)
  end


  def load_board
    @board = Board.find_by! key: params[:board_id]
  end

  def load_commit
    @commit = @board.commits.find_by! sha: params[:commit_id]
  end
end
