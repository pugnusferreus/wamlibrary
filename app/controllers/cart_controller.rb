class CartController < ApplicationController
  def index
    if not session[:cart].nil?
      cart = session[:cart]
      @item = Item.find_all_by_id(cart.keys)
    end
  end
  
  def checkout
    if not session[:cart].nil?
      cart = session[:cart]
      items = Item.find_all_by_id(cart.keys)
      items.each do |item|
        request = Request.new
        request.requester = current_user.email
        request.item = item
        request.save
        session[:cart] = nil
      end
    end
  end
  
  def create
    item = Item.find(params[:id])
    puts params[:id]
    puts item.id
    #session[:cart] = nil
    if session[:cart].nil?
      puts "cart is null. creating new cart"
      cart = {item.id => item.id} 
    else
      puts "Adding to cart"
      cart = session[:cart]
      cart[item.id] = item.id
    end
    
    session[:cart] = cart
    puts "all keys #{cart.keys}"
    @list = List.new
    @list.display_by_category(item.sub_category.id)
    @item = @list.item
    
    respond_to do |format|
      format.html { redirect_to listing_path (item.sub_category.id) }
    end
  end
  
  
  def remove
    item = Item.find(params[:id])
    puts params[:id]
    puts item.id
    #session[:cart] = nil
    if not session[:cart].nil?
      puts "Removing from cart"
      cart = session[:cart]
      cart.delete(item.id)
    end
    
    session[:cart] = cart
    puts "all keys #{cart.keys}"
    @list = List.new
    @list.display_by_category(item.sub_category.id)
    @item = @list.item
    
    respond_to do |format|
      format.html { redirect_to listing_path (item.sub_category.id) }
    end
  end
end
