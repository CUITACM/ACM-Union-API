class ChangeColumnForUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :active, :integer, default: 0

    add_column :users, :description, :string
  end
end
