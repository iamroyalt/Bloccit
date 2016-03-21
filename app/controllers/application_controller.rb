class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  private
#redirect unsigned in users...define this in ApplicationController because we'll eventually want to call it from other controllers
#all controllers inherit from the Application Controller class
   def require_sign_in
     unless current_user
       flash[:alert] = "You must be logged in to do that"
 #redirect unsigned in users to the sign in page
       redirect_to new_session_path
     end
   end
end
