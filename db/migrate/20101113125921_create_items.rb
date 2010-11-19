class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :author
      t.integer :quantity
      t.integer :current
      t.text :description
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
