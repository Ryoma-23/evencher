class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_user_path(user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :is_deleted)
  end
end
