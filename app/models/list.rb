class List
  include Validatable
  
  attr_accessor :item
  
  def display_by_category(sub_category_id)
    #category = Category.find(category_id)
    @item = Item.where(:sub_category_id => sub_category_id, :active => true).order("items.name")
  end
  
end