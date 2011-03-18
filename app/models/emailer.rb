class Emailer < ActionMailer::Base

  
  def sendexam_score(recipient, subject, login,studentexamscores,examname,sent_at = Time.now)
    @subject = subject
    @recipients = recipient
    @from = 'nchaitanyaram@gmail.com'
    @sent_on = sent_at
    @body[:login] = login
    @body[:examname] = examname
    @body[:studentexamscores] = studentexamscores
     @body[:url]  = "" 
  
    
  end
  
end
