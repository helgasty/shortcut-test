class CreateAttrHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :attr_histories do |t|
      t.string :model
      t.integer :identifier
      t.string :attr
      t.string :value

      t.timestamps
    end
  end
end
