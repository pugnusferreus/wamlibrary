class UserMaintenanceController < ApplicationController
  before_filter :is_admin
  
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def tojson
    user = User.new
    render :json => user.to_data_table
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /sub_categories/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /sub_categories/1
  # PUT /sub_categories/1.xml
  def update
    @user = User.find(params[:id])
    old_user = @user
    if params[:user_maintenance][:admin].nil?
      params[:user_maintenance][:admin] = false
    end
    
    if params[:user_maintenance][:enabled].nil?
      params[:user_maintenance][:enabled] = false
    end
    
    email = params[:user_maintenance][:email]
    first_name = params[:user_maintenance][:first_name]
    last_name = params[:user_maintenance][:last_name]
    is_admin = params[:user_maintenance][:admin]
    is_enabled = params[:user_maintenance][:enabled]
    puts params[:user_maintenance]
    respond_to do |format|
      Notification.changed_user_details(old_user, email,first_name,last_name,is_admin,is_enabled).deliver
      if @user.update_attributes(params[:user_maintenance])
        
        format.html { redirect_to edit_user_maintenance_path(@user)  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories/1
  # DELETE /sub_categories/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(user_maintenance_url) }
      format.xml  { head :ok }
    end
  end
end
