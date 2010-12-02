class Notification < ActionMailer::Base
  default :from => "benson@progriff.com"
  
  def request_notification(user, items)
    admins = User.where(:admin => true)
    admins.each do |admin|
      puts "mailing to #{admin.email}"
      
      items_point = ""
      items.each do |item|
        items_point += "<ul>#{item.name} (#{item.index_num})</ul>"
      end
      
      mail_body = <<-HTML
        <p>You have a WAM Library item request from #{user.full_name}</p>
        Items requested :
        <ul>
          #{items_point}
        </ul>
      HTML
      
      mail(:to => admin.email, :subject => "You have a WAM Library request") do |format|
        format.html { render :text => mail_body }
      end
    end
  end
  
  def accept_notification(requester_email,accepted_by, item)
    
    mail_body = <<-HTML
      The request for item <b>#{item.name} (#{item.index_num})</b> has been accepted by #{accepted_by}
    HTML
      
    mail(:to => requester_email, :subject => "Your WAM Library request has been accepted") do |format|
      format.html { render :text => mail_body }
    end

  end
  
  def reject_notification(requester_email,rejected_by, item)
    mail_body = <<-HTML
      The request for item <b>#{item.name} (#{item.index_num})</b> has been rejected by #{rejected_by}
    HTML
      
    mail(:to => requester_email, :subject => "Your WAM Library request has been rejected") do |format|
      format.html { render :text => mail_body }
    end
  end
end
