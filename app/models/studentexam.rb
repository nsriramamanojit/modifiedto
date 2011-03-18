require 'composite_primary_keys'
class Studentexam < ActiveRecord::Base
  set_primary_keys :Student_Id, :Exam_Id,:ExamTemplate_Id,:ExamDayNumber
  # added by Upender on Wed 02 May 2009
  # Updating a Model caused all its columns to be present in the generated SQL UPDATE statement.
  # This class method is a temporary workaround 
  # since Rails 2.1.2 does not support dirty attributes and partial updates yet.
  def self.update_column(colname, value, studentid, examid, templateid, daynumber)
    return false unless connected?
    unless %w(StudentEligible WaitingForExam LoggedIn ExamStarted ExamCompleted).include? colname
      raise ArgumentError, "Column name #{colname} is not accessible for update."
    end
    connection.update_sql(
        "UPDATE #{self.quoted_table_name} "+
        "SET #{colname} = #{value} "+
        "WHERE Student_Id = #{studentid} AND "+
        "Exam_Id = #{examid} AND "+"ExamTemplate_Id = #{templateid} AND "+
        "ExamDayNumber = #{daynumber};")
  end
  def self.save_user_exam(studentexam,userId,exam,examname,exammode,totalduration,login,examDayNumber)
      studentexam.Student_Id = userId.to_s
          studentexam.Exam_Id = exam.Exam_Id
          studentexam.ExamTemplate_Id = exam.ExamTemplate_Id
          studentexam.ExamDayNumber = examDayNumber
         studentexam.ExamMode = exammode
          studentexam.ExamName = examname
         studentexam.ExamDate = DateTime.now.to_s
          studentexam.ExamTime = Time.now.to_s
          studentexam.HallTicketNumber = "1"
           studentexam.StudentLoginName = login
          studentexam.ExamDurationMinutes = totalduration
          studentexam.QuestionPaperReady = "0"
          studentexam.StudentEligible="0"
          studentexam.StudentInformed="1"
          studentexam.WaitingForExam="1"
          studentexam.ExamStatus="1"
          studentexam.LoggedIn="0"
          studentexam.ExamStarted="0"
          studentexam.ExamTimedOut="0"
          studentexam.ExamCompleted="0"
  end
end
