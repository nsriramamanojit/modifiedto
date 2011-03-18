class Admin::Sectiontopic < ActiveRecord::Base
  belongs_to :sectiontemplate
  validates_presence_of    :SectionTemplate_id ,:ExamTemplate_id,:Subject_id
  validates_presence_of :Topic
  validates_numericality_of  :MaxQuestions
end
