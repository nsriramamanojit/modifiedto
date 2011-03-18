class DemoanalysisController < ApplicationController
  include AuthenticatedSystem
  layout 'demoanalysis'
  def index
    if  Studentexam.update_column('LoggedIn',0, session[:demouser_id], session[:examId], session[:examTemplateId], session[:examDayNumber])
      @demoexamsections=Demoexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
      :select=>"SectionTitle,NumQuestionsInSection,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,SectionScore")
      @graph = open_flash_chart_object(600,300,'/demoanalysis/bargraph') 
      @graph1 = open_flash_chart_object(600,450, '/demoanalysis/topic_chart')
    else
      puts "######### Studentexam not updated to LOggedIn=0"
    end
  end
  def view
    @graph = open_flash_chart_object(600,300,'/demoanalysis/bargraph') 
    @graph1 = open_flash_chart_object(500,250, '/demoanalysis/pie_links') 
  end
  def questionwise
    @demoexamsection=Demoexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
    :select=>"SectionTemplate_Id,SectionTitle,NumQuestionsInSection,SectionPaper,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,SectionScore")
  end
  
  def question_review
    @question=Admin::Questionbank.find_by_question_code(params[:qcode])
    @myanswer=params[:myanswer].to_i
    render :partial=>'showquestion'
  end
  def change_section
    @demoexamsection=Demoexamsection.find_by_SectionTemplate_Id(params[:secTempId],:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ? ',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])
    @demoexamsections=Demoexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]],
    :select=>"SectionTemplate_Id,SectionTitle,NumQuestionsInSection,SectionPaper,NumQuestionsAttempted,NumAnswersCorrect,NumAnswersIncorrect,SectionScore")
  end
  
  def bargraph
    @demoexamsection=Demoexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])
    bar1 = BarGlass.new(50, '#FA3737','#D50000') #blue:#002995,red:#D50000,black;#050505
    bar1.key('Total Questions in section', 12)
    bar2 = BarGlass.new(50, '#3565E2','#002995')
    bar2.key('You Attempted', 12)
    bar3 = BarGlass.new(50, '#639F45','#FFFFFF')
    bar3.key('Answered correctly', 12)
    @demoexamsection.each do |t|
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
    g.set_y_max(10)
    g.set_y_label_steps(10)
    g.set_y_legend(" Number of Questions",15, "#000")
    g.set_inner_background('#FFFFFF')
    g.set_bg_color('#FFFFFF')
    render :text => g.render
  end
  def pie_links
    @demoexamsection=Demoexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]]) 
    data = []
    links= []
    @demoexamsection.each do |t|
      temp1=t.NumQuestionsInSection
      links << "javascript:alert('Your score is #{temp1}')"
      data << temp1
    end
    g = Graph.new
    g.pie(60, '#505050', '{font-size: 12px; color: #404040;}')
    g.pie_values(data, %w(section1 section2 section3 ), links)
    g.pie_slice_colors(%w(#d01fc3 #356aa0 #c79810))
    g.set_tool_tip( "your score in section is #val#")
    g.title("Analysis Report", '{font-size:18px; color: #d01f3c}' )
    render :text => g.render
  end
  def topic_chart
    @topics = Array.new(16, '')
    @topics[0]="Materials"
    @topics[1]="Electron Devices and ICs"
    @topics[2]="Network Theory"
    @topics[3]="Electromagnetic Theory"
    @topics[4]="Communication Systems"
    @topics[5]="Microwave Engineering"
    @topics[6]="Control Systems"
    @topics[7]="Analog Electronic Circuits"
    @topics[8]="English"
    @topics[9]="Science and Technology"
    @topics[10]="Current Affairs"
    @topics[11]="L"
    @topics[12]="M"
    @topics[13]="N"
    @topics[14]="O"
    @topics[15]="P"
    @total_questions = Array.new(16, 0)
    @correct_ans = Array.new(16, 0)
    @sectionpaper=Viewdemosection.find(:all,:select => 'SectionPaper', :conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:demouser_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])  
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
    values = Array.new(11, '')
    for i in 0..10 do
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
