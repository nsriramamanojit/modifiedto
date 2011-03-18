## This controller is used to create, update the section templates.
class Admin::SectiontemplatesController < ApplicationController
  # GET /admin_sectiontemplates
  # GET /admin_sectiontemplates.xml
  layout 'admin_home' ## Setting the layout.
  ### To display all the available sectiontemplates.
  def index
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle,Subject_Id,ExamTemplate_Id,SectionDescription,SectionDurationMinutes,SectionNumQuestions")
  end
  
  # GET /admin_sectiontemplates/1
  # GET /admin_sectiontemplates/1.xml
  ## To show the details of selected sectiontemplate.
  def show
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
    @sectiontemplate = Admin::Sectiontemplate.find(params[:id])
  end
  
  # GET /admin_sectiontemplates/new
  # GET /admin_sectiontemplates/new.xml
  def new
    @sectiontemplate = Admin::Sectiontemplate.new
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
    @examtemplates =  Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    @subjects = Admin::Subject.find(:all,:select=>"id,subject_name")
    @sectionstatus = [:Active,'active'],[:InActive,'inactive']
  end
  
  # GET /admin_sectiontemplates/1/edit
  def edit
    @sectionstatus = [:Active,'active'],[:InActive,'inactive']
    @subjects = Admin::Subject.find(:all,:select=>"id,subject_name")
    @sectiontemplate = Admin::Sectiontemplate.find(params[:id])
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
    @examtemplates =  Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
  end
  
  # POST /admin_sectiontemplates
  # POST /admin_sectiontemplates.xml
  ## To create the new sectiontemplate.
  def create
#    @sectionstatus = [:Active,'active'],[:InActive,'inactive']
#    @QuestionChoosenby = [:LastModified,'LastModified'],[:EarlierModified,'EarliestModified'],[:Random,'Random']
    @examtemplates =  Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    @subjects = Admin::Subject.find(:all,:select=>"id,subject_name")
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
    @sectiontemplate = Admin::Sectiontemplate.new(params[:sectiontemplate])
    @sectiontemplate.SectionMinimumTagMatch = 0
    @sectiontemplate.SectionTags = params[:sectiontemplate][:SectionTags]
    @sectiontemplate.SubjectCode = Admin::Subject.find_by_id(params[:sectiontemplate][:Subject_Id]).subject_code
    if params[:include]=='on'
      @sectiontemplate.Included = 1
    else
      @sectiontemplate.Included = 0
    end
    @sectiontemplate.SectionStatus = params[:SectionStatus]
    @sectiontemplate.SuitableQuestionChosenBy = params[:SuitableQuestionChosenBy]
    respond_to do |format|
      if @sectiontemplate.save
        flash[:notice] = 'Admin::Sectiontemplate was successfully created.'
        format.html { redirect_to :action=>"show", :id => @sectiontemplate.id }
        format.xml  { render :xml => @sectiontemplate, :status => :created, :location => @sectiontemplate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sectiontemplate.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin_sectiontemplates/1
  # PUT /admin_sectiontemplates/1.xml
  ## To update the existing sectiontemplate.
  def update
    @sectionstatus = [:Active,'active'],[:InActive,'inactive']
   # @QuestionChoosenby = [:LastModified,'LastModified'],[:EarlierModified,'EarliestModified'],[:Random,'Random']
    @examtemplates =  Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    @subjects = Admin::Subject.find(:all,:select=>"id,subject_name")
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
    @sectiontemplate = Admin::Sectiontemplate.find(params[:id])
    if params[:include]=='on'
      @sectiontemplate.Included = 1
    else
      @sectiontemplate.Included = 0
    end
    @sectiontemplate.SectionStatus = params[:SectionStatus]
    @sectiontemplate.SuitableQuestionChosenBy = params[:SuitableQuestionChosenBy]
    @sectiontemplate.SectionMinimumTagMatch = 0
     @sectiontemplate.SectionTags = params[:sectiontemplate][:SectionTags]
    respond_to do |format|
      if @sectiontemplate.update_attributes(params[:sectiontemplate])
        @sectiontemplate.save
        flash[:notice] = 'Admin::Sectiontemplate was successfully updated.'
        format.html { redirect_to :action=>"show", :id => @sectiontemplate.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sectiontemplate.errors, :status => :unprocessable_entity }
      end
    end
  end
end
