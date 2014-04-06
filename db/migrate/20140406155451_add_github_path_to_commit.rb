class AddGithubPathToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :github_path, :string
  end
end
