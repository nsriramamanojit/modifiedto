class Admin::Examtype < ActiveRecord::Base
  has_many :exams
  has_many :examtemplates
  validates_presence_of     :examtype
  validates_length_of       :examtype,    :within => 1..20
  validates_length_of       :examtype_description, :comments, :maximum => 500
  validates_uniqueness_of   :examtype, :case_sensitive => false
end
