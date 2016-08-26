class AddExtraInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar, :string
    add_column :users, :role, :integer
    add_column :users, :stu_id, :string
    add_column :users, :active, :boolean, default: true
    add_column :users, :phone, :string
    add_column :users, :school, :string
    add_column :users, :college, :string
    add_column :users, :major, :string
    add_column :users, :grade, :string

    add_index :users, :nickname, unique: true
    add_index :users, :name

    change_column_null :users, :nickname, false
    change_column_null :users, :name, false
  end
end
