class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :github_url, :string
  end
end
