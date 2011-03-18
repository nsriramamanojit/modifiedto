class CreateDemoexamsections < ActiveRecord::Migration
   def self.up
   create_table :demoexamsections,:id=>false do |t|
   t.column :Student_Id ,'int(10) unsigned',:null => false
   t.column :Exam_Id, 'smallint(5) unsigned',:null => false
   t.column :ExamDayNumber, 'tinyint(3) unsigned',:null => false
   t.column :ExamTemplate_Id , 'smallint(5) unsigned',:null => false
   t.column :SectionTemplate_Id, 'smallint(5) unsigned',:null => false
   t.column :Subject_Id, 'tinyint(3) unsigned',:null => false
   t.column :LoggedIn, 'tinyint(1) unsigned',:null => false,:default=>0

   t.column :ExamMode,'char(1)',:null=>false,:default=>'S'


   t.column :ExamStarted, 'tinyint(1) unsigned',:null => false,:default=>0
   t.column :ExamTimedOut, 'tinyint(1) unsigned',:null => false,:default=>0
   t.column :ExamInterrupted, 'tinyint(1) unsigned',:null => false,:default=>0
   t.column :ExamCompleted, 'tinyint(1) unsigned',:null => false,:default=>0
   t.string :SectionTitle,:limit=>45
   t.string :SectionPaper,:limit=>4000,:null => false,:default=>''
   t.string :SectionInstructions,:limit=>500
   t.column :CurrentQuestionPointer, 'tinyint(3) unsigned',:null => false,:default=>0
   t.string :CurrentQuestionCode,:limit=>10
   t.string :CurrentQuestionAnswer,:limit=>10,:null => false,:default=>'0'
   t.string :CurrentMarkReviewFlags,:limit=>250 ## new column added for question review 30/Dec
   t.column :NumQuestionsInSection, 'tinyint(3) unsigned',:null => false,:default=>0
   t.column :NumQuestionsAttempted, 'tinyint(3) unsigned',:null => false,:default=>0
   t.column :NumAnswersCorrect ,'tinyint(3) unsigned',:null => false,:default=>0##### new column added
   t.column :NumAnswersIncorrect ,'tinyint(3) unsigned',:null => false,:default=>0##### new column added
   t.column :SectionNegativeScore ,'decimal',:null => false,:default=>0##### new column added
   t.column :SectionPositiveScore ,'decimal',:null => false,:default=>0##### new column added
   t.column :SectionScore, 'decimal',:null => false,:default=>0   
   t.datetime   :ExamStartTime  ####### column type is changed from time to datetime
   t.datetime   :ExamCurrentTime  ####### column type is changed from time to datetime
   t.datetime   :ExamCompletedTime  ####### column type is changed from time to datetime
   t.column :ExamExtraDurationMinutes,'tinyint(3) unsigned',:null => false,:default=>0 
   t.column :ExamLateStartMinutes,'tinyint(3) unsigned',:null => false,:default=>0 
   t.integer :ExamSecondsLeft,:limit=>11,:null => false,:default=>0 
   t.datetime   :ExamClosingTime  ####### column type is changed from time to datetime
  
   t.string :Comments,:limit=>500
   t.timestamps
    end
  end

  def self.down
    drop_table :demoexamsections
  end
end
