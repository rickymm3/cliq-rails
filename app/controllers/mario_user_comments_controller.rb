class MarioUserCommentsController < ApplicationController
  layout 'mariomaker'

  def create
    @mario_level = MarioLevel.find(mario_user_comment_params[:mario_level_id])
    @comment = MarioUserComment.new(user_id: @mario_level.user_id,
                                    commenter: current_user,
                                    comment: mario_user_comment_params[:comment],
                                    mario_level_id:@mario_level.id)
    respond_to do |format|
      if save_if_not_too_frequent
        format.html { redirect_to @mario_level, notice: @notice }
        format.json { render action: 'show', status: :created, location: @mario_level }
      else
        format.html { render action: 'new' }
        format.json { render json: @mario_level.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def mario_user_comment_params
    params.require(:mario_user_comment).permit(:mario_level_id, :comment)
  end

  def save_if_not_too_frequent
    if comment = MarioUserComment.where(commenter: current_user).last
      if comment.created_at > 10.minutes.ago
        @notice = "You can't post a new comment yet. Please wait 10 minutes before posts}"
      else
        @comment.save
      end
    else
      @comment.save
    end
  end

end