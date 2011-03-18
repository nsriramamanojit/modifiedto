class Admin::ExamsController < ApplicationController
  # GET /admin_exams
  # GET /admin_exams.xml
  layout 'admin_home'
  def index
    @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName,InTheMonth,InTheYear,ExamStatus,NumDaysScheduled,ExamStartDate")
  end

  # GET /admin_exams/1
  # GET /admin_exams/1.xml
  def show
    @exam = Admin::Exam.find(params[:id])
    @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName")
   end

  # GET /admin_exams/new
  # GET /admin_exams/new.xml
  def new
    @exam = Admin::Exam.new
    @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName")
    @examtypes = Admin::Examtype.find(:all,:select=>"id,examtype")
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
   end

  # GET /admin_exams/1/edit
  def edit
    @exam = Admin::Exam.find(params[:id])
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
    @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName")
     @examtypes = Admin::Examtype.find(:all,:select=>"id,examtype")
  end

  # POST /admin_exams
  # POST /admin_exams.xml
  def create
     @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName")
     @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")     
      @examtypes = Admin::Examtype.find(:all,:select=>"id,examtype")
    @exam = Admin::Exam.new(params[:exam])
     @exam.InTheMonth=params[:exam][:InTheMonth].to_i
     @exam.ExamType = Admin::Examtype.find(params[:exam][:ExamType_Id],:select => 'examtype').examtype
    respond_to do |format|
      if @exam.save
        flash[:notice] = 'Admin::Exam was successfully created.'
        format.html { redirect_to :action=>"show", :id => @exam.id}
        #format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_exams/1
  # PUT /admin_exams/1.xml
  def update
       @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName")
     @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")     
      @examtypes = Admin::Examtype.find(:all,:select=>"id,examtype")
    @exam = Admin::Exam.find(params[:id])
   @exam.ExamType = Admin::Examtype.find(params[:exam][:ExamType_Id],:select => 'examtype').examtype
    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        flash[:notice] = 'Admin::Exam was successfully updated.'
        format.html { redirect_to :action=>"show", :id => @exam.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

end
