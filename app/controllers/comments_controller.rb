class CommentsController < ApplicationController
  before_filter :require_login
  before_filter :load_board
  before_filter :load_commit

  def create
    @comment = @commit.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    render 'create.js.erb'
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
