class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
    def require_user_logged_in
      unless logged_in?
        redirect_to login_path
      end
    end
    
    def require_user_unlogged_in
      if logged_in?
        redirect_to root_url
      end
    end
    
    def count(user)
      @count_posts = user.posts.count
      @count_likes = user.likes.count
    end
    
    

    
end
