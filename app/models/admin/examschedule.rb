require 'composite_primary_keys'
class Admin::Examschedule < ActiveRecord::Base
  set_primary_keys :Exam_Id,:ExamDayNumber
  belongs_to :exam
  
end
