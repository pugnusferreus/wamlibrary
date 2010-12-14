class AddRequestApproved < ActiveRecord::Migration
  def self.up
    add_column :requests, :approved, :boolean
  end

  def self.down
  end
end
