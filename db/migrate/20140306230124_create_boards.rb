class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.string :key

      t.timestamps
    end

    add_index :boards, :key, unique: true
  end
end
