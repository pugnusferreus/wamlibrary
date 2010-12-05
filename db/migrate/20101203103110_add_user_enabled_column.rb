class AddUserEnabledColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :enabled, :boolean
  end

  def self.down
  end
end
