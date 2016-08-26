class CreateAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :achievements do |t|
      t.string :name, null: false
      t.string :target, null: false
      t.string :description
      t.string :rank_title
      t.integer :score
      t.string :type

      t.timestamps
    end
  end
end
