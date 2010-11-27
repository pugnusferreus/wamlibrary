class ItemsController < ApplicationController
  before_filter :is_admin
  # GET /items
  # GET /items.xml
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end
  
  def tojson
    @items = Item.all
    data_table = {"sEcho" => 1, "iTotalRecords" => @items.count, "iTotalDisplayRecords" => @items.count}
    items_array = Array.new
    
    @items.each do |item|
      row = Array.new(8)
      row[0] = item.name
      row[1] = item.author
      row[2] = item.description
      row[3] = item.sub_category.name
      if item.active?
        row[4] = "Active"
      else
        row[4] = "Inactive"
      end
      
      if item.loaned?
        row[5] = "Loaned"
      else
        row[5] = "Available"
      end
      
      row[6] = "<a href='/items/#{item.id}'>Show</a>"
      row[7] = "<a href='/items/#{item.id}/edit'>Edit</a>"
      items_array.push row
    end
    data_table["aaData"] = items_array
    render :json => data_table
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def return
    item = Item.find(params[:id])
    Log.create("requester" => item.loaned_by, "item" => item.id, "log_type" => Log::RETURN)
    Item.update(item.id, {:loaned => false, :loaned_by => nil, :loaned_date => nil, :updated_at => Time.now })
    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end
end
