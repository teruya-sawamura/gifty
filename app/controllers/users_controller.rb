class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only:[:show, :edit, :update, :destroy, :likes, :edit_pass, :update_pass]
  before_action :require_user_unlogged_in, only:[:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy, :edit_pass, :update_pass]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(id: :desc).page(params[:page]).per(24)
    count(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録しました。"
      redirect_to @user
    else
      flash[:danger] = "ユーザ登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    Rails.logger.info(user_params)
    if @user.update(user_params)
      flash[:success] = 'プロフィールを変更しました。'
      redirect_to @user
    else
      flash.now[:danger] = "プロフィールの変更に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:danger] = "退会しました。"
      redirect_to root_url
    end
  end
  
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.all.order(id: :desc).page(params[:page]).per(24)
    count(@user)
  end
  
  def edit_pass
  end
  
  def update_pass
    if params[:user][:password].blank?
      flash.now[:warning] = "入力されていないフォームがあります。"
      render :edit_pass
    elsif @user.update(user_params)
      flash[:success] = 'パスワードを変更しました。'
      redirect_to @user
    else
      flash.now[:danger] = "パスワードの変更に失敗しました。"
      render :edit_pass
    end
  end
end


private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :icon, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to root_path 
    end
  end