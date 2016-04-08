class CommentsController < ApplicationController
#require sign in to ensure that guest users are not permitted to create comments or delete
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

     def create
#we find the correct post using post_id and then create a new comment using comment_params.
##We assign the comment's user to current_user, which returns the signed-in user instance
       @post = Post.find(params[:post_id])
#Checkpoint-47 making comment -> @comment instance variable for javascript
       @comment = @post.comments.new(comment_params)
       @comment.user = current_user
       @new_comment = Comment.new

       if @comment.save
         flash[:notice] = "Comment saved successfully."
#redirect to the posts show view. Depending on whether the comment was valid, we'll either display a success or an error message to the user.
       else
         flash[:alert] = "Comment failed to save."
       end
#Checkpoint-47 block for javascript
       respond_to do |format|
       format.html
       format.js
     end
  end

  def destroy
     @post = Post.find(params[:post_id])
#Checkpoint-47..comment becomes @comment because we need to have access to the variable in .js.erb view
     @comment = @post.comments.find(params[:id])

     if @comment.destroy
       flash[:notice] = "Comment was deleted."

     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
     end
#Checkpoint-47 respond_to block gives controller action the ability to return different response types
#depending on what was asked for in request. controller's repsonse is unchanged is client requests HTML, but
#if the client requests javascript, the controller will rend .js.erb instead
     respond_to do |format|
       format.html
       format.js
     end
   end

     private

   #private method taht white lists the parameters we need to create comments
     def comment_params
       params.require(:comment).permit(:body)
     end
#allows the comment owner or an admin user to delete the comment..redirects unauthorized users to post show view
     def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to [comment.post.topic, comment.post]
     end
   end
end
