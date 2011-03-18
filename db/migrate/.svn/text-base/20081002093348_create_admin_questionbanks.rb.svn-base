class CreateAdminQuestionbanks < ActiveRecord::Migration
  def self.up
    create_table :questionbanks do |t|
      t.column :question_code ,'char(5)',:null =>false
      t.column :subject_code ,'char(1)',:null =>false
      t.column :question_number ,'smallint(5) unsigned',:null =>false
      t.column :question_media_type ,'tinyint(3) unsigned',:null =>false
      t.column :subject_id ,'tinyint(3) unsigned',:null => false
      t.string :subject_name,:limit=>45,:null => false
      t.string :examtype_tags ,:limit=>100,:null =>false
      t.string :internal_ref_number,:limit=>25
      t.string :classlevel ,:limit=>20
      t.column :question_format ,'enum("MCSA","MCMA","NCSA","ICMP","ESSAY")',:default=>'MCSA'
      t.string :topic ,:limit=>45
      t.string :sub_topic ,:limit=>45
      t.string :sub_sub_topic ,:limit=>45
      t.string :tags ,:limit=>1000,:null =>false
      t.column :enabled ,'tinyint(1) unsigned' ,:default=>1,:null =>false
      t.string :instructions ,:limit=>1000
      t.column :num_options ,'tinyint(3) unsigned',:default=>4,:null =>false
      t.string :question_text ,:limit=>4000
      t.string :question_imagepath ,:limit=>80
      t.string :option1_text ,:limit=>1000
      t.string :option1_imagepath ,:limit=>80
      t.string :option2_text ,:limit=>1000
      t.string :option2_imagepath ,:limit=>80
      t.string :option3_text ,:limit=>1000
      t.string :option3_imagepath ,:limit=>80
      t.string :option4_text ,:limit=>1000
      t.string :option4_imagepath ,:limit=>80
      t.string :option5_text ,:limit=>1000
      t.string :option5_imagepath ,:limit=>80
      t.string :correct_answer ,:limit=>10,:null =>false
      t.string :solution_text ,:limit=>1000
      t.string :solution_imagepath ,:limit=>80
      t.string :source ,:limit=>100
      t.string :author ,:limit=>100
      t.string :created_by_user ,:limit=>45,:null =>false
      t.string :modified_by_user ,:limit=>45,:null =>false
      t.string :comments ,:limit=>1000
      t.timestamps
    end
  end
  
  def self.down
    drop_table :questionbanks
  end
end
