class PostsController < ApplicationController
  
  before_action :require_user_logged_in
  
  before_action :correct_post, only: [:edit, :update, :destroy]
  
  def show
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.user_id)
  end
  
  def new
    @post = current_user.posts.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "GIFTを投稿しました。"
      redirect_to @post.user
    else
      flash.now[:danger] = "GIFTの投稿に失敗しました。"
      render :new
    end
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
  end
  
  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "GIFTを編集しました。"
      redirect_to @post
    else
      flash.now[:danger] = "GIFTの編集に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = "GIFTを削除しました。"
    redirect_to @post.user
  end
  
  def search
    @posts = Post.search(params[:search]).order(id: :desc).page(params[:page]).per(24)
  end
  
end
  
  
  private
  
    def post_params
      params.require(:post).permit(:giftwhat, :giftwho, :giftwhen, :givetake, :giftpict1, :giftpict2, :giftpict3, :giftcomment)
    end
    
    def correct_post
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to root_path
      end
    end
