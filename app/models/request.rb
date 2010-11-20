class Request < ActiveRecord::Base
  belongs_to :item
  
  def requester_full_name
    user = User.where(:email => requester).first
    
    if not user.nil?
      return user.full_name
    else
      requester
    end
  end
end
