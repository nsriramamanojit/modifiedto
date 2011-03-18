class Admin::Sectiontemplate < ActiveRecord::Base
  set_primary_key "SectionTemplate_Id"
  belongs_to :examtemplate
  belongs_to :subject
   validates_presence_of     :ExamTemplate_Id, :SectionTitle, :SectionDurationMinutes, :SectionNumQuestions, :SectionMinAttempts, :SectionPositiveMarks,:SectionNegativeMarks,:Subject_Id,:SubjectCode
   validates_length_of       :SectionTitle,  :within => 3..45
   validates_numericality_of :SectionDurationMinutes, :SectionNumQuestions, :SectionMinAttempts, :SectionPositiveMarks,:SectionNegativeMarks,:SectionMinimumTagMatch
   #validates_uniqueness_of :SectionTitle, :message => "Title already taken"  # title field need not be unique
   validates_length_of :SectionDescription, :maximum => 500, :message => "Description too big"
   validates_length_of :SectionInstructions, :maximum => 500, :message => "Instructions too big"
   validates_length_of :SectionTags, :maximum => 500, :message => "Tags too big"
   validates_length_of :Comments, :maximum => 500, :message => "Comments too big"
   
end
