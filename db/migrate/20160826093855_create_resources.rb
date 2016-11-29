class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string    :path
      t.string    :filename, null: false
      t.string    :usage, null: false
      t.string    :description
      t.integer   :auth, default: 0
      t.integer   :owner_id

      t.timestamps
    end
  end
end
