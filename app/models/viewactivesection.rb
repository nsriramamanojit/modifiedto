
require 'composite_primary_keys'
class Viewactivesection < ActiveRecord::Base
  set_primary_keys :Student_Id, :Exam_Id,:ExamTemplate_Id,:ExamDayNumber,:SectionTemplate_Id
 
  # added by Nagesh S G on Wed 17 Dec 2008
  
  # Updating a view caused all its columns to be present in the generated SQL UPDATE statement.
  # This causes an SQL error for views in which one or more columns are calculated expressions or
  # stored routine calls [ such as sp_viewsectionpaper(SectionPaper) ] which cannot be updated.

  # This class method is a temporary workaround 
  # since Rails 2.1.2 does not support dirty attributes and partial updates yet.
  
  def self.update_column(colname, value, studentid, examid, templateid, daynumber, sectiontemplateid)
    
    return false unless connected?
    
    unless %w(LoggedIn ExamStarted ExamCompleted CurrentQuestionCode CurrentQuestionAnswer CurrentMarkReviewFlags).include? colname
       raise ArgumentError, "Column name #{colname} is not accessible for update."
    end

    if colname == 'CurrentQuestionCode' or colname == 'CurrentQuestionAnswer' or colname == 'CurrentMarkReviewFlags' then
      value = "'" + value.to_s + "'"
    end

    connection.update_sql(
        "UPDATE #{self.quoted_table_name} " +
        "SET #{colname} = #{value} " + 
        "WHERE Student_Id   = #{studentid} AND " +
              "Exam_Id      = #{examid} AND " +
              "ExamTemplate_Id  = #{templateid} AND " +
              "ExamDayNumber    = #{daynumber}  AND " +
              "SectionTemplate_Id = #{sectiontemplateid} ",
        "#{self.name} Update"
      )
    
  end
 
  
end
