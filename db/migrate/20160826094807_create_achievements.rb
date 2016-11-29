class CreateAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :achievements do |t|
      t.string    :name, null: false
      t.string    :target, null: false
      t.string    :description
      t.integer   :score
      t.string    :achievement_type
      t.integer   :parent_id

      t.timestamps
    end
  end
end
