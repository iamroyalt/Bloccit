class CommentsController < ApplicationController
#require sign in to ensure that guest users are not permitted to create comments or delete
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

#########Assignment-42#########
  def create
    if params[:post_id]
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
    elsif params[:topic_id]
      @topic = Topic.find(params[:topic_id])
      comment = @topic.comments.new(comment_params)
      comment.user = current_user

      if comment.save
        flash[:notice] = "Comment saved successfully."
        redirect_to @topic

      else
        flash[:alert] = "Comment failed to save."
        redirect_to @topic
      end
    end
  end

  def destroy

    if params[:post_id]
      @post = Post.find(params[:post_id])
      comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@post.topic, @post]
    end

  else
    @topic = Topic.find(params[:topic_id])
    comment = @topic.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@topic]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic]
   end
 end
end
private

    #def from_post
      #comment = @post.comments.find(params[:id])
    #end

   #private method thatt white lists the parameters we need to create comments
     def comment_params
       params.require(:comment).permit(:body)
     end

#allows the comment owner or an admin user to delete the comment..redirects unauthorized users to post show view
     def authorize_user
       comment = Comment.find(params[:id])
         unless current_user == comment.user || current_user.admin?
           flash[:alert] = "You do not have permission to delete a comment."
           #redirect_to [comment.post.topic, comment.post]
           redirect_to [comment.post.topic, comment.post]
         end
      end
end
