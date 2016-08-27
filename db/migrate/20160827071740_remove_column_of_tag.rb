class RemoveColumnOfTag < ActiveRecord::Migration[5.0]
  def change
    remove_index :tags, [:entity_id, :entity_type]
    remove_column :tags, :entity_id
    remove_column :tags, :entity_type
  end
end
