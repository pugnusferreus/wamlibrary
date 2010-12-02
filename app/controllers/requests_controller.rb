class RequestsController < ApplicationController
  before_filter :is_admin
  
  def index
    @requests = Request.find(:all, :order => "item_id")
  end
  
  def tojson
    request = Request.new
    render :json => request.to_data_table
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end
  
  def accept
    request = Request.find(params[:id])
    item = request.item
    Item.update(item.id, { :loaned => true, :loaned_by => request.requester, :loaned_date => Time.now })
    request.destroy
    Log.create("requester" => request.requester, "item" => item.id, "log_type" => Log::BORROW)
    Notification.accept_notification(request.requester,current_user.full_name, item).deliver
    respond_to do |format|
      format.html { redirect_to requests_path }
    end
  end
  
  def reject
    request = Request.find(params[:id])
    item = request.item
    request.destroy
    Notification.reject_notification(request.requester,current_user.full_name, item).deliver
    respond_to do |format|
      format.html { redirect_to requests_path }
    end
  end
end
