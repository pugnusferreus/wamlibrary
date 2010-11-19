class ChangeItemFk < ActiveRecord::Migration
  def self.up
    rename_column :items, :category_id, :sub_category_id
  end

  def self.down
  end
end
