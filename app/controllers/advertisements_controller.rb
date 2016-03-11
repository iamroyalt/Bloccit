class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisements = Advertisement.find(params[:id])
  end

  def new
    @advertisements = Advertisment.new
  end

  def create
    @advertisements = Advertisement.new
     @advertisements.title = params[:advertisement][:title]
     @advertisements.body = params[:advertisement][:body]
     @advertisements.price = params[:advertisement][:price]
     if @advertisements.save
       flash[:notice] = "Advertisement was saved."
       redirect_to @advertisements
     else
       flash.now[:alert] = "There was an error saving the advertisement. Please try again."
       render :new
     end
   end
  end
