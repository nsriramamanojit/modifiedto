class PaymentController < ApplicationController
   include AuthenticatedSystem
  layout 'home'
  before_filter :login_required
def success
  @service_payment=Servicepayment.new
  @service_payment.student_id=current_user.id
  @service_payment.email=current_user.email
  @service_payment.service_id=1
  @service_payment.payment_sent=1
  if @service_payment.save
    flash[:notice]="Payment Received successfully"
    ## Send Confirmation Mail to User 
     redirect_to :controller=>'home',:action=>'exams'
  else
    flash[:error]="Caused By Internal ERROR"
    puts "########## ERROR : From paypal is success but student not saved in service payments table "
  end
end
def fail
  redirect_to :controller=>'home',:action=>'userhome'
end
end
