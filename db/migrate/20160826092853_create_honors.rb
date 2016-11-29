class CreateHonors < ActiveRecord::Migration[5.0]
  def change
    create_table :honors do |t|
      t.string    :contest_name, null: false
      t.integer   :content_level, null: false
      t.string    :description
      t.string    :team_name

      t.timestamps
    end
  end
end
