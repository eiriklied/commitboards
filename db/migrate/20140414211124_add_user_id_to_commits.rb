class AddUserIdToCommits < ActiveRecord::Migration
  def change
    add_reference :commits, :user, index: true
  end
end
