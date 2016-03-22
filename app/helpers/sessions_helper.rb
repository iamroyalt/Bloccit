module SessionsHelper
  #create session sets the user_id on the session object to user.id
  def create_session(user)
     session[:user_id] = user.id
   end

 #clears the user id on the session object by setting it to nil
   def destroy_session(user)
     session[:user_id] = nil
   end

 #define current user which returns the current user of the application
   def current_user
     User.find_by(id: session[:user_id])
   end


end
#SessionsController has no way of finding create_session - it won't recognize it as a valid method.
#We need to include SessionsHelper either directly in SessionsController, or in ApplicationController
#add it to ApplicationController, since we'll need to use it in other controllers later
