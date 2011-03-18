class Admin::SectiontopicController < ApplicationController
  layout "admin_home" 
  def list
     @sectiontopics=Admin::Sectiontopic.find(:all,:select=>"id,Topic,MaxQuestions,TotalQuestionsInSection",:order=>'Topic')
 end
 
 def show
    @sectiontopic = Admin::Sectiontopic.find(params[:id])
    @sectiontopics = Admin::Sectiontopic.find(:all,:select=>"id,Topic")
    @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
  end
  
  def new
    @sectiontopic = Admin::Sectiontopic.new
   # @sectiontopics = Admin::Sectiontopic.find(:all,:select=>"id,topic")
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
   @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
  @sectiontopics = Admin::Sectiontopic.find(:all,:select=>"id,Topic")
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name")
 
  end
  
  def edit
    @sectiontopic = Admin::Sectiontopic.find(params[:id])
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
   @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
  @sectiontopics = Admin::Sectiontopic.find(:all,:select=>"id,Topic")
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name")
  end
  
  
  def create
    
    @examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName")
   @sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"SectionTemplate_Id,SectionTitle")
  @sectiontopics = Admin::Sectiontopic.find(:all,:select=>"id,Topic")
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name")
    
    @sectiontopic = Admin::Sectiontopic.new(params[:sectiontopic])
   
    @subjectid=Admin::Subject.find_by_subject_name(params[:subjectname])
   
    @sectiontopic.Subject_id=@subjectid.id
    @sectiontopic.Topic=params[:sectiontopic][:Topic].strip
    if @sectiontopic.save
    redirect_to :action=>"show", :id => @sectiontopic.id
  else
    render :action=>'new'
 end
 end


def update
       @sectiontopic = Admin::Sectiontopic.find(:all,:select=>"id,Topic")
       #@examtemplates = Admin::Examtemplate.find(:all,:select=>"ExamTemplate_Id,TemplateName") 
       #@sectiontemplates = Admin::Sectiontemplate.find(:all,:select=>"ExamTemplate_id,SectionTitle")
       @sectiontpc=Admin::Sectiontopic.find(params[:id])
       @sectiontpc.Topic=params[:sectiontopic][:Topic].strip
      respond_to do |format|
      if @sectiontpc.update_attributes(params[:sectiontopic])
        flash[:notice] = 'Admin::Sectiontopic was successfully updated.'
        format.html { redirect_to :action=>"show", :id => @sectiontpc.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sectiontopic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #used in dynamic select
  def update_sectemplate
     @sectiontemplates=Admin::Sectiontemplate.find(:all,:conditions=>['ExamTemplate_Id='+params[:tempid]],:select=>'SectionTitle,SectionTemplate_Id')
    render :update do |page|
       page.replace_html "sectiontemp" ,:partial => 'sectemp_by_examtemp',:object=>@sectiontemplates,:layout=>false
    end
  end
  
  def update_subtemplate
    @sectiontemplates1=Admin::Sectiontemplate.find_by_SectionTemplate_Id(params[:examtmpid])
    @subject=Admin::Subject.find_by_id(@sectiontemplates1.Subject_Id)
    render :update do |page|
       page.replace_html "numQueInSec" ,:partial => 'gettotalques_by_section',:object=>@sectiontemplates1,:layout=>false
       page.replace_html "subname" ,:partial => 'getsubject_by_question',:object=>@subject,:layout=>false
       end
  end
  end




