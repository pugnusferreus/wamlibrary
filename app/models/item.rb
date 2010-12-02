class Item < ActiveRecord::Base
  belongs_to :sub_category
  
  def status_description
    if(loaned?)
      return "Loaned"
    else
      return "Available"
    end
  end
  
  def to_data_table
    items = Item.all
    data_table = {"sEcho" => 1, "iTotalRecords" => items.count, "iTotalDisplayRecords" => items.count}
    items_array = Array.new
    
    items.each do |item|
      row = Array.new(8)
      row[0] = item.name
      row[1] = item.author
      row[2] = item.description
      row[3] = item.sub_category.name
      if item.active?
        row[4] = "Active"
      else
        row[4] = "Inactive"
      end
      
      if item.loaned?
        row[5] = "Loaned"
      else
        row[5] = "Available"
      end
      
      row[6] = "<a href='/items/#{item.id}'>Show</a>"
      row[7] = "<a href='/items/#{item.id}/edit'>Edit</a>"
      items_array.push row
    end
    data_table["aaData"] = items_array
    
    return data_table
  end
end
