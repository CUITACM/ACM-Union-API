class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string    :nickname, null: false
      t.string    :display_name, null: false
      t.string    :password_digest, limit: 1024
      t.boolean   :gender
      t.string    :avatar
      t.integer   :role
      t.integer   :status, default: 0
      t.string    :description, limit: 1024

      t.timestamps
    end

    add_index :users, :nickname, unique: true
    add_index :users, :display_name
  end
end
