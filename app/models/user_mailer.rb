class UserMailer < ActionMailer::Base
      def signup_notification(user)
        setup_email(user)
        @subject    += 'Please activate your new account'
      
        @body[:url]  = "#{SITE}/activate/#{user.activation_code}"
      
      end
      
     def activation(user)
    setup_email(user)
    @subject    += 'Your LSSSA account has been activated!'
    @body[:url]  = "#{SITE}/"
  end
      
      def forgot_password(user)
        setup_email(user)
        @subject    += 'You have requested to change your password'
        @body[:url]  = "#{SITE}/reset_password/#{user.password_reset_code}" 
      end

      def reset_password(user)
        setup_email(user)
        @subject    += 'Your password has been reset.'
      end
      
      protected
      
      def setup_email(user)
       @recipients  = "#{user.email}"
      @from        = "nchaitanyaram@gmail.com"
      @subject     = "[LSSSA Account Activation] "
      @sent_on     = Time.now
      @body[:user] = user
      end
    end  
