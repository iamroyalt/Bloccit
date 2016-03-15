class SponsoredPostsController < ApplicationController
#1 CRUD
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end
#2 CRUD
  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end
#3 CRUD
  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])
    @sponsored_post.topic = @topic

    if @sponsored_post.save
       flash[:notice] = "Sponsored post was saved."
       redirect_to [@sponsored_post.topic, @sponsored_post]
    else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :new
    end
  end
#4 CRUD
  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end
#5 CRUD
  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]

    if @sponsored_post.save
      flash[:notice] = "Sponsored post was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end
#6 CRUD
  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
end

end
