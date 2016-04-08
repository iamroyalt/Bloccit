class Api::V1::PostsController < Api::V1::BaseController

  before_filter :authenticate_user, except: [:index, :show]
  before_filter :authorize_user, except: [:index, :show]

#Assignment-48  GET api/v1/posts/
  def index
    posts = Post.all
    render json: posts.to_json, status: 200
  end
#Assignment-48  GET api/v1/posts/:id
  def show
    post = Post.find(params[:id])
    render json: post.to_json(include: :comments), status: 200
  end

 end
