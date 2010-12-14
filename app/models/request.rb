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
  
  def to_data_table
    requests = Request.find(:all, :order => "item_id")
    data_table = {"sEcho" => 1, "iTotalRecords" => requests.count, "iTotalDisplayRecords" => requests.count}
    requests_array = Array.new
    
    requests.each do |request|
      row = Array.new(6)
      row[0] = request.item.name
      row[1] = request.item.sub_category.name
      row[2] = request.requester_full_name
      row[3] = request.created_at.strftime("%Y-%m-%d %H:%M")
      if not request.item.loaned?
        if request.approved?
          row[4] = "<a href='/requests/#{request.id}/accept'>Picked Up</a>"
        else
          row[4] = "<a href='/requests/#{request.id}/accept'>Accept</a>"
        end
        
      else
        row[4] = "This item has already been loaned"
      end
      
      row[5] = "<a href='/requests/#{request.id}/reject'>Reject</a>"
      requests_array.push row
    end
    data_table["aaData"] = requests_array
    return data_table
  end
end
