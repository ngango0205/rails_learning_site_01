class UsersController < ApplicationController
  before_action :user_signed_in?, only: [:edit, :update]
  def show
    @user = User.find_by id: params[:id]
    @lessons = @user.lessons.page(params[:page])
                    .per Settings.page.child_in_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:sucess] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "update"
      redirect_to @user
    else
      redirect_to edit_user_registration_url
    end
  end

  def following
    @title = t "following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.page(params[:page])
                  .per Settings.page.child_in_page
    render :show_follow
  end

  def followers
    @title = t "follower"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
                  .per Settings.page.child_in_page
    render :show_follow
  end

  def search
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page])
                                      .per Settings.page.child_in_page
    return unless request.referrer.include? search_users_url
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end
end
