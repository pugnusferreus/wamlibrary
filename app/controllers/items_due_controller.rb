class ItemsDueController < ApplicationController
  def index
    
  end
  
  def do_extension
    item = Item.find(params[:id])
    item.do_extension
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
    end
  end
  
  def tojson
    item = Item.new
    render :json => item.to_item_due_data_table
  end
end
