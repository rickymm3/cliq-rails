module MarioHelper

  def own_level?
    if current_user
      if @mario_level.user_id == current_user.id
        true
      end
    else
      false
    end
  end

  def can_rate?(level)
    if current_user
      if MarioRating.where(user_id: current_user.id, mario_level_id: level.id).exists?
        false
      else
        true
      end
    else
      false
    end
  end

  def check_mario_image(level)
    unless level.ss_loc == ""
      image_tag(level.ss_loc, size: '160x120')
    else
      image_tag('no_image.png', size: '160x120')
    end
  end

  def mario_level_complete?(level)
    if current_user
      if MarioRating.where(user_id:current_user.id, mario_level_id: level.id).present?
        true
      else
        false
      end
    else
      false
    end
  end

end
