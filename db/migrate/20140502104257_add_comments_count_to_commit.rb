class AddCommentsCountToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :comments_count, :integer
  end
end
