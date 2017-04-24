class AddDeletedAtToTables < ActiveRecord::Migration[5.0]
  def change
    %i(collections topics columns comments posts ads tags).each do |table|
      add_column table, :deleted_at, :datetime
      add_index table, :deleted_at
    end
  end
end
