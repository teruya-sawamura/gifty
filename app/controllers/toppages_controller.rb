class ToppagesController < ApplicationController
  def index
    if logged_in?
      @posts = Post.all.order(id: :desc).page(params[:page]).per(24)
    end
  end
end
