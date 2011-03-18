class Admin::Subject < ActiveRecord::Base
   has_many :questionbanks
   has_many :sectiontemplates
  validates_presence_of     :subject_code, :subject_name
  validates_length_of       :subject_name, :maximum => 45
  validates_length_of       :subject_description,:comments, :maximum => 500
  validates_uniqueness_of   :subject_name,:subject_code ,:case_sensitive => false
end
