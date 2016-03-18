class SessionsController < ApplicationController
  def new
    end
   #search database for a user with specified email address
    def create
      user = User.find_by(email: params[:session][:email].downcase)
   #verify user is not nil and specified passward is in the params hash
      if user && user.authenticate(params[:session][:password])
        create_session(user)
        flash[:notice] = "Welcome, #{user.name}!"
        redirect_to root_path
      else
        flash.now[:alert] = 'Invalid email/password combination'
        render :new
      end
    end
  #destroy which will delete a users session
    def destroy
      destroy_session(current_user)
      flash[:notice] = "You've been signed out, come back soon!"
      redirect_to root_path
    end

end
