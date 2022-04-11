class AddIndexToPeoples < ActiveRecord::Migration[7.0]
  def change
    add_index :people, :reference, unique: true
  end
end
