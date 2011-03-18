class CreateAdminExams < ActiveRecord::Migration
  def self.up
    create_table :exams, :id => false do |t|
      t.primary_key :Exam_Id
      t.column :ExamTemplate_Id,'smallint(5) unsigned',:null => false
      t.column :ExamType_Id,'tinyint(3) unsigned',:null => false
      t.string :ExamType,:limit=>15,:null => false
      t.string :ExamName,:null => false,:limit=>30
      t.string :ExamDescription,:limit=>240
      t.column :InTheYear,'smallint(4) unsigned',:null => false
      t.column :InTheMonth,'tinyint(4) unsigned',:null => false
      t.date :ExamStartDate,:null=>false
      t.column :ExamStatus,'char(1)',:null => false,:default=>0
      t.column :NumDaysScheduled,'tinyint(3) unsigned',:null => false,:default=>0
      t.column :TotalStudentsScheduled,'int(10) unsigned',:null => false,:default=>0
      t.column :TotalStudentsAppeared,'int(10) unsigned',:null => false,:default=>0
      t.string :comments,:limit=>1000

      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
