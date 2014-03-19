class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :project
      t.datetime :committed_at
      t.string :email
      t.string :name
      t.text :message
      t.attachment :image
      t.references :board

      t.timestamps
    end
  end
end
