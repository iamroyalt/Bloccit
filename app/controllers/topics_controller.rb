class TopicsController < ApplicationController

     before_action :require_sign_in, except: [:index, :show]
     before_action :authorize_user, except: [:index, :show]

    def index
      @topics = Topic.all
#Checkpoint-45 using the visible_to scope from topic.rb
      @topics = Topic.visible_to(current_user)

    end

   def show
     @topic = Topic.find(params[:id])
#Checkpoint-45 ensuring only signed in guests can view private topics
    unless @topic.public || current_user
      flash[:alert] = "You must be signed in to view private topics."
      redirect_to new_session_path
    end

     
   end

   def new
     @topic = Topic.new
   end

   def create
      @topic = Topic.new(topic_params)

      if @topic.save
#call a class method named update_labels on Label. We pass it the labels associated with the current topic_params
#if the topic was saved successfully. We only update the labels if the save was successful sot aht we avoid creating labels without topics_path
        @topic.labels = Label.update_labels(params[:topic][:labels])
        redirect_to @topic, notice: "Topic was saved successfully."
      else
        flash.now[:alert] = "Error creating topic. Please try again."
        render :new
      end
    end

    def edit
      @topic = Topic.find(params[:id])
    end

    def update
      @topic = Topic.find(params[:id])
      @topic.assign_attributes(topic_params)

      if @topic.save
        # #20
         @topic.labels = Label.update_labels(params[:topic][:labels])
         flash[:notice] = "Topic was updated."
        redirect_to @topic
      else
        flash.now[:alert] = "Error saving topic. Please try again."
        render :edit
      end
    end

    def destroy
      @topic = Topic.find(params[:id])

      if @topic.destroy
        flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleting the topic."
        render :show
      end
    end

    private
         def topic_params
           params.require(:topic).permit(:name, :description, :public)
         end

        def authorize_user
          unless current_user.admin?
            flash[:alert] = "You must be an admin to do that."
            redirect_to topics_path
          end
    end
  end
