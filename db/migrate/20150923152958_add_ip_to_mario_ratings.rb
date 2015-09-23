class AddIpToMarioRatings < ActiveRecord::Migration
  def change
    add_column :mario_ratings, :ip, :string
  end
end
