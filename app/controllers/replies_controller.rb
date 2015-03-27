class RepliesController < ApplicationController

  before_action :set_topic, only: [:new, :create, :edit]
  before_action :authenticate_user!, :only => [:new, :create, :edit]

  def new
    @reply = Reply.new(topic_id: @topic.id)
  end

  def create
    @reply = Reply.create(body: params[:reply][:body], user_id: current_user.id, topic_id: params[:topic_id])
    respond_to do |format|
      if @reply.save
        @topic.touch
        format.html { redirect_to @topic, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
    calculate_exp
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def edit
    edit_permissions(params['id'], 'reply')
    unless @topic && @reply
      @topic = Topic.find(params[:topic_id])
      @reply = Reply.find(params[:id])
    end
  end

  def update
    @reply = Reply.find(params[:id])
    if @reply.update(body: params[:reply][:body])
      redirect_to @reply.topic, notice: 'Reply was successfully updated.'
    else
      render :edit
    end
  end

  private

  def calculate_exp
    #calculate this value based on times between posts
    topic = Topic.find(params[:topic_id])
    topic.exp = topic.exp + 1
    topic.save
  end

  def reply_params
    params.require(:body)
  end

end
