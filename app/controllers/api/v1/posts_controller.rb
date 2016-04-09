class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user
  before_action :authorize_user

#Assignment-49 POST api/v1/topics/:topic_id/posts/create...post associated with topic
  def create
    topic = Topic.find(params[:topic_id])
    post = topic.posts.build(post_params)
    post.user = @current_user

    if post.valid?
      post.save!
      render json: post.to_json, status: 200
    else
      render json: {error: "Post is invalid", status: 400}, status: 400
    end
   end
#Assignment-49 DELETE api/v1/topics/:topic_id/posts/:id/
  def destroy
    post = Post.find(params[:id])

    if post.destroy
      render json: {message: "Post destroyed", status: 200}, status: 200
    else
      render json: {error: "Post destroy failed", status: 400}, status: 400
    end
  end

#Assignment-49 PUT api/v1/topics/:topic_id/posts/:id/
  def update
    post = Post.find(params[:id])

    if post.update_attributes(post_params)
      render json: post.to_json, status: 200
    else
      render json: {error: "Post failed to update", status: 400}, status: 400
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
