class StaticPagesController < ApplicationController
  def home
    redirect_to user_home_url if logged_in?
  end

  def about; end

  def help; end

  def contact; end

  def user_home
    return unless logged_in?
    @followed = current_user.following.map &:lessons
    @followed_lessons = @followed.uniq.sort_by &:created_at
  end
end
