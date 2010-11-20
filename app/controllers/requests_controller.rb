class RequestsController < ApplicationController
  def index
    @requests = Request.find(:all, :order => "item_id")
  end
  
  def accept
    request = Request.find(params[:id])
    item = request.item
    Item.update(item.id, { :loaned => true, :loaned_by => request.requester, :loaned_date => Time.now })
    request.destroy
    Log.create("requester" => request.requester, "item" => item.id, "log_type" => Log::BORROW)
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
