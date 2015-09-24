class UsersController < ApplicationController

  layout "mariomaker", :only => :marioprofile

  def show
    @cliq = Cliq.find(1)
    @user = User.friendly.find(params[:id])
    @topics = Topic.where(user_id:@user.id).order('created_at DESC').limit(10)
    @replies = Reply.where(user_id:@user.id).order('created_at DESC').limit(10)
    @facebook_info = env["omniauth.auth"]
  end

  def do_reset_session
    reset_session
  end

  def marioprofile
    @user = User.friendly.find(params[:id])
    @title = "#{current_user.username}'s Profile'"
    @levels = MarioLevel.where(user_id:@user.id).paginate(:per_page => 20, :page => params[:page])
  end

end
