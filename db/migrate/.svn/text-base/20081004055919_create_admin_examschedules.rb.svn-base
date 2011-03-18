class CreateAdminExamschedules < ActiveRecord::Migration
  def self.up
    create_table :examschedules do |t|
      t.column :Exam_Id,'smallint(5) unsigned',:null => false
      t.column :ExamDayNumber,'tinyint(3) unsigned',:null => false
      t.string :ExamType, :limit=>15
      t.string :ExamName, :limit=>30
      t.column :ExamDayStatus ,'char(1)',:null=>false,:default=>0
      t.date :ScheduledDate,:null=>false
      t.time :ScheduledTime,:null=>false
      t.column :ExamStarted ,'tinyint(1) unsigned',:null=>false,:default=>0
      t.column :ExamCompleted ,'tinyint(1) unsigned',:null=>false,:default=>0
      t.column :ExamInterrupted ,'tinyint(1) unsigned',:null=>false,:default=>0
      t.date :ExamActualDate
      t.time :ExamActualStartTime
      t.time :ExamActualEndTime
      t.column :NumStudentsScheduled ,'int(10) unsigned',:null=>false,:default=>0
      t.column :NumStudentsAppeared ,'int(10) unsigned',:null=>false,:default=>0
      t.string :Comments,:limit=>500

      t.timestamps
    end
  end

  def self.down
    drop_table :examschedules
  end
end
