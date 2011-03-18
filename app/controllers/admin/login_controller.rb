class Admin::LoginController < ApplicationController
  
# before_filter :check_admin_auth
    def index
    if request.post?
      
    admin =Administrator.authenticate_admin(params[:login],params[:password])
    if admin
      session[:admin_id] = admin.id
        redirect_to :controller => 'admin/examtype', :action => 'welcome'
      else 
        @auth_error = 'Wrong username or password'
    end
     
    end
  end
   def logout
    session[:admin_id] = nil
    flash[:info] = 'You are logged out'
    redirect_to :controller => 'admin/login'
  end
  
end
