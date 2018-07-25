class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      redirect_to @comment.lesson
    else
      flash[:danger] = t "create_comment_fail"
      redirect_to current_user
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id, :lesson_id
  end
end
