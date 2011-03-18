class Admin::UserstatusController < ApplicationController
  layout 'admin_home'
  def regdusers
    @users=User.paginate(:all,:select=>'id ,login,email,updated_at',:order=>'created_at DESC',:page => params[:page], :per_page => 40)
    if @users 
      render :partial=>'users',:layout=>'admin_home'
    else
      puts "##############  Users List Empty"
      end
  end
 def activeusers
    @users=User.paginate(:all,:select=>"id,login,email,updated_at",:conditions=>["state = ?",'active'],:order=>'created_at DESC',:page => params[:page], :per_page => 40)
    if @users 
      render :partial=>'users',:layout=>'admin_home'
    else
      puts "##############  Users List Empty"
      end
  end
  def pendingusers
     @users=User.paginate(:all,:select=>"id,login,email,updated_at",:conditions=>["state = ?",'pending'],:order=>'created_at DESC',:page => params[:page], :per_page => 40)
    if @users 
      render :partial=>'users',:layout=>'admin_home'
    else
      puts "##############  Users List Empty"
      end
  end
  
  def paidusers
    @users=Servicepayment.paginate(:all,:order=>'created_at DESC',:page => params[:page], :per_page => 40)
  end
end
