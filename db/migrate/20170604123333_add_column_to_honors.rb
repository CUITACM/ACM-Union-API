class AddColumnToHonors < ActiveRecord::Migration[5.0]
  def change
    add_column :honors, :contest_date, :datetime
    add_column :honors, :members, :string
  end
end
