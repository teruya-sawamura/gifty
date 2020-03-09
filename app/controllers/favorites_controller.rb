class FavoritesController < ApplicationController
  
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    user = User.find_by(id: post.user_id)
    current_user.liking(post)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    user = User.find_by(id: post.user_id)
    current_user.unliking(post)
    redirect_back(fallback_location: root_path)
  end
  
end
