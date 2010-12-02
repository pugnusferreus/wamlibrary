class SubCategory < ActiveRecord::Base
  belongs_to :category
  
  def to_data_table
    sub_categories = SubCategory.all
    data_table = {"sEcho" => 1, "iTotalRecords" => sub_categories.count, "iTotalDisplayRecords" => sub_categories.count}
    sub_categories_array = Array.new
    
    sub_categories.each do |sub_category|
      row = Array.new(5)
      row[0] = sub_category.name
      row[1] = sub_category.description
      row[2] = sub_category.category.name
      row[3] = "<a href='/sub_categories/#{sub_category.id}'>Show</a>"
      row[4] = "<a href='/sub_categories/#{sub_category.id}/edit'>Edit</a>"
      sub_categories_array.push row
    end
    data_table["aaData"] = sub_categories_array
    
    return data_table
  end
end
