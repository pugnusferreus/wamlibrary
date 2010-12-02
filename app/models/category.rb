class Category < ActiveRecord::Base
  has_many :sub_categories
  
  def to_data_table
    categories = Category.all
    data_table = {"sEcho" => 1, "iTotalRecords" => categories.count, "iTotalDisplayRecords" => categories.count}
    categories_array = Array.new
    
    categories.each do |category|
      row = Array.new(4)
      row[0] = category.name
      row[1] = category.description
      row[2] = "<a href='/categories/#{category.id}'>Show</a>"
      row[3] = "<a href='/categories/#{category.id}/edit'>Edit</a>"
      categories_array.push row
    end
    data_table["aaData"] = categories_array
    return data_table
  end
end
