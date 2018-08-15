class LessonsController < ApplicationController
  before_action :user_signed_in?, only: [:create]

  def index
    @lessons = current_user.lessons.page(params[:page])
                           .per Settings.page.child_in_page
  end

  def new
    @all_category = Category.all
    @lesson = Lesson.new
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      create_notifications @lesson.user.followers, t("post"), @lesson
      redirect_to @lesson
    else
      flash.now[:danger] = t "create_lesson_fail"
      render :new
    end
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
    return if @lesson
    flash.now[:danger] = t "show_lesson_fail"
    redirect_to lessons_path
  end

  private

  def lesson_params
    params.require(:lesson).permit :name, :description, :content, :category_id,
      :url, :picture
  end
end
