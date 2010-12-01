class Notification < ActionMailer::Base
  default :from => "benson@progriff.com"
  
  def request_notification()
    user = User.find(1)
    
    mail(:to => user.email, :subject => "Test") do |format|
      format.text { render :text => "This is text!" }
      format.html { render :text => "<h1>This is HTML</h1>" }
    end
  end
end
