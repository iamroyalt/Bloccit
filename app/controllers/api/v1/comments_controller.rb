class Api::V1::CommentsController < Api::V1::BaseController

     before_filter :authenticate_user, except: [:index, :show]
     before_filter :authorize_user, except: [:index, :show]
#index shows all comments
#Assignment-48  GET api/v1/comments/
   def index
     comments = Comment.all
     render json: comments.to_json, status: 200
   end
#show shows single comment which is why :id is needed
#Assignment-48  GET api/v1/comments/:id
   def show
     comment = Comment.find(params[:id])
     render json: comment.to_json, status: 200
   end

end
