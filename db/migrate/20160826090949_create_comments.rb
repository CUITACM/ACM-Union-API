class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer   :user_id, null: false
      t.string    :user_name, null: false
      t.string    :user_avatar
      t.string    :description, limit: 512, null: false
      t.integer   :commentable_id, null: false
      t.string    :commentable_type, null: false
      t.integer   :parent_id
      t.integer   :like_times, default: 0

      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type],
              name: "index_comments_on_commentable"
    add_index :comments, :parent_id
  end
end
