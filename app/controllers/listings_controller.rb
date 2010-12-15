class ListingsController < ApplicationController
  before_filter :is_logged_in
  def show
    @list = List.new
    @list.display_by_category(params[:id])
    @item = @list.item
  end
  
  def tojson
    @list = List.new
    @list.display_by_category(params[:id])
    render :json => @list.to_data_table(session[:cart],false)
  end
  
  def search
    @query = params[:query]
    session[:query] = @query
    @list = List.new
    @list.search(@query)
    render :json => @list.to_data_table(session[:cart],true)
  end
  
end
