class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  def is_admin
    if user_signed_in?
      if not current_user.admin? or not current_user.enabled?
        #if signed in but if not admin
        redirect_to root_path, :alert => "You're not an admin."
      end
    else
      #if not signed in at all
      redirect_to :action => "index", :controller => "home"
    end
  end
  
  def is_logged_in
    puts user_signed_in?
    puts current_user.enabled?
    if user_signed_in?  
      if not current_user.enabled?
        puts "here!"
        redirect_to root_path, :alert => "Your account has not been activated yet"
      end
    else
      redirect_to :action => "index", :controller => "home"
    end
  end
end
