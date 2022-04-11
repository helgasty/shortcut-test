class AddIndexToBuildings < ActiveRecord::Migration[7.0]
  def change
    add_index :buildings, :reference, unique: true
  end
end
