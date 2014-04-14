class AddOwnerIdToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :owner, index: true
  end
end
