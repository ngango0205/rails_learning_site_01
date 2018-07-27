class NotificationsController < ApplicationController
  before_action :find_notification, only: :show

  def index
    @notifications = Notification.where recipient: current_user
  end

  def show; end

  private

  def find_notification
    @notification = Notification.find_by params[:id]
    redirect_to root_path if @notification.nil?
  end
end
