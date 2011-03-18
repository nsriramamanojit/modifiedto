### Author :Upender
## Date and Time :02-10-2008 3:30 am
class Admin::QuestionbankController < ApplicationController
  layout 'admin_home'
  protect_from_forgery :only => [:questionbank, :topic] 
  
  def new
    @questions=Admin::Questionbank.find(:all,:select=>"id,question_code,subject_name,question_number,internal_ref_number",:order=>'created_at DESC',:limit=>3)
    @questionbank=Admin::Questionbank.new
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
    @sectiontopics=Admin::Sectiontopic.find(:all,:select => 'DISTINCT Topic')
    @sectiontags=Admin::Sectiontemplate.find(:all,:select=>'SectionTags')
  end
  def create
    @subjects=Admin::Subject.find(:all,:select=>"id,subject_name",:order=>'subject_name')
    @questions=Admin::Questionbank.find(:all,:select=>"id,question_code,subject_name,question_number,internal_ref_number",:order=>'created_at DESC',:limit=>3)
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype') ## to save the checked examtypes
    @sectiontopics=Admin::Sectiontopic.find(:all,:select => 'DISTINCT Topic,id')
    @sectiontags=Admin::Sectiontemplate.find(:all,:select=>'SectionTags')
    totalexamtypes = ""
    i=1
    @examtypes.size.times{
      examtypes =  params['etype'+i.to_s]['checked']
      if  totalexamtypes == ''
        totalexamtypes = examtypes
      else
        totalexamtypes = totalexamtypes+','+examtypes
      end
      i=i+1
    }
    @admin=Administrator.find(session[:admin_id],:select=>"id,login")# to get created_by and modified_by from administrators table
    @subject=Admin::Subject.find(params[:questionbank][:subject_id],:select=>"id,subject_code,last_question_number,subject_name")
    subjectCode=@subject.subject_code
    lastQueNumber=@subject.last_question_number+1
    ## getting the hex decimal from lasquestion number with appending the subject code
    # sprintf("%04X", lastQueNumber) is used for getting the hex decimal with padding of four zeros
    appendedQuestionCode=@subject.subject_code+sprintf("%04X", lastQueNumber)
    @questionbank=Admin::Questionbank.new(params[:questionbank])
    Admin::Questionbank.save_imagepaths_in_db(params[:questionbank],@questionbank,subjectCode,appendedQuestionCode)## to save the image paths in db
    if params[:questionbank][:question_media_type]=="Textual"
      @questionbank.question_media_type=0
    else
      @questionbank.question_media_type=1
    end
    @questionbank.question_code=appendedQuestionCode
    @questionbank.question_number=lastQueNumber
    @questionbank.subject_name=@subject.subject_name
    @questionbank.subject_code=subjectCode
    @questionbank.created_by_user= @admin.login
    @questionbank.modified_by_user=@admin.login
    @questionbank.examtype_tags=totalexamtypes
    @questionbank.topic=params[:questionbank][:topic].strip
    @questionbank.tags=params[:questionbank][:tags].strip
    if @questionbank.save
      if params[:questionbank][:question_media_type]=="Graphical"
        Admin::Questionbank.save_images(params[:questionbank],subjectCode,appendedQuestionCode)
      end 
      Admin::Subject.update(@subject.id, {:last_question_number=>lastQueNumber})
      redirect_to :action => 'success', :id => @questionbank
    else
      render :action => 'new'
    end
  end
  
  def success
    @questionbank=Admin::Questionbank.find(params[:id])
    @questions=Admin::Questionbank.find(:all,:select=>"id,question_code,subject_name,question_number,internal_ref_number",:order=>'created_at DESC',:limit=>3)
  end
  def edit_success
    @questionbank=Admin::Questionbank.find(params[:id])
    @questions=Admin::Questionbank.find(:all,:select=>"id,question_code,subject_name,question_number,internal_ref_number",:order=>'created_at DESC',:limit=>3)
  end
  
  def questions_under_subject
    @subject=Admin::Subject.find(params[:id])
    @questionbanks=Admin::Questionbank.find(:all,:order=>'created_at DESC',:conditions=>"subject_id='#{@subject.id}'")
  end ## end of question_under_subject method
  
  def edit_question
    @questions=Admin::Questionbank.find(:all,:select=>"id,question_code,subject_name,question_number,internal_ref_number",:order=>'created_at DESC',:limit=>3)
    @questionbank=Admin::Questionbank.find(params[:id])
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
   @sectiontopics=Admin::Sectiontopic.find(:all,:select => 'DISTINCT Topic,id')
 @sectiontags=Admin::Sectiontemplate.find(:all,:select=>'SectionTags')
  end # end of edit_question method
  
  def update_question
    @questions=Admin::Questionbank.find(:all,:select=>"id,question_code,subject_name,question_number,internal_ref_number",:order=>'created_at DESC',:limit=>3)
    @questionbank=Admin::Questionbank.find(params[:id])
    @examtypes=Admin::Examtype.find(:all,:select=>"id,examtype",:order=>'examtype')
     @sectiontopics=Admin::Sectiontopic.find(:all,:select => 'DISTINCT Topic,id')
       @sectiontags=Admin::Sectiontemplate.find(:all,:select=>'SectionTags')
       totalexamtypes = ""
      i=1
    @examtypes.size.times{
      examtypes =  params['etype'+i.to_s]['checked']
      if  totalexamtypes == ''
        totalexamtypes = examtypes
      else
        totalexamtypes = totalexamtypes+','+examtypes
      end
      i=i+1
    }
     @questionbank.examtype_tags=totalexamtypes
    if @questionbank.question_media_type==0 # if question type is textual
      @questionbank.update_attributes(params[:questionbank])
      redirect_to :action => 'edit_success', :id => @questionbank
    elsif @questionbank.question_media_type==1 #if question type is graphical  
      @questionbank.topic=params[:questionbank][:topic]
      @questionbank.sub_topic=params[:questionbank][:sub_topic]
      @questionbank.sub_sub_topic=params[:questionbank][:sub_sub_topic]
      @questionbank.tags=params[:questionbank][:tags]
      @questionbank.correct_answer=params[:questionbank][:correct_answer]
      @questionbank.source=params[:questionbank][:source]
      @questionbank.author=params[:questionbank][:author]
      @questionbank.comments=params[:questionbank][:comments]
      @questionbank.internal_ref_number=params[:questionbank][:internal_ref_number]
      @questionbank.topic=params[:questionbank][:topic].strip
    @questionbank.tags=params[:questionbank][:tags].strip
      Admin::Questionbank.save_imagepaths_in_db(params[:questionbank],@questionbank,@questionbank.subject_code,@questionbank.question_code)## to save the image paths in db
      @questionbank.save
      Admin::Questionbank.delete_previous_files(params[:questionbank]) ## to delete the previous files in application if they exist       
      Admin::Questionbank.save_images(params[:questionbank],@questionbank.subject_code,@questionbank.question_code)## and save the files(images) again
      redirect_to :action => 'edit_success', :id => @questionbank
    else
      render :action => 'edit_question'
    end
  end
  ######## This method is used to seach a question by its reference number
  def search_results_ref_num  
    query = params[:query].strip if params[:query]
    if query and request.xhr?
      @questions = Admin::Questionbank.find(:all,:order=>'created_at DESC', :conditions => ["internal_ref_number LIKE ?", "%#{query}%"])     
      render :partial => "search_results_all", :layout => false, :locals => {:searchresults =>  @questions} 
    end
  end
  ######## This method is used to seach a question by its tags
  def search_by_tags    
    query = params[:query].strip if params[:query]
    if query and request.xhr?
      @questions = Admin::Questionbank.find(:all,:order=>'created_at DESC', :conditions => ["tags LIKE ?", "%#{query}%"])     
      render :partial => "search_results_all", :layout => false, :locals => {:searchresults =>  @questions} 
    end
  end 
  ######## This method is used to seach a question by its Number
  def search_by_que_num    
    query = params[:query].strip if params[:query]
    if query and request.xhr?
      @questions = Admin::Questionbank.find(:all,:order=>'created_at DESC', :conditions => ["question_number LIKE ?", "%#{query}%"])     
      render :partial => "search_results_all", :layout => false, :locals => {:searchresults =>  @questions} 
    end
  end 
  def search_by_que_code    
    query = params[:query].strip if params[:query]
    if query and request.xhr?
      @questions = Admin::Questionbank.find(:all,:order=>'created_at DESC', :conditions => ["question_code LIKE ?", "%#{query}%"])     
      render :partial => "search_results_all", :layout => false, :locals => {:searchresults =>  @questions} 
    end
  end 
  ### This methods is used to display the topics,subtipics,subsubtipics with auto complete select boxes ########
  def auto_complete_for_questionbank_topic
    if params[:questionbank][:topic] and request.xhr?
      auto_complete_responder_for_questionbanks params[:questionbank][:topic]
    end
  end
  ###########################################################################################################
  def auto_complete_for_questionbank_sub_topic
    @subtopics = Admin::Questionbank.find(:all, :select => 'DISTINCT sub_topic',:conditions => [ 'topic = ? and LOWER(sub_topic) LIKE ?',params[:topic], '%' + params[:questionbank][:sub_topic].downcase + '%' ] ,:order => 'created_at ASC',:limit => 8)
    render :partial => 'sub_topics',:layout => false
  end
  def auto_complete_for_questionbank_sstopic
    @subsubtopics = Admin::Questionbank.find(:all, :select => 'DISTINCT sub_sub_topic',:conditions => [ 'sub_topic = ? and LOWER(sub_sub_topic) LIKE ?',params[:sub_topic], '%' + params[:questionbank][:sub_sub_topic].downcase + '%' ] ,:order => 'created_at ASC',:limit => 8)
    render :partial => 'sub_sub_topics',:layout => false
  end
  
  ##########################################################################################################
  
  private
  def auto_complete_responder_for_questionbanks(value)
    @topics = Admin::Questionbank.find(:all, :select => 'DISTINCT topic',:conditions => [ 'LOWER(topic) LIKE ?', '%' + value.downcase + '%' ] ,:order => 'created_at ASC',:limit => 20)
    render :partial => 'topics',:layout => false
  end
end
