require 'date'

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
    due_date = nil
    if not item.sub_category.category.duration.nil?
      due_date = DateTime.now + item.sub_category.category.duration
    end
    
    if request.approved?
      Item.update(item.id, { :loaned => true, :loaned_by => request.requester, :loaned_date => Time.now, :due_date => due_date })
      request.destroy
      Log.create("requester" => request.requester, "item" => item.id, "log_type" => Log::BORROW)
      Notification.pickedup_notification(request.requester,item,due_date).deliver
      
    else
      Request.update(request.id, { :approved => true })
      Notification.accept_notification(request.requester,current_user.full_name, item).deliver
    end
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
