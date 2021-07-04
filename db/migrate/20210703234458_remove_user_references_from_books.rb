class RemoveUserReferencesFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :books, :user, null: false, foreign_key: true
  end
end
