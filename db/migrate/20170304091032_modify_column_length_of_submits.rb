class ModifyColumnLengthOfSubmits < ActiveRecord::Migration[5.0]
  def change
    change_column :submits, :result, :string, limit: 64
    change_column :submits, :lang, :string, limit: 64

    change_column :submits, :run_id, :string, limit: 128
    change_column :submits, :pro_id, :string, limit: 128
  end
end
