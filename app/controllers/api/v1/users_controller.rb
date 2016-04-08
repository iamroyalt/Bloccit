class Api::V1::UsersController < Api::V1::BaseController
   before_action :authenticate_user
   before_action :authorize_user

   def show
     user = User.find(params[:id])
     render json: user, status: 200
   end

   def index
     users = User.all
     render json: users, status: 200
   end
#Checkpoint-49
   def update
     user = User.find(params[:id])

 #attempt to udate_attributes on the given user.
     if user.update_attributes(user_params)
       render json: user, status: 200
     else
       render json: { error: "User update failed", status: 400 }, status: 400
     end
   end

   def create
     user = User.new(user_params)

 #check whether user is valid before saving it and returning a success method
     if user.valid?
       user.save!
       render json: user, status: 201
     else
       render json: { error: "User is invalid", status: 400 }, status: 400
     end
   end

   #define user_params to whitelist user parameters
   def user_params
     params.require(:user).permit(:name, :email, :password, :role)
   end

 end
