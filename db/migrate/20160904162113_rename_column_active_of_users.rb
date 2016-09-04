class RenameColumnActiveOfUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :active, :status
  end
end
