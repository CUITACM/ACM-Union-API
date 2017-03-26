class AddColumnsForUserAchievements < ActiveRecord::Migration[5.0]
  def change
    add_column :user_achievements, :situation, :text
    add_column :user_achievements, :score, :integer

    add_column :user_infos, :train_rank, :integer

    add_column :comments, :user_name, :string
    add_column :comments, :user_avatar, :string
  end
end
