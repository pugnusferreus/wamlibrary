class Notification < ActionMailer::Base
  def request_notification(user)
    recipients "#{user.full_name} <#{user.email}>"
    from       "benson@progriff.com "
    subject    "WAM Library Request"
    sent_on    Time.now
    body       { :user => user }
  end
end
