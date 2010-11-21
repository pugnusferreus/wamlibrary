class ListingsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @list = List.new
    @list.display_by_category(params[:id])
    @item = @list.item
  end
  
  def tojson
    @list = List.new
    @list.display_by_category(params[:id])
    @item = @list.item
    @list::secho = params[:sEcho]
    data_table = {"sEcho" => 1}
    data_table["iTotalRecords"] = @item.count
    data_table["iTotalDisplayRecords"] = @item.count
    
    item_array = Array.new
    
    @item.each do |item|
      row = Array.new(6)
      row[0] = item.name
      row[1] = item.author
      row[2] = item.status_description
      row[3] = item.description
      row[4] = item.sub_category.category.name
      if not item.loaned?
        if not session[:cart].nil? and session[:cart][item.id]
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
    render :json => data_table
    #render :layout => "layouts/empty"
  end
end
