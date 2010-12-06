class AddDuration < ActiveRecord::Migration
  def self.up
    add_column :categories, :duration, :integer
  end

  def self.down
  end
end
