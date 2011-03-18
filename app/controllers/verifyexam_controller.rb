class VerifyexamController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required
  layout 'home'
  def password_required
    session[:examName]=params[:examname]
  end
  def verify_password
    if User.authenticate(current_user.login, params[:re_password]) ## if user password is correct
      exammode='S'
      exam = Admin::Exam.find_by_ExamName(session[:examName],:select=>"ExamTemplate_Id,ExamName,ExamType,Exam_Id")
      service= Admin::Service.find_by_service_name(session[:examName],:select=>"payment_required")
      examTemplate = Admin::Examtemplate.find_by_ExamTemplate_Id(exam.ExamTemplate_Id,:select=>'TotalDurationMinutes')
      #########Declaring Session Variables for Exam_Id and ExamTemplate_Id (we can access this variables any where after user's repassword is success) #####
      session[:examId] = exam.Exam_Id
      session[:examTemplateId]= exam.ExamTemplate_Id
      ######## session Varibles declaration completed ######### 
      if service.payment_required==false and !Studentexam.exists?([session[:user_id],session[:examId],session[:examTemplateId], 0])
        # if it is a Sample Service no payments Required Then ExamMode will be 'S' and ExamDayNumber=0 else 'P' ExamDayNumber='get this from ExamSchedules'
        session[:examDayNumber]=0
        studentexam=Studentexam.new
        Studentexam.save_user_exam(studentexam,session[:user_id],exam,session[:examName],exammode,examTemplate.TotalDurationMinutes,current_user.login,session[:examDayNumber])
        studentexam.save
        ####### Calling the class method(update_column) of StudentExam Updates single column with given arguments#######
        Studentexam.update_column('StudentEligible', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
        redirect_to :action=>'instructions' 
      elsif service.payment_required==false and Studentexam.exists?([session[:user_id],session[:examId],session[:examTemplateId], 0])
        # i.e; the service is free and Student aleady written the exam and he/her closes the exam in middel(does't complete the exam completely)
        studentexam = Studentexam.find(session[:user_id],session[:examId].to_i,session[:examTemplateId].to_i, session[:examDayNumber].to_i,:select=>"LoggedIn,ExamMode")
        session[:examDayNumber]=0
        if studentexam.LoggedIn==false && studentexam.ExamMode=="S"
          Studentexam.update_column('WaitingForExam', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
          ######### Note:- updating LoggedIn from 0 to 1 ,trigger fires and that trigger generates user section records in the activexamsections
          #######  and from activexamsections , viewactivesections view is created with section records ##########
          Studentexam.update_column('LoggedIn', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
          redirect_to :action=>'instructions'
        else  studentexam.LoggedIn==true && studentexam.ExamMode=="S" ##student lefted the exam in middle(i.e uncompleted exam), so redirecting to the uncompleted exam page
          redirect_to :action=>'uncompletedexam'
        end 
      elsif service.payment_required==true and !Studentexam.exists?([session[:user_id],session[:examId],session[:examTemplateId], 1])
        # if it is a Paid Service payment Required Then ExamMode will be 'p' and  ExamDayNumber='get this from ExamSchedules'
        session[:examDayNumber]=1
        exammode='P'
        studentexam=Studentexam.new
        Studentexam.save_user_exam(studentexam,session[:user_id],exam,session[:examName],exammode,examTemplate.TotalDurationMinutes,current_user.login,session[:examDayNumber])
        studentexam.save
        ####### Calling the class method(update_column) of StudentExam Updates single column with given arguments#######
        Studentexam.update_column('StudentEligible', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
        redirect_to :action=>'instructions' 
      elsif service.payment_required==true and Studentexam.exists?([session[:user_id],session[:examId],session[:examTemplateId], 1])
        # i.e; the service is free and Student aleady written the exam and he/her closes the exam in middel(does't complete the exam completely)
      session[:examDayNumber]=1
        studentexam = Studentexam.find(session[:user_id].to_i,session[:examId].to_i,session[:examTemplateId].to_i, session[:examDayNumber].to_i,:select=>"LoggedIn,ExamMode,ExamCompleted")
        
        if studentexam.LoggedIn==false && studentexam.ExamMode=="P" && studentexam.ExamCompleted==false
          Studentexam.update_column('WaitingForExam', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
          ######### Note:- updating LoggedIn from 0 to 1 ,trigger fires and that trigger generates user section records in the activexamsections
          #######  and from activexamsections , viewactivesections view is created with section records ##########
          Studentexam.update_column('LoggedIn', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
          redirect_to :action=>'instructions'
        elsif  studentexam.LoggedIn==true && studentexam.ExamMode=="P" && studentexam.ExamCompleted==false ##student lefted the exam in middle(i.e uncompleted exam), so redirecting to the uncompleted exam page
          redirect_to :action=>'uncompletedexam'
        else studentexam.LoggedIn==false && studentexam.ExamMode=="P" && studentexam.ExamCompleted==true 
           redirect_to :action=>'already_complete'
        end 
      end # end of @service.payment_required==false
    else
        flash[:error]="The Password doesn't match"
        render :action =>'password_required'
    end # end of User.authenticate method
  end
  
  def instructions
    ########## This page shows the instructions to user,  "how to write the exam" ##########
  end
  def update_loggedin
    ########### Updating LoggedIn from 0 to 1 generates the activexamsextions ##########
    if   Studentexam.update_column('LoggedIn', 1, session[:user_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
      redirect_to  :controller=>'activexam',:action=>'sections'
    else
      puts "@@@@@@@@@@@@@  LoggedIn is not updated from 0 to 1 so activeexamsection records are not create..Internal Error"
      flash[:error]="Oops Something went wrong"
      render :action=>'instructions'
    end
  end
  def view_results
     exam = Admin::Exam.find_by_ExamName(session[:examName],:select=>"ExamTemplate_Id,Exam_Id")
      session[:examId] = exam.Exam_Id
      session[:examTemplateId]= exam.ExamTemplate_Id
      session[:examDayNumber]=1
      redirect_to :controller=>'analysis'
  end
end
