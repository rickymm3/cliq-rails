class MarioWinners < ActiveRecord::Migration
  def change
    create_table :mario_winners do |t|
      t.references :winner

      t.timestamps null: false
    end
  end
end
