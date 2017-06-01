class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.string :user_id
      t.string :target_type
      t.string :target_id

      t.timestamps
    end

    add_index :likes, [:user_id, :target_type, :target_id]
  end
end
