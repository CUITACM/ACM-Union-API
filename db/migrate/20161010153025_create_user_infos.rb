class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :email
      t.string :stu_id
      t.string :phone
      t.string :school
      t.string :college
      t.string :major
      t.string :grade
      t.string :situation

      t.belongs_to :user
      t.timestamps
    end

    remove_column :users, :email, :string
    remove_column :users, :stu_id, :string
    remove_column :users, :phone, :string
    remove_column :users, :school, :string
    remove_column :users, :college, :string
    remove_column :users, :major, :string
    remove_column :users, :grade, :string
    remove_column :users, :situation, :string
  end
end
