class AddImagesToHonors < ActiveRecord::Migration[5.0]
  def change
    add_column :honors, :images, :string, limit: 1024
    rename_column :honors, :content_level, :contest_level
  end
end
