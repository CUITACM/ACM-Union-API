class ModifyColumnOfUsersAndArticles < ActiveRecord::Migration[5.0]
  def change
    rename_column :articles, :type, :article_type

    add_column :users, :situation, :string
  end
end
