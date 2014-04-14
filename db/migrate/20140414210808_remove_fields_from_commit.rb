class RemoveFieldsFromCommit < ActiveRecord::Migration
  def change
    remove_column :commits, :email
    remove_column :commits, :name
  end
end
