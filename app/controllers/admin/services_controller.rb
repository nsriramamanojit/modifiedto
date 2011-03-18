class Admin::ServicesController < ApplicationController
  # GET /admin_services
  # GET /admin_services.xml
  layout 'admin_home'
  def index
    @services = Admin::Service.find(:all,:select=>"service_id,service_name,service_mode,servicetype_id,servicechargeamount")
  end

  # GET /admin_services/1
  # GET /admin_services/1.xml
  def show
    @services = Admin::Service.find(:all,:select=>"service_id,service_name")
    @service = Admin::Service.find(params[:id])
  end

  # GET /admin_services/new
  # GET /admin_services/new.xml
  def new
    @service = Admin::Service.new
    @service_mode = [:OnLine,'OnLine'],[:OffLine,'OffLine']
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type",:conditions=>"servicetype_enabled=1")
    @exams = Admin::Exam.find(:all,:select=>"ExamName",:conditions=>"ExamStatus='1'")
    @allservices = Admin::Service.find(:all,:select=>"service_id,service_name")
  end

  # GET /admin_services/1/edit
  def edit
    @service = Admin::Service.find(params[:id])
    @service_mode = [:OnLine,'OnLine'],[:OffLine,'OffLine']
     @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type",:conditions=>"servicetype_enabled=1")
    @exams = Admin::Exam.find(:all,:select=>"ExamName",:conditions=>"ExamStatus='1'")
    @allservices = Admin::Service.find(:all,:select=>"service_id,service_name")
    cookies[:value] = params[:id]
  end

  # POST /admin_services
  # POST /admin_services.xml
  def create
     @service_mode = [:OnLine,'OnLine'],[:OffLine,'OffLine']
    @exams = Admin::Exam.find(:all,:select=>"ExamName",:conditions=>"ExamStatus='1'")
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type",:conditions=>"servicetype_enabled=1")
    @allservices = Admin::Service.find(:all,:select=>"service_id,service_name")
    @service = Admin::Service.new(params[:service])
    nameinuppercase =  params[:service]['service_name'].upcase
    aa = nameinuppercase.rindex('BITSAT')
    #if aa!= nil
    #  if aa >=0
  #      @service.service_mode = 'OnLine'
   #   end
 #  end

      if @service.save
        flash[:notice] = 'Admin::Service was successfully created.'
        redirect_to :action => 'show', :id => @service.id
      else
        render :action => 'new'
    end
    @users = User.find(:all,:select=>'email',:conditions=>["state = ?",'active'])
    emails = ''
    @users.each do |user|
      emails = emails +","+user.email
    end
     #   recipient = emails[1,emails.length]
     #   subject = "New Service added"
      #  servicename = params[:service]['service_name']
      #  Emailer.deliver_servicescontact(recipient, subject, servicename)
      #  return if request.xhr?
  end

  # PUT /admin_services/1
  # PUT /admin_services/1.xml
  def update
    @exams = Admin::Exam.find(:all,:select=>"ExamName",:conditions=>"ExamStatus='1'")
    @servicetypes = Admin::Servicetype.find(:all,:select=>"servicetype_id,service_type",:conditions=>"servicetype_enabled=1")
    @service = Admin::Service.find(params[:id])
     nameinuppercase =  params[:service]['service_name'].upcase
    aa = nameinuppercase.rindex('BITSAT')
    if aa!= nil
      if aa >=0
        @service.service_mode = 'OnLine'
      end
    end
      if @service.update_attributes(params[:service])
        flash[:notice] = 'Admin::Service was successfully updated.'
         redirect_to :action=> 'show',:id=>@service.id
      else
        render :action =>'edit'
      end
  end
end
