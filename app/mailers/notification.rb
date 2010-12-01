class Notification < ActionMailer::Base
  default :from => "benson@progriff.com"
  
  def request_notification(user)
    admin = User.find(1)
    
    mail(:to => admin.email, :subject => "You have a WAM Library request") do |format|
      format.text { render :text => "You have a WAM Library request from #{user.full_name}" }
    end
  end
end
