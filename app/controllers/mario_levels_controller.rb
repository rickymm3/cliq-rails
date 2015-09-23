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
    @mario_level = MarioLevel.new(mario_level_params)
    @mario_level.user_id = current_user.id
    if @mario_level.ss_loc.present?
      check_ss_loc
    end
    respond_to do |format|
      if @mario_level.save
        format.html { redirect_to @mario_level, notice: 'Your level was added!' }
        format.json { render action: 'show', status: :created, location: @mario_level }
      else
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

  def edit
    @mario_level = MarioLevel.find(params[:id])
  end

  private

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