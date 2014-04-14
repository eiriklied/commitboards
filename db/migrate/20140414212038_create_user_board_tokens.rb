class CreateUserBoardTokens < ActiveRecord::Migration
  def change
    create_table :user_board_tokens do |t|
      t.references :user, index: true, null: false
      t.references :board, index: true, null: false
      t.string :key, null: false

      t.timestamps
    end
    add_index :user_board_tokens, :key, unique: true
  end
end
