class AddItemColumns < ActiveRecord::Migration
  def self.up
    add_column :items, :year,:integer
    add_column :items, :index_num,:string
    add_column :items, :due_date,:date
  end

  def self.down
  end
end
