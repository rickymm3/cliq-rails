class MarioLevelsController < ApplicationController
  layout 'mariomaker'
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!, :only => [:new, :create, :edit]


  def index
    @levels = MarioLevel.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end

  def new
    @mario_level = MarioLevel.new
  end

  def create
    @notice = 'Your level was added!'
    @mario_level = MarioLevel.new(mario_level_params)
    @mario_level.user_id = current_user.id
    if @mario_level.ss_loc.present?
      check_ss_loc
    end
    respond_to do |format|
      if save_if_high_enough_points
        format.html { redirect_to @mario_level, notice: @notice }
        format.json { render action: 'show', status: :created, location: @mario_level }
      else
        flash.now[:notice] = @notice
        format.html { render action: 'new' }
        format.json { render json: @mario_level.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @mario_level = MarioLevel.find(params[:id])
    @count = MarioRating.where(mario_level_id: @mario_level.id).count
    @fun = @mario_level
    @comments = MarioUserComment.where(mario_level_id: @mario_level.id)
    @comment = MarioUserComment.new(mario_level_id:@mario_level.id)
  end

  def update
    @mario_level = MarioLevel.find(params[:id])
    if @mario_level.update(mario_level_params)
      redirect_to [@mario_level], notice: "#{@mario_level.name} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @mario_level = MarioLevel.find(params[:id])
    respond_to do |format|
      if @mario_level.delete
        format.html { redirect_to mario_levels_path, notice: "Level was deleted!" }
        format.json { render action: 'show', status: :created, location: @mario_level }
      else
        flash.now[:notice] = @notice
        format.html { render action: 'new' }
        format.json { render json: @mario_level.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @mario_level = MarioLevel.find(params[:id])
  end

  private

  def save_if_high_enough_points
    count = MarioLevel.where(user_id:current_user).count
    if count < 4
      @mario_level.save
    elsif count < 11 && current_user.points > 99
      @mario_level.save
    elsif count < 21 && current_user.points > 201
      @mario_level.save
    else
      @notice = "You need to rate more stages to upload more!"
      false
    end
  end

  def check_if_owner?
    if current_user
      @mario_level.user_id == current_user.id
    else
      false
    end
  end

  def mario_level_params
    params.require(:mario_level).permit(:name, :description, :ss_loc, :l_category_id, :level_code)
  end

  def check_ss_loc
    ss_loc = @mario_level.ss_loc
    unless ss_loc.include? ".cloudfront.net/ss"
      @mario_level.ss_loc = nil
    end
    # https://d3esbfg30x759i.cloudfront.net/ss/WVW69iZXTIM0M9gLDJ
  end

end