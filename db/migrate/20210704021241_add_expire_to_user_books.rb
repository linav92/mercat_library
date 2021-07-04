class AddExpireToUserBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :user_books, :expire, :date
  end
end
