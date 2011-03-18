class GraphicalanalysisController < ApplicationController
  layout 'analysis'
  def view
    @graph = open_flash_chart_object(350,200,'/graphicalanalysis/index') 
    @graph1 = open_flash_chart_object(500,250, '/graphicalanalysis/pie_links') 
   end
 
  def index
   @viewactivesection=Activexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]])
   bar1 = Bar.new(50, '#0066CC')
  bar1.key('TotalQuestions in section1', 10)
  
  bar2 = Bar.new(50, '#9933CC')
  bar2.key('You Attempted', 10)
  
  bar3 = Bar.new(50, '#639F45')
  bar3.key('Answered correctly', 10)
  
   @viewactivesection.each do |t|
      bar1.data << t.NumQuestionsInSection
      bar2.data << t.NumQuestionsAttempted
      bar3.data << t.NumAnswersCorrect
   end
    g = Graph.new
    g.title("Know your status", "{font-size: 26px;}")
    g.data_sets << bar1
    g.data_sets << bar2
    g.data_sets << bar3
    g.set_x_labels(%w(section1 section2 section3))
    g.set_x_label_style(10, '#9933CC', 0, 1)
    g.set_x_axis_steps(2)
    g.set_y_max(100)
    g.set_y_label_steps(4)
    g.set_y_legend(" Student Analysis Report",12, "0x736AFF")
    render :text => g.render
  end
  
  
  
  def pie_links
   @viewactivesection=Activexamsection.find(:all,:conditions => ['Student_Id = ? AND Exam_Id = ? AND ExamTemplate_Id = ? AND ExamDayNumber = ?',session[:user_id],session[:examId],session[:examTemplateId],session[:examDayNumber]]) 
   data = []
   links= []
   @viewactivesection.each do |t|
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

  end

