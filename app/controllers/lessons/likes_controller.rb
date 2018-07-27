class Lessons::LikesController < ApplicationController
  before_action :set_lesson

  def create
    @lesson.likes.where(user_id: current_user.id).first_or_create
    redirect_to @lesson
  end

  def destroy
    @lesson.likes.where(user_id: current_user.id).destroy_all
    redirect_to @lesson
  end

  private

  def set_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:danger] = t "find_lesson"
    redirect_to lessons_url
  end
end
