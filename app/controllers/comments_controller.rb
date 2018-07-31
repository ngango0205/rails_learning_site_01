class CommentsController < ApplicationController
  def index
    @lesson = Lesson.find params[:lesson_id] if params[:lesson_id]
    @comments = @lesson.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new comment_params
    @lesson = @comment.lesson
    if @comment.save
      create_notification @comment.lesson.user, @comment
      respond_to do |format|
        format.html{redirect_to @lesson}
        format.js
      end
    else
      flash[:danger] = t "create_comment_fail"
      redirect_to @comment.lesson
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id, :lesson_id
  end
end
