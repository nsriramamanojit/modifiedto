class DemoqueoperationsController < ApplicationController
  layout nil
 before_filter :queByCode
  def question_by_code 
 @qId = params[:qId]
  @secTemplateId=params[:secTId].to_s
  puts "################# "+params[:secTId].to_s
    ######### identifying the record to update current question needs , session variables curent_demouser_id,examId,examTemplateId,sectionTemplateId
    @studentPresentSection  =  Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:secTId],:select=>"NumQuestionsInSection,NumQuestionsAttempted")
    ######### Updating the current Question Code on clicking the QuestionNumber
     Viewactivesection.update_column('CurrentQuestionCode', params[:qCode],session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:secTId])
    @numQuestionsAttempted =@studentPresentSection.NumQuestionsAttempted
  end
  def get_previous_question_by_srNo
    @studentPresentSection  =  Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:secTId],:select=>"CurrentQuestionPointer,SectionPaper")
    qPastQuestionOffset=(8*(@studentPresentSection.CurrentQuestionPointer-2))
    questionCode=@studentPresentSection.SectionPaper[qPastQuestionOffset..(qPastQuestionOffset+4)]
    queId=params[:qId].to_i - 1
    redirect_to :action=>'question_by_code',:qCode=>questionCode,:qId=>queId,:secTId=>params[:secTId]
  end
  
  def get_next_question_by_srNo
    @studentPresentSection  =  Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:secTId],:select=>"CurrentQuestionPointer,SectionPaper")
    qCurrentQuestionOffset=(8*@studentPresentSection.CurrentQuestionPointer)
    questionCode=@studentPresentSection.SectionPaper[qCurrentQuestionOffset..(qCurrentQuestionOffset+4)]
    queId=params[:qId].to_i + 1
    redirect_to :action=>'question_by_code',:qCode=>questionCode,:qId=>queId,:secTId=>params[:secTId]
  end
  private
  def queByCode 
    ## @question this instance variable we can use any where in this class if u need.Because this method is filtered before rendering any actions of this class. 
    @question = Admin::Questionbank.find_by_question_code(params[:qCode],
    :select=>"question_media_type,question_imagepath,option1_imagepath,option2_imagepath,
    option3_imagepath,option4_imagepath,question_text,option1_text,option2_text,option3_text,option4_text,question_code")
    
  end
end
