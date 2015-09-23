class MarioRatingsController < ApplicationController
  layout 'mariomaker'

  def index
  end

  def new
    @mario_level = MarioLevel.find(params[:id])
    if MarioRating.where(user_id: current_user.id, mario_level_id: params[:id]).exists?
      @rated = true
    else
      @rating = MarioRating.new
    end
  end

  def create
    @rating = MarioRating.new(mario_rating_params)
    @rating.user_id = current_user.id
    @rating.mario_level_id = params[:id]
    @rating.ip = current_user.current_sign_in_ip
    @mario_level = MarioLevel.find(params[:id])
    update_mario_level_rank(@mario_level, mario_rating_params)
    respond_to do |format|
      if save_rating(@rating)
        format.html { redirect_to @mario_level, notice: @notice}
        format.json { render action: 'show', status: :created, location: @rating }
      else
        format.html { render action: 'new' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def mario_rating_params
    params.require(:mario_rating).permit(:fun, :puzzle, :difficulty, :overall)
  end

  def update_mario_level_rank(level, mario_rating_params)
    ratings = MarioRating.where(mario_level_id: level.id)
    fun = level.fun_rank ||= 0
    puzzle = level.puzzle_rank ||= 0
    difficulty = level.difficulty_rank ||= 0
    overall = level.overall_rank ||= 0

    fun = (fun + mario_rating_params[:fun].to_i)/(ratings.count + 1)
    puzzle = (puzzle + mario_rating_params[:puzzle].to_i)/(ratings.count + 1)
    difficulty = (difficulty + mario_rating_params[:difficulty].to_i)/(ratings.count + 1)
    overall = (overall + mario_rating_params[:overall].to_i)/(ratings.count + 1)

    level.update_attributes(fun_rank:fun,puzzle_rank:puzzle,difficulty_rank:difficulty, overall_rank:overall)
  end

  def save_rating(rating)
    if  MarioRating.where(user_id:current_user.id, mario_level_id: @mario_level.id).exists?
      @notice = "You have already rated this level"
    elsif MarioRating.where(ip:current_user.current_sign_in_ip, mario_level_id: @mario_level.id).exists?
      @notice = "A user from your IP has already rated this level"
    else
      rating.save
      check_winner(rating)
      @notice = "Your Rating has been submitted!"
    end
  end

  def check_winner(rating)
    if MarioRating.where(mario_level_id: rating.mario_level_id).count = 50
      MarioWinner.winner = @mario_level.user
    end
  end

end