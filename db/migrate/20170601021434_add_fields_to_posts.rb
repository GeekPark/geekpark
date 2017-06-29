class AddFieldsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :views, :integer
    add_column :posts, :recommended, :boolean, index: true, default: false
  end
end
