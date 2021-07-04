class RemoveDetailsFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :status, :integer
    remove_column :books, :lending_at, :date
    remove_column :books, :returned_at, :date
  end
end
