class CreateMarioUserComments < ActiveRecord::Migration
  def change
    create_table :mario_user_comments do |t|
      t.integer :user_id
      t.references :commenter
      t.string :comment
      t.integer :mario_level_id

      t.timestamps null: false
    end
  end
end
