class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string    :email
      t.string    :stu_id
      t.string    :phone
      t.string    :school
      t.string    :college
      t.string    :major
      t.string    :grade
      t.string    :situation

      t.belongs_to  :user
      t.timestamps
    end
  end
end
