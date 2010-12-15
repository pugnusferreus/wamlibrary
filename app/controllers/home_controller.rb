class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @query = params[:query]    
  end

end
