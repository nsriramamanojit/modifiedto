class Admin::Service < ActiveRecord::Base
  
  set_primary_key "service_id"
  has_many :exams 
   validates_presence_of :service_name, :servicetype_id, :service_mode
   validates_numericality_of :servicechargeamount
   validates_uniqueness_of :service_name
end
