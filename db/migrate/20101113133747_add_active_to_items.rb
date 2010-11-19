class AddActiveToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :active, :boolean
  end

  def self.down
    remove_column :items, :active
  end
end
