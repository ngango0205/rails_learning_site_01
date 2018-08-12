class SearchController < ApplicationController
  def index
    @s = Lesson.ransack(params[:p])
    @search = @s.result.page(params[:page]).per Settings.page.child_in_page
    @sn = User.ransack(params[:p])
    @search_name = @sn.result.page(params[:page]).per Settings.page.child_in_page
    if request.referrer.include? search_url
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
