class CommentsController < ApplicationController
  before_filter :require_login
  before_filter :load_board
  before_filter :load_commit
  respond_to :html, :json
  layout false

  def create
    @comment = @commit.comments.build comment_params.merge({ user: current_user })
    if @comment.save
      render '_comment'  
    else
      render nothing: true, status: 401
    end
  end

  def update
    @comment = @commit.comments.find(params[:id])
    return render nothing: true, status: 401 unless @comment.user  == current_user
    if @comment.update(comment_params)
      render '_comment'
    else
      render nothing: true, status: 401
    end
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
