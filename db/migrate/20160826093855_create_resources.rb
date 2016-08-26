class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :filename, null: false
      t.string :usage, null: false
      t.string :description
      t.boolean :auth, default: false

      t.timestamps
    end
  end
end
