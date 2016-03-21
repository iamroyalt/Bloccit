class CommentsController < ApplicationController
#require sign in to ensure that guest users are not permitted to create comments
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

     def create
#we find the correct post using post_id and then create a new comment using comment_params.
##We assign the comment's user to current_user, which returns the signed-in user instance
       @post = Post.find(params[:post_id])
       comment = @post.comments.new(comment_params)
       comment.user = current_user

       if comment.save
         flash[:notice] = "Comment saved successfully."
   
         redirect_to [@post.topic, @post]
       else
         flash[:alert] = "Comment failed to save."

         redirect_to [@post.topic, @post]
       end
     end

  def destroy
     @post = Post.find(params[:post_id])
     comment = @post.comments.find(params[:id])

     if comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to [@post.topic, @post]
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to [@post.topic, @post]
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
