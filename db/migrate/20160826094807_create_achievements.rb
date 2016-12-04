class CreateAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :achievements do |t|
      t.string    :name, null: false
      t.string    :description, limit: 2048
      t.integer   :score
      t.string    :achievement_type
      t.integer   :parent_id
      t.integer   :prev_id
      t.text      :conditions

      t.timestamps
    end
  end
end
