class ChangeLogsCol < ActiveRecord::Migration
  def self.up
    rename_column :logs, :type, :log_type
  end

  def self.down
  end
end
