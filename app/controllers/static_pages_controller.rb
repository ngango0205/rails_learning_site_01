class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @followed = Array.new
    current_user.following.each do |user|
      @followed += user.lessons
    end
    @followed_lessons = @followed.uniq.sort_by(&:created_at)
  end

  def about; end

  def help; end

  def contact; end
end
