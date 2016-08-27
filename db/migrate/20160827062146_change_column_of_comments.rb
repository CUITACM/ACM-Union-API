class ChangeColumnOfComments < ActiveRecord::Migration[5.0]
  def change
    remove_index :comments, [:entity_id, :entity_type]

    rename_column :comments, :entity_id, :commentable_id
    rename_column :comments, :entity_type, :commentable_type

    add_index :comments, [:commentable_id, :commentable_type], name: "index_comments_on_commentable"
  end
end
