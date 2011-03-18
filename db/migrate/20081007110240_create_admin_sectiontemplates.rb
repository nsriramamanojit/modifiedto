class CreateAdminSectiontemplates < ActiveRecord::Migration
  def self.up
    create_table :sectiontemplates,:id=>false do |t|
      t.primary_key :SectionTemplate_Id
      t.column :ExamTemplate_Id,'smallint(5) unsigned',:null=>false
      t.column :Subject_Id,'tinyint(3) unsigned',:null=>false
      t.column :SubjectCode,'char(1)',:null=>false,:default=>'0'
      t.column :Included, 'tinyint(1) unsigned',:default=>1
      t.column :SectionStatus, 'varchar(50)',:default=>'NULL'
      t.column :SectionComplete, 'tinyint(1) unsigned',:default=>0
      t.string :SectionTitle,:limit=>45,:null=>false,:default=>'Unknown Section'
      t.string :SectionDescription,:limit=>500
      t.string :SectionInstructions,:limit=>500
      t.column :SectionSingleAttemptOnly,'tinyint(1) unsigned',:null=>false,:default=>0
      t.column :SectionDurationMinutes,'tinyint(3) unsigned',:null=>false,:default=>0
      t.column :SectionNumQuestions,'tinyint(3) unsigned',:null=>false,:default=>0
      t.column :SectionMinAttempts,'tinyint(3) unsigned',:null=>false,:default=>1
      t.column :SectionPositiveMarks,'tinyint(3) unsigned',:null=>false,:default=>0
      t.column :SectionNegativeMarks,'tinyint(3) unsigned',:null=>false ,:default=>0
      t.string :SectionTags,:limit=>500,:null=>false,:default=>' '
      t.column :SectionMinimumTagMatch,'tinyint(3) unsigned',:null=>false,:default=>0
      t.column :SuitableQuestionChosenBy, 'enum("LastModified","EarliestModified","Random")',:default=>'LastModified'
      t.column :AfterAllSectionsDone, 'tinyint(1) unsigned',:default=>0
      t.string :Comments,:limit=>500

      t.timestamps
    end
  end

  def self.down
    drop_table :sectiontemplates
  end
end
