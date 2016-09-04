class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :nickname, null: false
      t.string :password_digest
      t.integer :solved
      t.integer :submitted
      t.integer :status
      t.string :oj_name, limit: 32
      t.integer :user_id
      
      t.timestamps
    end
  end
end
