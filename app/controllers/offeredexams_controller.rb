# **** Author: Upender ***** 
# ----- Date Time :02-05-2009 11.00 AM ---
# ------- Copyrighs reserved for Indigenius Sol ---
class OfferedexamsController < ApplicationController
  before_filter :login_required
  layout 'users'
  def index
    @free_services=Admin::Service.find(:all,:conditions=>['payment_required = ? and service_enabled = ?',true,true]) 
    end
end
