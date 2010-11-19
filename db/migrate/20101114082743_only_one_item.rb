class OnlyOneItem < ActiveRecord::Migration
  def self.up
    add_column :items, :loaned, :boolean
    add_column :items, :loaned_by, :string
    add_column :items, :loaned_date, :timestamp
  end

  def self.down
    remove_column :items, quantity
    remove_column :items, current
  end
end
