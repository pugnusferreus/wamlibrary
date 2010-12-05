class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    puts "sending email to #{params[:user][:first_name]}"
    Notification.user_registration_request("#{params[:user][:first_name]} #{params[:user][:last_name]}").deliver
    super
  end

  def update
    super
  end
end