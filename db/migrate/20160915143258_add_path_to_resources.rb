class AddPathToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :file, :string
    add_column :resources, :owner, :integer
  end
end
