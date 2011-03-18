class CreateAdminExamtemplates < ActiveRecord::Migration
  def self.up
     
    create_table :examtemplates, :id => false do |t|
      t.primary_key :ExamTemplate_Id
      t.column :ExamType_Id,'tinyint(3) unsigned',:null => false
      t.string :TemplateName,:null => false,:limit=>45
      t.string :TemplateDescription,:limit=>1000
      t.string :ExamType,:limit=>25
      t.column :TotalDurationMinutes,'tinyint(3) unsigned',:null => false,:default =>180
      t.column :NumberOfSections,'tinyint(3) unsigned',:null => false,:default =>1
      t.string :TemplateHeading,:limit=>100
      t.string :TemplateInstructions,:limit=>1000
      t.string :Comments,:limit=>500

      t.timestamps
    
    end
  end

  def self.down
    drop_table :examtemplates
  end
end
