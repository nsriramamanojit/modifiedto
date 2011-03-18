class HomeController < ApplicationController
  include AuthenticatedSystem
  layout 'home'
  before_filter :login_required ,:except=>[:index,:testinfo,:contact]
  def index
    
  end
  def userhome
    if Servicepayment.exists?(:student_id=>current_user.id) 
      @paid_services=Admin::Service.find(:all,:conditions=>['payment_required = ? AND service_status = ?',true,true])
      render :action=>'exams'
    else
      puts "Need to Subscribe the Service"
      render :action=>'subscribe'
    end
  end
  def exams
    @paid_services=Admin::Service.find(:all,:conditions=>['payment_required = ? AND service_status = ?',true,true])
  end
  def subscribe
    randomnumber = Date.today.to_s
    
  end
  
  def profile
    if Profile.exists?(:student_id=>current_user.id) 
      @profile=Profile.find_by_student_id(current_user.id)
    else
      @profile=Profile.new
    end
  end
  def update_profile
    if Profile.exists?(:student_id=>current_user.id) 
      @profile=Profile.find_by_student_id(current_user.id)
      @profile.student_id=current_user.id
      @profile.email=current_user.email
      @profile.name=params[:profile][:name]
      @profile.mobile=params[:profile][:mobile]
      @profile.landline=params[:profile][:landline]
      @profile.alt_email=params[:profile][:alt_email]
      @profile.country=params[:profile][:country]
      @profile.state=params[:profile][:state]
      @profile.city=params[:profile][:city]
      @profile.address=params[:profile][:address]
      if @profile.save
        flash[:notice]="Your Profile has been Updated.."
        render :action=>'profile'
      else
        render :action=>'profile'
      end
    else
      @profile=Profile.new
      @profile.student_id=current_user.id
      @profile.email=current_user.email
      @profile.name=params[:profile][:name]
      @profile.mobile=params[:profile][:mobile]
      @profile.landline=params[:profile][:landline]
      @profile.alt_email=params[:profile][:alt_email]
      @profile.country=params[:profile][:country]
      @profile.state=params[:profile][:state]
      @profile.city=params[:profile][:city]
      @profile.address=params[:profile][:address]
      if @profile.save
        flash[:notice]="Your Profile has been Updated.."
        render :action=>'profile'
      else
       render :action=>'profile'
      end
    end
  end
end
