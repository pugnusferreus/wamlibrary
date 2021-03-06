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
      row = Array.new(7)
      row[0] = item.name
      row[1] = item.author
      row[2] = item.sub_category.name
      if item.active?
        row[3] = "Active"
      else
        row[3] = "Inactive"
      end
      
      if item.loaned?
        row[4] = "Loaned"
      else
        row[4] = "Available"
      end
      
      row[5] = "<a href='/items/#{item.id}'>Show</a>"
      row[6] = "<a href='/items/#{item.id}/edit'>Edit</a>"
      items_array.push row
    end
    data_table["aaData"] = items_array
    
    return data_table
  end
  
  def to_item_due_data_table
    items = Item.where("current_date > due_date and loaned = true").order("name")
    data_table = {"sEcho" => 1, "iTotalRecords" => items.count, "iTotalDisplayRecords" => items.count}
    items_array = Array.new
    
    items.each do |item|
      row = Array.new(6)
      row[0] = item.name
      row[1] = item.index_num
      row[2] = item.loaned_by_full_name
      row[3] = item.due_date
      row[4] = (DateTime.now - item.due_date).to_i
      row[5] = "<a href='/items_due/#{item.id}/do_extension'>Extend</a>"
      items_array.push row
    end
    data_table["aaData"] = items_array
    
    return data_table
    
  end
  
  def loaned_by_full_name
    user = User.where(:email => loaned_by).first
    
    if not user.nil?
      return user.full_name
    else
      loaned_by
    end
  end
  
  def do_extension
    item = Item.find(id)
    if DateTime.now > item.due_date
      item.due_date = DateTime.now + item.sub_category.category.duration
    else
      item.due_date = item.due_date + item.sub_category.category.duration
    end
    item.save
  end
end
