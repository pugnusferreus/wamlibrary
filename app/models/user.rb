class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :admin, :enabled
  
  def full_name
    return "#{first_name} #{last_name}"
  end
  
   def to_data_table
     users = User.all
     data_table = {"sEcho" => 1, "iTotalRecords" => users.count, "iTotalDisplayRecords" => users.count}
     users_array = Array.new

     users.each do |user|
       row = Array.new(6)
       row[0] = user.email
       row[1] = user.full_name
       if user.admin.nil?
         row[2] = false
       else
         row[2] = user.admin  
       end
       
       if user.enabled.nil?
         row[3] = false
       else
         row[3] = user.enabled
       end
       row[4] = "<a href='/user_maintenance/#{user.id}'>Show</a>"
       row[5] = "<a href='/user_maintenance/#{user.id}/edit'>Edit</a>"
       users_array.push row
     end
     data_table["aaData"] = users_array

     return data_table
   end
end
