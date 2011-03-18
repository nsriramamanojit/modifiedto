class Admin::Exam < ActiveRecord::Base
  set_primary_key "Exam_Id"
  has_one :examtemplate
  has_many :examschedules
  belongs_to :examtype
  belongs_to :service
  
   validates_presence_of     :ExamTemplate_Id, :ExamType_Id, :ExamName, :InTheYear, :InTheMonth, :ExamStatus, :NumDaysScheduled
   validates_length_of       :ExamName,:InTheMonth,  :within => 3..255
   validates_length_of       :InTheYear,  :minimum => 4
   validates_uniqueness_of   :ExamName,:case_sensitive => false
   validates_numericality_of :InTheYear,:NumDaysScheduled
 
  
end
