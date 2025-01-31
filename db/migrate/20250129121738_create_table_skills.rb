class CreateTableSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :skills do |t|
      t.string :name
      t.index :name, unique: true

      t.timestamps
    end
  end
end
