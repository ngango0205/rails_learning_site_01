class Lessons::LikesController < ApplicationController
  before_action :set_lesson

  def create
    @lesson.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html {redirect_to @lesson}
      format.js
    end
  end

  def destroy
    @lesson.likes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html {redirect_to @lesson}
      format.js
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:danger] = t "find_lesson"
    redirect_to lessons_url
  end
end
