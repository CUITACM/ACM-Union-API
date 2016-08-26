class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :user_id, null: false
      t.string :type, null: false
      t.integer :status, null: false
      t.integer :like_times, default: 0

      t.timestamps
    end

    add_index :articles, [:user_id, :title], unique: true
  end
end
