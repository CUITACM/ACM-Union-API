class CreateSubmits < ActiveRecord::Migration[5.0]
  def change
    create_table :submits do |t|
      t.string :pro_id, limit: 32
      t.string :run_id, limit: 32
      t.integer :run_time
      t.integer :memory
      t.string :lang, limit: 32
      t.string :result, limit: 32
      t.text :code
      t.datetime :submitted_at
      t.integer :status

      t.integer :user_id
      t.string :user_name
      t.string :oj_name, limit: 32
      t.timestamps
    end
  end
end
