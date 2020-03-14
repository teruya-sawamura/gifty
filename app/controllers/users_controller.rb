class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only:[:show, :edit, :update, :likes,]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(id: :desc).page(params[:page]).per(18)
    count(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      flash[:danger] = "ユーザ登録に失敗しました。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      flash[:danger] = "プロフィールの変更に失敗しました。"
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.all.order(id: :desc).page(params[:page]).per(18)
    count(@user)
  end
  
  def edit_pass
    @user = User.find(params[:id])
  end
  
  def update_pass
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールを変更しました。'
      redirect_to @user
    else
      flash[:danger] = "プロフィールの変更に失敗しました。"
      render :edit
    end
  end
end


private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex, :icon, :introduction)
  end