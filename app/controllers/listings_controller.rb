class ListingsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @list = List.new
    @list.display_by_category(params[:id])
    @item = @list.item
  end
  
end
