class AddItemColContents < ActiveRecord::Migration
  def self.up
    add_column :items, :contents, :string
  end

  def self.down
  end
end
