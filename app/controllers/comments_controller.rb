class CommentsController < ApplicationController
  before_filter :login_required, :find_topic

  def new
    @comment = @topic.comments.new
  end

  def create
    @comment = @topic.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to topic_path(@topic), notice: 'Comment was successfully created.'
    else
      render action: :new
    end
  end

  def destroy
    @comment = @topic.comments.find(params[:id])
    if @comment.owned_by?(current_user)
      @comment.destroy
      redirect_to topic_path(@topic), notice: 'Comment was successfully deleted.'
    else
      redirect_to topic_path(@topic), notice: 'Forbidden'
    end
  end

  private
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
