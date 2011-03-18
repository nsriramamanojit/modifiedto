class Admin::Examtemplate < ActiveRecord::Base
  set_primary_key "ExamTemplate_Id"
  has_one :exam
  belongs_to :examtype
  has_many :sectiontemplates
  
  validates_presence_of  :TemplateName, :TotalDurationMinutes, :NumberOfSections
  validates_numericality_of :TotalDurationMinutes, :NumberOfSections
  validates_length_of    :TemplateInstructions, :TemplateDescription, :maximum => 1000
  validates_length_of    :Comments, :maximum => 500
  validates_length_of    :TemplateName, :within => 1..45
end
