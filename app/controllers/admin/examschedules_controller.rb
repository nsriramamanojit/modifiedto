class Admin::ExamschedulesController < ApplicationController
  # GET /admin_examschedules
  # GET /admin_examschedules.xml
  layout 'admin_home'
  
  def update_schedules
    @exam = Admin::Exam.find(params[:Exam_Id])
    @examDayNumber = @exam.NumDaysScheduled 
    session[:examid]=params[:Exam_Id]
    render :update do |page|
     page.replace_html 'newschedule', :partial => 'newschedule', :object => @examDayNumber
    end
  end
    
  def index
    @examschedules = Admin::Examschedule.find(:all)
    @examnames = Admin::Examschedule.find(:all,:select=>"DISTINCT Exam_Id")
   end

  # GET /admin_examschedules/1
  # GET /admin_examschedules/1.xml
  def show
    @examnames = Admin::Examschedule.find(:all,:select=>"DISTINCT Exam_Id")
    @examschedule = Admin::Examschedule.find(:all,:select=>"DISTINCT Exam_Id,ExamDayNumber,ExamDayStatus,ScheduledDate,ScheduledTime",:conditions=>"Exam_Id="+params[:examid])
  end

  # GET /admin_examschedules/new
  # GET /admin_examschedules/new.xml
  def new
    #@exam = Admin::Exam.find('1')
    @examschedule = Admin::Examschedule.new
     @examnames = Admin::Examschedule.find(:all,:select=>"DISTINCT Exam_Id")
   # @examschedules = Admin::Examschedule.find(:all,:select=>"id,Exam_Id,ExamName")
    @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName",:conditions=>"ExamStatus='1'")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examschedule }
    end
  end

  # GET /admin_examschedules/1/edit
  def edit
    @examnames = Admin::Examschedule.find(:all,:select=>"DISTINCT Exam_Id")
    session[:editexamid] = params['examid']   
    @examschedule = Admin::Examschedule.find_by_Exam_Id(params['examid'])
    @examschedules = Admin::Examschedule.find(:all,:conditions=>"Exam_Id="+params['examid'])
    @exams = Admin::Exam.find(:all,:select=>"Exam_Id,ExamName",:conditions=>"ExamStatus='1'")
   
  end

  # POST /admin_examschedules
  # POST /admin_examschedules.xml
  def create
    @exam = Admin::Exam.find(session[:examid])
    i = 1
     i.upto(@exam.NumDaysScheduled) {
      @examschedule = Admin::Examschedule.new(params[:examschedule])
      date = params['e_date_and_time_mixed'+i.to_s]
      @examschedule.Exam_Id = session[:examid]
      @examschedule.ExamDayNumber = params['ExamDayNumber'+i.to_s].to_s
      @examschedule.ScheduledDate = date
      @examschedule.ScheduledTime = date[date.length-8,date.length].to_s  
      @examschedule.ExamDayStatus='1'
      @examschedule.ExamDayStatus = '1'
     @examschedule.save
      i=i+1
    }
     redirect_to :action=>'index'
  end

  # PUT /admin_examschedules/1
  # PUT /admin_examschedules/1.xml
  def update
     @exam = Admin::Exam.find(session[:editexamid])
     @ids = Admin::Examschedule.find_by_Exam_Id(session[:editexamid])
     j = @ids.id
    @examDayNumber = @exam.NumDaysScheduled 
    i=1
    i.upto(@examDayNumber){
    date = params['e_date_and_time_mixed'+i.to_s].to_s
    Admin::Examschedule.update(j, {:ExamDayNumber => params[:examschedule]['ExamDayNumber'+i.to_s]})
    if date.length > 18
    Admin::Examschedule.update(j, {:ScheduledDate => date})
    Admin::Examschedule.update(j, {:ScheduledTime=> date[date.length-8,date.length]})
    else
    Admin::Examschedule.update(j, {:ScheduledDate => date[0,10]})
    Admin::Examschedule.update(j, {:ScheduledTime=> date[11,18]})
    end
    j = j+1
    i=i+1}
   redirect_to :action =>'index'

  end

  # DELETE /admin_examschedules/1
  # DELETE /admin_examschedules/1.xml
  def destroy
    @examschedule = Admin::Examschedule.find(params[:id])
    @examschedule.destroy

    respond_to do |format|
      format.html { redirect_to :action=>"index" }
      format.xml  { head :ok }
    end
  end
end
