class CreateStudentexams < ActiveRecord::Migration
  def self.up
    
      create_table :studentexams, :id=>false do |t|
       t.column :Student_Id,'int(10) unsigned',:null=>false
       t.column :Exam_Id,'smallint(5) unsigned',:null=>false
       t.column :ExamTemplate_Id,'smallint(5) unsigned',:null=>false
       t.column :ExamDayNumber,'tinyint(3) unsigned',:null=>false
       t.column :ExamMode,'char(1)',:null=>false,:default=>'S'
       t.string :HallTicketNumber,:limit=>45
       t.string :StudentLoginName,:limit => 45
       t.string :StudentPassword,:limit => 45
       t.string :ExamName,:limit => 45,:null=>false
       t.date :ExamDate
       t.time :ExamTime
       t.string :ExamCenterCode,:limit => 45
       t.string :ExamCenterLocation,:limit => 45
       t.string :Region,:limit => 45
       t.string :StateCode,:limit => 30
       t.column :ExamDurationMinutes,'smallint(3) unsigned',:null=>false
       t.string :RandomSeed,:limit => 45
       t.column :QuestionSelectionCriteria,'char(1)'
       t.column :QuestionPaperReady,'tinyint(1) unsigned',:null=>false,:default=>0
       t.string :QuestionPaper,:limit => 4000,:null=>false,:default=>''  
       t.column :StudentEligible,'tinyint(1) unsigned',:null=>false,:default=>0
       t.column :StudentInformed,'tinyint(1) unsigned',:null=>false,:default=>0
       t.column :WaitingForExam,'tinyint(1) unsigned',:null=>false,:default=>0
       t.string :ExamStatus,:limit=>25,:null=>false,:default=>'not yet started'
       t.column :LoggedIn,'tinyint(1) unsigned',:null=>false,:default=>0
       t.column :ExamStarted,'tinyint(1) unsigned',:null=>false,:default=>0
       t.column :ExamTimedOut,'tinyint(1) unsigned',:null=>false,:default=>0
       t.column :ExamCompleted,'tinyint(1) unsigned',:null=>false,:default=>0
       t.column :ExamInterrupted,'tinyint(1) unsigned',:null=>false,:default=>0
       t.time   :ExamStartTime
       t.time   :ExamCompletedTime
       t.column :ExamExtraDurationMinutes,'tinyint(3) unsigned',:null => false,:default=>0 
       t.column :ExamLateStartMinutes,'tinyint(3) unsigned',:null => false,:default=>0 
       t.time   :ExamClosingTime
       t.column :TotalTimeTaken,'tinyint(10) unsigned',:null=>false,:default=>0
       t.column :NumQuestionsAttempted,'smallint(5) unsigned',:null=>false,:default=>0 
       t.column :NumAnswersCorrect,'smallint(5) unsigned',:null=>false,:default=>0  
       t.column :NumAnswersIncorrect,'smallint(5) unsigned',:null=>false,:default=>0   
       t.column :TotalNegativeScore,'decimal',:null=>false,:default=>0
       t.column :TotalPositiveScore,'decimal',:null=>false,:default=>0
       t.column :TotalScore,'decimal',:null=>false,:default=>0
       t.string :PercentileScore,:limit=>10
       t.column :Grade,'char(2)'
       t.column :ExamResultInformed,'tinyint(1) unsigned',:null=>false,:default=>0
       t.string :StudentDifficultyRating,:limit=>45
       t.string :PerformanceEvaluation,:limit=>1000
       t.string :StudentFeedback,:limit=>1000
       t.string :Comments,:limit => 500
       
       
      t.timestamps
    end
  end

  def self.down
    drop_table :studentexams
  end
end
