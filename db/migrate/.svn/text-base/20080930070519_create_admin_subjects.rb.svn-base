class CreateAdminSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.column :subject_code ,'char(1)',:null => false
      t.string :subject_name ,:limit=>45,:null => false
      t.string :subject_description ,:limit=>500
      t.column :last_question_number, 'smallint(5) unsigned',:null => false,:default=>0
      t.string :comments ,:limit=>500
       t.timestamps
    end
  end

  def self.down
    drop_table :subjects
  end
end
