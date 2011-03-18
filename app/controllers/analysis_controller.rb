class AnalysisController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required
  layout 'analysis'
  def index
    if  Studentexam.update_column('LoggedIn',0, session[:user_id], session[:examId], session[:examTemplateId], session[:examDayNumber])
      @solvedexamsections=Solvedexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
      :select=>"SectionTitle,NumQuestionsInSection,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,SectionScore")
      @graph = open_flash_chart_object(600,300,'/analysis/bargraph') 
    @graph1 = open_flash_chart_object(600,450, '/analysis/topic_chart')
    else
      puts "######### Studentexam not updated to LOggedIn=0"
    end
  end
  
  def view
    @graph = open_flash_chart_object(600,300,'/analysis/bargraph') 
    @graph1 = open_flash_chart_object(500,250, '/analysis/pie_links') 
  end
  def questionwise
    @solvedexamsection=Solvedexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
    :select=>"SectionTemplate_Id,SectionTitle,NumQuestionsInSection,SectionPaper,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,SectionScore")
  end
  
  def question_review
    @question=Admin::Questionbank.find_by_question_code(params[:qcode])
    @myanswer=params[:myanswer].to_i
    render :partial=>'showquestion'
  end
  def change_section
    @solvedexamsection=Solvedexamsection.find_by_SectionTemplate_Id(params[:secTempId],:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ? ',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])
    @solvedexamsections=Solvedexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
    :select=>"SectionTemplate_Id,SectionTitle,NumQuestionsInSection,SectionPaper,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,SectionScore")
  end
  
  def bargraph
    @solvedexamsection=Solvedexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])
     bar1 = BarGlass.new(50, '#FA3737','#D50000') #blue:#002995,red:#D50000,black;#050505
    bar1.key('Total Questions in section', 12)
    bar2 = BarGlass.new(50, '#3565E2','#002995')
    bar2.key('You Attempted', 12)
    bar3 = BarGlass.new(50, '#639F45','#FFFFFF')
    bar3.key('Answered correctly', 12)
    @solvedexamsection.each do |t|
      bar1.data << t.NumQuestionsInSection
      bar2.data << t.NumQuestionsAttempted
      bar3.data << t.NumAnswersCorrect
    end
    g = Graph.new
    g.title("Section-wise Analysis", "{font-size: 22px;}")
    g.data_sets << bar1
    g.data_sets << bar2
    g.data_sets << bar3
    g.set_x_labels(%w(Section-1 Section-2 Section-3))
    g.set_x_label_style(15, '#000', 0, 1)
    g.set_x_axis_steps(2)
    g.set_y_max(50)
    g.set_y_label_steps(10)
    g.set_y_legend(" Number of Questions",15, "#000")
    g.set_inner_background('#FFFFFF')
    g.set_bg_color('#FFFFFF')
    render :text => g.render
    end
  
  def topic_chart
    @topics = Array.new(17, '')
    @topics[0]="Materials"
    @topics[1]="Electron Devices and ICs"
    @topics[2]="Network Theory"
    @topics[3]="Electromagnetic Theory"
    @topics[4]="Electronic Measurements Instrumentation"
    @topics[5]="Power Electronics"
    @topics[6]="Analog Electronic Circuits"
    @topics[7]="Digital Electronic Circuits"
    @topics[8]="Control Systems"
    @topics[9]="Communication Systems"
    @topics[10]="Microwave Engineering"
    @topics[11]="Computer Engineering"
    @topics[12]="Microprocessors"
    @topics[13]="English"
    @topics[14]="Science and Technology"
    @topics[15]="Current Affairs"
    @topics[16]="Others"
    @total_questions = Array.new(17, 0)
    @correct_ans = Array.new(17, 0)
    @sectionpaper=Viewsolvedsection.find(:all,:select => 'SectionPaper', :conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])  
    @sectionpaper.each do |section|
      questionpaper = section.SectionPaper
      @questions = questionpaper.split(',')
      @questions.each  do |qword|
        qpart = qword.split(':', 2)
        question_code = qpart[0]
        topic_code = qpart[1][0]
        correct_answer = qpart[1][3].chr
        student_answer = qpart[1][4].chr
        topic_id = topic_code - ?A
        @total_questions[topic_id] += 1
        @correct_ans[topic_id] += 1  if correct_answer == student_answer
      end
    end  # each section
    # draw the graph for all the topics and correct answer totals
    g = Graph.new
    g.set_x_label_style(2, '#9933CC')
    g.set_y_label_steps(10)
    g.set_bg_color('#FFFFFF')
    g.set_y_min(0) 
    g.set_y_max(100)
    values = Array.new(17, '')
    for i in 0..16 do
      values[i] = @topics[i]
    end
    g.set_x_labels(values)
    data = []
    values.each_with_index do |item, index| 
      totals=@total_questions[index]
      right_ans=@correct_ans[index]
      percentile=(right_ans.to_f / totals.to_f ) * 100.0
      data << percentile
    end
    g.set_data(data)
    g.line_hollow(2, 4, '#002995', ' Percentage Level', 10)
    g.set_x_label_style( 10, '#000',2);
    g.set_title("Topic-wise Performance Analysis", '{font-size: 22px; color: #000}')
    g.set_y_legend("Percentage of Right Answers",12, "#000")
    g.set_tool_tip("#val# % ")
    render :text => g.render
  end # topic_chart
  
end
