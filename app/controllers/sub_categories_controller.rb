class SubCategoriesController < ApplicationController
  before_filter :is_admin
  
  # GET /sub_categories
  # GET /sub_categories.xml
  def index
    @sub_categories = SubCategory.all
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sub_categories }
    end
  end
  
  def tojson
    @sub_categories = SubCategory.all
    data_table = {"sEcho" => 1, "iTotalRecords" => @sub_categories.count, "iTotalDisplayRecords" => @sub_categories.count}
    sub_categories_array = Array.new
    
    @sub_categories.each do |sub_category|
      row = Array.new(5)
      row[0] = sub_category.name
      row[1] = sub_category.description
      row[2] = sub_category.category.name
      row[3] = "<a href='/sub_categories/#{sub_category.id}'>Show</a>"
      row[4] = "<a href='/sub_categories/#{sub_category.id}/edit'>Edit</a>"
      sub_categories_array.push row
    end
    data_table["aaData"] = sub_categories_array
    render :json => data_table
  end

  # GET /sub_categories/1
  # GET /sub_categories/1.xml
  def show
    @sub_category = SubCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sub_category }
    end
  end

  # GET /sub_categories/new
  # GET /sub_categories/new.xml
  def new
    @sub_category = SubCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sub_category }
    end
  end

  # GET /sub_categories/1/edit
  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  # POST /sub_categories
  # POST /sub_categories.xml
  def create
    @sub_category = SubCategory.new(params[:sub_category])

    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to(@sub_category, :notice => 'Sub category was successfully created.') }
        format.xml  { render :xml => @sub_category, :status => :created, :location => @sub_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sub_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sub_categories/1
  # PUT /sub_categories/1.xml
  def update
    @sub_category = SubCategory.find(params[:id])

    respond_to do |format|
      if @sub_category.update_attributes(params[:sub_category])
        format.html { redirect_to(@sub_category, :notice => 'Sub category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sub_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories/1
  # DELETE /sub_categories/1.xml
  def destroy
    @sub_category = SubCategory.find(params[:id])
    @sub_category.destroy

    respond_to do |format|
      format.html { redirect_to(sub_categories_url) }
      format.xml  { head :ok }
    end
  end
end
