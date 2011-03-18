class Admin::Servicetype < ActiveRecord::Base
  set_primary_key "servicetype_id"
  validates_presence_of :service_type
  validates_uniqueness_of :service_type ,:case_sensitive => false
end
