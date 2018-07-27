class LessonsController < ApplicationController
  def index
    @lessons = current_user.lessons.page(params[:page])
                           .per Settings.page.child_in_page
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      @lesson.user.followers.each do |user|
        create_notification user, @lesson
      end
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

  def search
    @search = Lesson.where("name LIKE ?", "%#{params[:search]}%")
                    .page(params[:page]).per Settings.page.child_in_page
  end

  private

  def lesson_params
    params.require(:lesson).permit :name, :description, :content
  end
end
