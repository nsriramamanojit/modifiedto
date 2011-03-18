class DemoexamController < ApplicationController
  layout 'home',:except=>[:show_indicators]
   include AuthenticatedSystem
  def index
    @demouser=Demouser.new
     session[:examName]='LSSA Six Sigma'
    if @demouser.save!
     
      session[:demouser_id]=@demouser.id
      puts "############# "+session[:demouser_id].to_s
      exam = Admin::Exam.find_by_ExamName(session[:examName],:select=>"ExamTemplate_Id,ExamName,ExamType,Exam_Id")
      service= Admin::Service.find_by_service_name(session[:examName],:select=>"payment_required")
      examTemplate = Admin::Examtemplate.find_by_ExamTemplate_Id(exam.ExamTemplate_Id,:select=>'TotalDurationMinutes')
      #########Declaring Session Variables for Exam_Id and ExamTemplate_Id (we can access this variables any where after user's repassword is success) #####
      session[:examId] = exam.Exam_Id
      session[:examTemplateId]= exam.ExamTemplate_Id
      ######## session Varibles declaration completed ######### 
      if service.payment_required==false and !Studentexam.exists?([session[:demouser_id],session[:examId],session[:examTemplateId], 0])
        # if it is a Sample Service no payments Required Then ExamMode will be 'S' and ExamDayNumber=0 else 'P' ExamDayNumber='get this from ExamSchedules'
        session[:examDayNumber]=0
        studentexam=Studentexam.new
        Studentexam.save_user_exam(studentexam,session[:demouser_id],exam,session[:examName],'S',examTemplate.TotalDurationMinutes,'demologin',session[:examDayNumber])
        studentexam.save
        ####### Calling the class method(update_column) of StudentExam Updates single column with given arguments#######
        Studentexam.update_column('StudentEligible', 1, session[:demouser_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
        redirect_to :action=>'instructions' 
      else
      flash[:error]="Not a Demo Test"
       end
   else
     # i.e; the service is free and Student aleady written the exam and he/her closes the exam in middel(does't complete the exam completely)
        studentexam = Studentexam.find(session[:demouser_id],session[:examId].to_i,session[:examTemplateId].to_i, session[:examDayNumber].to_i,:select=>"LoggedIn,ExamMode")
        session[:examDayNumber]=0
        if studentexam.LoggedIn==false && studentexam.ExamMode=="S"
          Studentexam.update_column('WaitingForExam', 1, session[:demouser_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
          ######### Note:- updating LoggedIn from 0 to 1 ,trigger fires and that trigger generates user section records in the activexamsections
          #######  and from activexamsections , viewactivesections view is created with section records ##########
          Studentexam.update_column('LoggedIn', 1, session[:demouser_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
          redirect_to :action=>'instructions'
        else  studentexam.LoggedIn==true && studentexam.ExamMode=="S" ##student lefted the exam in middle(i.e uncompleted exam), so redirecting to the uncompleted exam page
          redirect_to :action=>'uncompletedexam'
        end 
   end
 end
 def instructions
    ########## This page shows the instructions to user,  "how to write the exam" ##########
  end
  def show_indicators
    
  end
  def update_loggedin
    ########### Updating LoggedIn from 0 to 1 generates the activexamsextions ##########
    if   Studentexam.update_column('LoggedIn', 1, session[:demouser_id], session[:examId], session[:examTemplateId],  session[:examDayNumber])###### Note:- Change ExamDayNumber For ScheduledExam(where ExamMode="P")
      redirect_to  :controller=>'demoactivexam',:action=>'sections'
    else
      puts "@@@@@@@@@@@@@  LoggedIn is not updated from 0 to 1 so activeexamsection records are not create..Internal Error"
      flash[:error]="Oops Something went wrong"
      render :action=>'instructions'
    end
  end
end
