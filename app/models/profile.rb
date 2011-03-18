class Profile < ActiveRecord::Base
  validates_presence_of :name,:mobile,:student_id,:email
  validates_length_of :name, :within => 5..50
validates_numericality_of :mobile
validates_numericality_of :landline

end
