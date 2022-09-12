class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path(@user.id), notice: 'ユーザー情報を保存しました'
    else
      render :edit
    end
  end
  

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: '退会処理が完了しました'
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted)
  end
  
  def ensure_guest_user
    @user = current_user
    if @user.name == "ゲストユーザー"
      redirect_to my_page_path(current_user), notice: "ゲストユーザーはプロフィール編集はできません"
    end
  end
  
end
