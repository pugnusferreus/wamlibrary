class Notification < ActionMailer::Base
  default :from => "benson@progriff.com"
  
  def request_notification(user)
    admins = User.where(:admin => true)
    puts "in request notification"
    admins.each do |admin|
      puts "mailing to #{admin.email}"
      mail(:to => admin.email, :subject => "You have a WAM Library request") do |format|
        format.text { render :text => "You have a WAM Library item request from #{user.full_name}" }
      end
    end
  end
end
