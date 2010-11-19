class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end
  
  def accept
    request = Request.find(params[:id])
    item = request.item
    Item.update(item.id, { :loaned => true })
    request.destroy
    respond_to do |format|
      format.html { redirect_to requests_path }
    end
  end
  
  def reject
    request = Request.find(params[:id])
    item = request.item
    request.destroy
    respond_to do |format|
      format.html { redirect_to requests_path }
    end
  end
end
