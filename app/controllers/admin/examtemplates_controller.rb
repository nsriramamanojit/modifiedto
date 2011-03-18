class Admin::ExamtemplatesController < ApplicationController
  # GET /admin_examtemplates
  # GET /admin_examtemplates.xml
  layout 'admin_home'
  def index
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName,NumberOfSections,TotalDurationMinutes,TemplateDescription")
  end

  # GET /admin_examtemplates/1
  # GET /admin_examtemplates/1.xml
  def show
    @examtemplate = Admin::Examtemplate.find(params[:id])
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    
    end

  # GET /admin_examtemplates/new
  # GET /admin_examtemplates/new.xml
  def new
    @examtemplate = Admin::Examtemplate.new
    @examtypes = Admin::Examtype.find(:all,:select=>"id,examtype")
    @examtypes = Admin::Examtype.find(:all,:select=>"examtype,id")
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    end

  # GET /admin_examtemplates/1/edit
  def edit
    @examtemplate = Admin::Examtemplate.find(params[:id])
    @examtypes = Admin::Examtype.find(:all,:select=>"id,examtype")
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
  end

  # POST /admin_examtemplates
  # POST /admin_examtemplates.xml
  def create
    @examtypes = Admin::Examtype.find(:all,:select=>"examtype,id")
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    @examtemplate = Admin::Examtemplate.new(params[:examtemplate])
     @examtemplate.ExamType = Admin::Examtype.find(params[:examtemplate][:ExamType_Id],:select=>'examtype').examtype
    respond_to do |format|
      if @examtemplate.save
        flash[:notice] = 'Admin::Examtemplate was successfully created.'
        format.html { redirect_to :action=>"show", :id => @examtemplate.id}
         
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examtemplate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_examtemplates/1
  # PUT /admin_examtemplates/1.xml
  def update
     @examtypes = Admin::Examtype.find(:all,:select=>"examtype")
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    @examtemplate = Admin::Examtemplate.find(params[:id])
     @examtemplate.ExamType = Admin::Examtype.find(params[:examtemplate][:ExamType_Id],:select=>'examtype').examtype
    respond_to do |format|
      if @examtemplate.update_attributes(params[:examtemplate])
        flash[:notice] = 'Admin::Examtemplate was successfully updated.'
        format.html { redirect_to :action=>"show", :id => @examtemplate}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examtemplate.errors, :status => :unprocessable_entity }
      end
    end
  end
end
