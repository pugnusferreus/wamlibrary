class Notification < ActionMailer::Base
  default :from => "benson@progriff.com"
  
  def request_notification(user, items)
    admins = User.where(:admin => true)
    #if no admins, don't bother sending anything
    if admins.size < 1
      return
    end
    
    admin_emails = Array.new(admins.size)
    
    i = 0
    admins.each do |admin|
      puts "mailing to #{admin.email}"
      admin_emails[i] = admin.email
      i += 1
    end
    
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
      
    mail(:to => admin_emails, :subject => "You have a WAM Library request") do |format|
      format.html { render :text => mail_body }
    end

  end
  
  def user_registration_request(full_name)
    admins = User.where(:admin => true)
    #if no admins, don't bother sending anything
    if admins.size < 1
      return
    end
    
    admin_emails = Array.new(admins.size)
    
    i = 0
    admins.each do |admin|
      puts "mailing to #{admin.email}"
      admin_emails[i] = admin.email
      i += 1
    end
          
    mail_body = <<-HTML
      <p>You have a WAM Library user registration request from #{full_name}</p>
    HTML
      
    mail(:to => admin_emails, :subject => "You have a WAM Library user registration request") do |format|
      format.html { render :text => mail_body }
    end

  end
  
  def changed_user_details(user, email_param, first_name_param, last_name_param, admin_param, enabled_param)
    puts "user param : #{email_param} #{first_name_param} #{last_name_param} #{admin_param} #{enabled_param}"
    puts "user : #{user.email} #{user.first_name} #{user.last_name} #{user.admin} #{user.enabled}"
    items_point = ""
    if user.email != email_param
      items_point += "<ul>Email changed from <b>#{user.email}</b> to <b>#{email_param}</b></ul>"
    end

    if user.first_name != first_name_param
      items_point += "<ul>First Name changed from <b>#{user.first_name}</b> to <b>#{first_name_param}</b></ul>"
    end
      
    if user.last_name != last_name_param
      items_point += "<ul>Last Name changed from <b>#{user.last_name}</b> to <b>#{last_name_param}</b></ul>"
    end
    
    if user.admin.to_s() != admin_param.to_s()
      items_point += "<ul>Is Admin changed from <b>#{user.admin}</b> to <b>#{admin_param}</b></ul>"
    end
    
    if user.enabled.to_s() != enabled_param.to_s()
      items_point += "<ul>Email changed from <b>#{user.enabled}</b> to <b>#{enabled_param}</b></ul>"
    end
    
    mail_body = <<-HTML
      <p>Your WAM Library admin has changed your user detail(s) :</p>
      <ul>
        #{items_point}
      </ul>
    HTML
    puts items_point
    
    if items_point != ""
      mail(:to => user.email, :subject => "Your WAM Library Account has been updated") do |format|
        format.html { render :text => mail_body }
      end
    end
  end
  
  def accept_notification(requester_email,accepted_by, item)
    
    mail_body = <<-HTML
      The request for item <b>#{item.name} (#{item.index_num})</b> has been accepted by #{accepted_by}
      <br/>
      Please collect your item from your librarian.
      <br/><br/>
      Pick up day = Sunday (Please contact your librarian if you're not able to do so)
    HTML
      
    mail(:to => requester_email, :subject => "Your WAM Library request has been accepted") do |format|
      format.html { render :text => mail_body }
    end

  end
  
  def pickedup_notification(requester_email,item,due_date)
    mail_body = <<-HTML
      You have picked up <b>#{item.name} (#{item.index_num})</b>
      <br/>
      Your due date is <b>#{due_date.strftime("%Y-%m-%d")}</b>
    HTML
      
    mail(:to => requester_email, :subject => "Your WAM Library request has been picked up") do |format|
      format.html { render :text => mail_body }
    end
  end
  
  def reject_notification(requester_email,rejected_by, item)
    mail_body = <<-HTML
      The request for item <b>#{item.name} (#{item.index_num})</b> has been rejected by #{rejected_by}
      <br/>
      <br/>
      Please refer to terms of borrowing for further details.
    HTML
      
    mail(:to => requester_email, :subject => "Your WAM Library request has been rejected") do |format|
      format.html { render :text => mail_body }
    end
  end
  
end
