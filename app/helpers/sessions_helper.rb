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

   def avatar_url(user)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end

end
