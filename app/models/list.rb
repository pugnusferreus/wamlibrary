class List
  include Validatable
  
  attr_accessor :item, :secho, :sub_category_id
  
  def display_by_category(sub_category_id)
    #category = Category.find(category_id)
    @item = Item.where(:sub_category_id => sub_category_id, :active => true).order("items.name")
    @sub_category_id = sub_category_id
  end
  
  def to_data_table(cart)
    
    data_table = {"sEcho" => 1, "iTotalRecords" => @item.count, "iTotalDisplayRecords" => @item.count}
    
    item_array = Array.new
    
    @item.each do |item|
      row = Array.new(6)
      row[0] = item.name
      row[1] = item.author
      row[2] = item.status_description
      row[3] = item.description
      row[4] = item.sub_category.category.name
      if not item.loaned?
        if not cart.nil? and cart[item.id]
          row[5] = "<a href='/cart/#{item.id}/remove'>Cancel</a>"
        else
          row[5] = "<a href='/cart/#{item.id}'>Put In Cart</a>"
        end
      else
        row[5] = "Loaned"
      end
      item_array.push row
    end
    data_table["aaData"] = item_array
    
    return data_table
  end
  
end