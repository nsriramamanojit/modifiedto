class DemoactivexamController < ApplicationController
  layout 'testingLayout'
  def index
    @sectionTemplateId =  params['SectionTemplateId'].to_i
    ###### user started the exam so update ExamStarted from 0 to1 in Studentexam ####
   Studentexam.update_column('ExamStarted', 1, session[:demouser_id], session[:examId], session[:examTemplateId], session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
    ### Getting the Viewactivesection record for current section(i.e for user selected section)
    @Studentexams  =  Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],@sectionTemplateId,:select=>"CurrentQuestionCode,CurrentQuestionPointer,NumQuestionsInSection,SectionPaper,CurrentMarkReviewFlags,ExamSecondsLeft")
   ############ Updating ExamStarted from 0 to 1 for user selected section #######
    Viewactivesection.update_column('ExamStarted', 1, session[:demouser_id], session[:examId], session[:examTemplateId], session[:examDayNumber], @sectionTemplateId)
    @NumQuestionsInSection= @Studentexams.NumQuestionsInSection
    ########### Get all Sections(sectiontemplates) except user selected section and update ExamStarted from 0 to 1 #########
    @SectiontempAll   =  Admin::Sectiontemplate.find(:all,:conditions=>['ExamTemplate_Id='+session[:examTemplateId].to_s+' && SectionTemplate_Id NOT IN (?)', @sectionTemplateId] ) 
    @SectiontempAll.each do |sections| 
      Viewactivesection.update_column('ExamStarted',1,session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],sections.SectionTemplate_Id)
    end
    @currentQuestionPointer = @Studentexams.CurrentQuestionPointer
    ######### Splitting the SectionPaper with (,) separates the QuestionCode and Answer(this answer is bydefault 0,when the user answers this will be updated accordingly) with other QuestionCode and Answer
  #  @section_questions_with_default_answers=@Studentexams.SectionPaper.split(',')
    ######## using @totalduration, on the top of the page the javascript timer will be starts 
   # The following query selects the minimum value of ExamSecondsLeft for current_user from viewactivesections
  @totalduration =Viewactivesection.minimum('ExamSecondsLeft',:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])/60
  end
  def sections
    ###### To Listing all the sections in sections page  #############
    @SectiontempAll  =  Admin::Sectiontemplate.find(:all,:conditions=>"ExamTemplate_Id="+session[:examTemplateId].to_s,:select=>"SectionTemplate_Id,SectionTitle")
  end
  def get_question_left_navigation ##########This action(Remote Function) invokes when user changes his section ########
    @sectionTemplateId =params[:currentSectId]
    @Studentexams     =  Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],@sectionTemplateId,:select=>"SectionPaper,CurrentQuestionCode,CurrentQuestionPointer,CurrentMarkReviewFlags")
    @section_questions_with_default_answers=@Studentexams.SectionPaper.split(',')
    @SectiontempAll   =  Admin::Sectiontemplate.find(:all,:conditions=>['ExamTemplate_Id='+session[:examTemplateId].to_s+' && SectionTemplate_Id NOT IN (?)', @sectionTemplateId] ,:select=>"SectionTitle,SectionTemplate_Id")
    render :update do |page|
      page.replace_html "questions", :partial => 'question_left_navigation',:object=>@Studentexams,:layout=>false
      page.replace_html "current_section", :partial => 'current_section_name',:object=>@sectionTemplateId,:layout=>false
      page.replace_html "other_section", :partial => 'other_section_names',:object=> @SectiontempAll,:layout=>false
      page[:question].replace_html '<iframe src="/demoqueoperations/question_by_code?qCode=' + @Studentexams.CurrentQuestionCode + '&qId='+ @Studentexams.CurrentQuestionPointer.to_s + '&secTId=' + @sectionTemplateId.to_s  + '" name = "qFrame" width="98%" height="400px" frameborder="0"></iframe>'
      #page.visual_effect :grow, 'question', :duration => 2
      page[:questions].visual_effect :highlight,:startcolor=>"#F15E5E?, :endcolor =>"#FFFFFF"
      page[:current_section].visual_effect :highlight,:startcolor=>"#F15E5E?, :endcolor =>"#FFFFFF"
      page[:other_section].visual_effect :highlight,:startcolor=>"#F15E5E?, :endcolor =>"#FFFFFF"
      ##Note:- where questions,current_section,other_section are div id names in respected partials..only the  content in this divs will be updated(refreshed)
    end 
  end
  def update_current_question_answer ########This action(Remote Function) invokes ,when user answers the question.(i.e on user clicks the radio button to answer the question)
   ######## Updating the CurrentQuestionAnswer to user answer in Viewactivesections 
    Viewactivesection.update_column('CurrentQuestionAnswer',params[:checkedAnswer],session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:sectTemId])
  ######### Updating CurrentReviewFlags at index of prams[:queId] if and only if the char==1 ##########
 @Studentexams = Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:sectTemId],:select=>"CurrentMarkReviewFlags")
   curr_mark_rev_flag =@Studentexams.CurrentMarkReviewFlags
  if curr_mark_rev_flag[params[:queId].to_i-1].chr=="1" ######## Returns the char at specified index
  curr_mark_rev_flag[params[:queId].to_i-1]="0"  #######if returned char is 1 then update it to 0
  Viewactivesection.update_column('CurrentMarkReviewFlags',curr_mark_rev_flag,session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:sectTemId])
  end
 end
  def update_current_question_reviewflag
  @Studentexams = Viewactivesection.find(session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:sectTemId],:select=>"CurrentMarkReviewFlags")
   curr_mark_rev_flag =@Studentexams.CurrentMarkReviewFlags
  curr_mark_rev_flag[params[:queId].to_i-1]="1"
  Viewactivesection.update_column('CurrentMarkReviewFlags',curr_mark_rev_flag,session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber],params[:sectTemId])
  end
 ######## This action invokes ,when user clicking on the IhaveCompletedtheExam button OR  @totalduration time is up. 
  def exam_complete
  #  @updateStudentExam = Studentexam.find(session[:demouser_id],session[:examId],session[:examTemplateId],0)
   # @updateStudentExam.update_attributes!({:ExamCompleted=>"1"})
   Studentexam.update_column('ExamCompleted', 1, session[:demouser_id], session[:examId], session[:examTemplateId], session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
# @studentexamscores=Viewactivesection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
#   :select=>"SectionTitle,NumQuestionsInSection,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,StudentSectionScore")
    redirect_to :controller=>'demoanalysis'
#render :partial=>'view_score',:layout=>'testingLayout',:object=>@studentexamscores,:update=>{:success =>Studentexam.update_column('LoggedIn',0, session[:demouser_id], session[:examId], session[:examTemplateId], session[:examDayNumber])}
   #cookies.delete :auth_token ###### deleting all the cookies according to user in this session
   # reset_session ############# setting the all sessions to nil
  ## NOTE :-1) Updating LoggedIn from 1 to 0 in the Studentexam ,deletes all the records associated with user in activexamnew,viewactivesection tables and 
  # that records will be moved to solvesexamsections table  if and only if the ExamMode="P"(Paid Service)
 ### NOTE:-2)The SampleExam(i.e ExamMode="S") records are deleted after the student exam completes from activexamsections,viewactivesections 
end

end
