class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :entity_id, null: false
      t.string :entity_type, null: false

      t.timestamps
    end

    add_index :tags, [:entity_id, :entity_type], name: "index_tags_on_entity"
  end
end
