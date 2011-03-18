require 'composite_primary_keys'
class Demoexamsection < ActiveRecord::Base
   set_primary_keys :Student_Id, :Exam_Id,:ExamTemplate_Id,:ExamDayNumber,:SectionTemplate_Id
end
