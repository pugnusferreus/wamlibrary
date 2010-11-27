class RequestsController < ApplicationController
  before_filter :is_admin
  
  def index
    @requests = Request.find(:all, :order => "item_id")
  end
  
  def tojson
    @requests = Request.find(:all, :order => "item_id")
    data_table = {"sEcho" => 1, "iTotalRecords" => @requests.count, "iTotalDisplayRecords" => @requests.count}
    requests_array = Array.new
    
    @requests.each do |request|
      row = Array.new(6)
      row[0] = request.item.name
      row[1] = request.item.sub_category.name
      row[2] = request.requester_full_name
      row[3] = request.created_at.strftime("%Y-%m-%d %H:%M")
      if not request.item.loaned?
        row[4] = "<a href='/requests/#{request.id}/accept'>Accept</a>"
      else
        row[4] = "This item has already been loaned"
      end
      
      row[5] = "<a href='/requests/#{request.id}/reject'>Reject</a>"
      requests_array.push row
    end
    data_table["aaData"] = requests_array
    render :json => data_table
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
