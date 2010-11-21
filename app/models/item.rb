class Item < ActiveRecord::Base
  belongs_to :sub_category
  
  def status_description
    if(loaned?)
      return "Loaned"
    else
      return "Available"
    end
  end
end
