class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_admin, except: [:index, :show, :update]
  before_action :authorize_moderator, only: [:update]

  def index
    @topics = Topic.all 
  end

  def show
    puts "showing topic " + params[:id]
    @topic = Topic.find(params[:id])
    p @topic
  end

=begin
  def show
    @topic = Topic.find(params[:id])
  end
=end

  def new
    @topic = Topic.new 
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Errpr creating topic. Please try again."
      render :new 
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

=begin
  def update 
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic 
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end
=end

  def update 
    puts "updating topic " + params[:id]
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)
    p @topic
    if @topic.save
      puts "successful, redirecting"
      flash[:notice] = "Topic was updated."
      redirect_to @topic 
    else
      puts "error saving topic"
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

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path 
    end
  end

  def authorize_moderator
    unless current_user.moderator?
      flash[:alert] = "You must be a moderator to do that."
      redirect_to topics_path 
    end
  end

end
