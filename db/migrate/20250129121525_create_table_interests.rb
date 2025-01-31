class CreateTableInterests < ActiveRecord::Migration[7.2]
  def change
    create_table :interests do |t|
      t.string :name
      t.index :name, unique: true

      t.timestamps
    end
  end
end
