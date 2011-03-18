class CreateAdminSectiontopics < ActiveRecord::Migration
  def self.up
    create_table :sectiontopics do |t|

t.column :SectionTemplate_id,'smallint(5) unsigned',:null => false
t.column :ExamTemplate_id,'smallint(5) unsigned',:null => false
t.column :Subject_id,'tinyint(3) unsigned',:null => false
t.column :Enabled,'tinyint(1) unsigned',:null=>false,:default=>1
t.string :Topic,:limit=>45,:null => false,:default=>' '
t.string :TopicTags,:null => false,:limit=>500,:default=>' '
t.column :MinQuestions,'tinyint(3) unsigned',:null => false,:default=>1
t.column :MaxQuestions,'tinyint(3) unsigned',:null => false
t.column :TotalQuestionsInSection,'tinyint(3) unsigned',:null => false,:default=>0
t.string :Comments ,:limit=>500
t.timestamps


      t.timestamps
    end
  end

  def self.down
    drop_table :sectiontopics
  end
end
