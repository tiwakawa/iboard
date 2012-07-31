class TopicsController < ApplicationController
  before_filter :login_required, except: :show 
  before_filter :find_topic, only: [:show, :destroy]
  before_filter :owner_required, only: :destroy

  def show
  end

  def new
    @topic = current_user.topics.new
  end

  def create
    @topic = current_user.topics.new(params[:topic])
    if @topic.save
      redirect_to root_path, notice: 'Topic was successfully created.'
    else
      render action: :new
    end
  end

  def destroy
    @topic.destroy
    redirect_to root_path, notice: "#{@topic.title} was successfully deleted."
  end

  private
  def find_topic
    @topic = Topic.find(params[:id])
  end

  def owner_required
    redirect_to root_path, notice: 'Forbidden' unless @topic.owned_by?(current_user)
  end
end
