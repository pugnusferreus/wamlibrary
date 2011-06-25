class AddEnabledToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :enabled, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :users, :enabled
  end
end
