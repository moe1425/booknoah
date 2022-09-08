class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted)
  end
end
