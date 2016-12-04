class CreateUserAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :user_achievements do |t|
      t.integer     :user_id, null: false
      t.integer     :achievement_id, null: false
      t.integer     :current
      t.integer     :total
      t.boolean     :completed
      t.datetime    :completed_at

      t.timestamps
    end

    add_index :user_achievements, [:user_id, :achievement_id], unique: true
  end
end
