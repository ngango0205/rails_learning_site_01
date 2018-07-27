class NotificationsController < ApplicationController
  before_action :find_notification, only: [:show, :update_seen]

  def index
    @notifications = Notification.where recipient: current_user
  end

  def show; end

  def update_seen
    @lesson = if @notification.notifiable.is_a? Lesson
                @notification.notifiable
              else
                @notification.notifiable.lesson
              end
    @notification.update_attribute(:read_at, Time.zone.now) unless @notification
                                                                   .read_at.nil?
    redirect_to @lesson
  end

  def refresh_part
    respond_to do |format|
      format.js {render action: "refresh_part.js"}
    end
  end

  private

  def find_notification
    @notification = Notification.find_by params[:id]
    redirect_to root_path if @notification.nil?
  end
end
