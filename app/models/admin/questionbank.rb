
### Author :Upender
## Date and Time :02-10-2008 5:56 pm


class Admin::Questionbank < ActiveRecord::Base
  belongs_to :subject 
  validates_presence_of     :examtype_tags,:correct_answer
 
  def self.save_images(questionbank,subjectCode,appSubCode)
    ## To create upload Files in Rails Root
=begin
    unless File.exists?("#{RAILS_ROOT}/QuestionBank")
      Dir.mkdir "#{RAILS_ROOT}/QuestionBank"
    end
    unless File.exists?("#{RAILS_ROOT}/QuestionBank/#{subjectCode}")
      Dir.mkdir "#{RAILS_ROOT}/QuestionBank/#{subjectCode}"
    end
    unless File.exists?("#{RAILS_ROOT}/QuestionBank/#{subjectCode}/#{appSubCode}")
      Dir.mkdir "#{RAILS_ROOT}/QuestionBank/#{subjectCode}/#{appSubCode}"
    end
=end
    unless File.exists?("#{RAILS_ROOT}/public/QuestionBank")
      Dir.mkdir "#{RAILS_ROOT}/public/QuestionBank"
    end
    unless File.exists?("#{RAILS_ROOT}/public/QuestionBank/#{subjectCode}")
      Dir.mkdir "#{RAILS_ROOT}/public/QuestionBank/#{subjectCode}"
    end
    unless File.exists?("#{RAILS_ROOT}/public/QuestionBank/#{subjectCode}/#{appSubCode}")
      Dir.mkdir "#{RAILS_ROOT}/public/QuestionBank/#{subjectCode}/#{appSubCode}"
    end
    
    qbdirectory = "#{RAILS_ROOT}/public/QuestionBank/#{subjectCode}/#{appSubCode}"
    
    begin
      question_imagepath  = questionbank['question_imagepath'].original_filename
      question_imagepath.replace "Q.gif"
      questionpath = File.join(qbdirectory, question_imagepath)
      File.open(questionpath, "wb") { |f| f.write(questionbank['question_imagepath'].read) }
    rescue NoMethodError
    end
    ### for option1_imagepath
    begin
      option1_imagepath  =  questionbank['option1_imagepath'].original_filename
      option1_imagepath.replace "1.gif"
      option1path = File.join(qbdirectory, option1_imagepath)
      File.open(option1path, "wb") { |f| f.write(questionbank['option1_imagepath'].read) }
    rescue NoMethodError
    end
    ### for option2_imagepath
    begin
      option2_imagepath  =  questionbank['option2_imagepath'].original_filename
      option2_imagepath.replace "2.gif"
      option2path = File.join(qbdirectory, option2_imagepath)
      File.open(option2path, "wb") { |f| f.write(questionbank['option2_imagepath'].read) }
    rescue NoMethodError
    end
    ### for option3_imagepath
    begin
      option3_imagepath  =  questionbank['option3_imagepath'].original_filename
      option3_imagepath.replace "3.gif"
      option3path = File.join(qbdirectory, option3_imagepath)
      File.open(option3path, "wb") { |f| f.write(questionbank['option3_imagepath'].read) }
    rescue NoMethodError
    end
    ### for option4_imagepath
    begin
      option4_imagepath  =  questionbank['option4_imagepath'].original_filename
      option4_imagepath.replace "4.gif"
      option4path = File.join(qbdirectory, option4_imagepath)
      File.open(option4path, "wb") { |f| f.write(questionbank['option4_imagepath'].read) }
    rescue NoMethodError
    end
    ### for option5_imagepath
    begin
      option5_imagepath  =  questionbank['option5_imagepath'].original_filename
      option5_imagepath.replace "5.gif"
      option5path = File.join(qbdirectory, option5_imagepath)
      File.open(option5path, "wb") { |f| f.write(questionbank['option5_imagepath'].read) }
    rescue NoMethodError
    end
    ### for solution_imagepath
    begin
      solution_imagepath  =  questionbank['solution_imagepath'].original_filename
     solution_imagepath.replace "S.gif"
      solutionpath = File.join(qbdirectory, solution_imagepath)
      File.open(solutionpath, "wb") { |f| f.write(questionbank['solution_imagepath'].read) }
    rescue NoMethodError
    end
  end
  
  ## This method is used to delete previous images while updating a question 
  
  def self.delete_previous_files(questionbank)
    if questionbank['question_imagepath']!='' and questionbank['old_question_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public/"+questionbank['old_question_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_question_imagepath'])
      end
    end
    if questionbank['option1_imagepath']!='' and questionbank['old_option1_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public/"+questionbank['old_option1_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_option1_imagepath'])
      end
    end
    if questionbank['option2_imagepath']!='' and questionbank['old_option2_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public/"+questionbank['old_option2_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_option2_imagepath'])
      end
    end
    if questionbank['option3_imagepath']!='' and questionbank['old_option3_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public//"+questionbank['old_option3_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_option3_imagepath'])
      end
    end
    if questionbank['option4_imagepath']!='' and questionbank['old_option4_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public/"+questionbank['old_option4_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_option4_imagepath'])
      end
    end
    if questionbank['option5_imagepath']!='' and questionbank['old_option5_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public/"+questionbank['old_option5_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_option5_imagepath'])
      end
    end
    if questionbank['solution_imagepath']!='' and questionbank['old_solution_imagepath']!=''
      File.delete("#{RAILS_ROOT}/public/"+questionbank['old_solution_imagepath']) 
      if File.exist?("#{RAILS_ROOT}/public/"+questionbank['old_solution_imagepath'])
      end
    end
  end
  
  def self.save_imagepaths_in_db(questionbank,qblist,subjectCode,appendedQuestionCode)
     if questionbank['question_imagepath'] != ""
      que_img=questionbank['question_imagepath'].original_filename
      que_img.replace "Q.gif"
      qblist.question_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" + que_img
    end
    if  questionbank['option1_imagepath'] != ""
      opt1_img =questionbank['option1_imagepath'].original_filename
      opt1_img.replace "1.gif"
      qblist.option1_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" +opt1_img 
    end
    if questionbank['option2_imagepath'] != ""
      opt2_img=questionbank['option2_imagepath'].original_filename
      opt2_img.replace "2.gif"
      qblist.option2_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" + opt2_img
    end
    if questionbank['option3_imagepath'] != ""
      opt3_img=questionbank['option3_imagepath'].original_filename
      opt3_img.replace "3.gif"
      qblist.option3_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" + opt3_img
    end
    if questionbank['option4_imagepath'] != ""
      opt4_img=questionbank['option4_imagepath'].original_filename
      opt4_img.replace "4.gif"
      qblist.option4_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" + opt4_img
    end
    if questionbank['option5_imagepath'] != ""
      opt5_img=questionbank['option5_imagepath'].original_filename
      opt5_img.replace "5.gif"
      qblist.option5_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" + opt5_img
    end
    if questionbank['solution_imagepath'] != ""
      sol_img=questionbank['solution_imagepath'] .original_filename
      sol_img.replace "S.gif"
      qblist.solution_imagepath = "QuestionBank/"+subjectCode+"/"+appendedQuestionCode+"/" +sol_img 
    end
    
  end
  
end
