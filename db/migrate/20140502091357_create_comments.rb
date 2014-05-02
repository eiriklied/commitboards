class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user,   index: true
      t.references :commit, index: true
      t.text :body

      t.timestamps
    end
  end
end
