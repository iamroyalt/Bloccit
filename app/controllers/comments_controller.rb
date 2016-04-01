class CommentsController < ApplicationController
#require sign in to ensure that guest users are not permitted to create comments or delete
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  before_action :find_post

     def create
#########Assignment-42##########
#find the right post using the :post_id and then create a new comment which is assigned to the user
          #@post = Post.find(params[:post_id])
          comment = @post.comments.new(comment_params)
          comment.user = current_user

          if comment.save
              flash[:notice] = "Comment saved successfully."
              redirect_to [@post.topic, @post]

          else
            flash[:alert] = "Comment failed to save."
            redirect_to [@post.topic, @post]
       end
#find the right topic using :topic_id and then create a new comment which is assigned to the user
         #@topic = Topic.find(params[:topic_id])
          comment = @topic.comments.new(comment_params)
          comment.user = current_user

        if comment.save
         flash[:notice] = "Comment saved successfully."
         redirect_to [@topic]

        else
         flash[:alert] = "Comment failed to save."
         redirect_to [@topic]
     end
  end


  def destroy
#following the logic above...identifying the right :post_id to delete
          #params[:post_id]
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


private

    def find_post
      comment = @post.comments.find(params[:id])
    end

   #private method thatt white lists the parameters we need to create comments
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
