class Mailer < ActionMailer::Base

  default from: "noreply@caringnexus.com"
  
  EMAIL_ADDR_NOREPLY = "noreply@caringnexus.com"
  
  def invite_friend(from_user, to_user, friend_request)
    @from_user = from_user
    @to_user = to_user
    @friend_request = friend_request
    mail(:to => @to_user.email,
      :subject => I18n.t('email.invite_friend.subject', :name => @from_user.name)) do |format|
      format.text { render :layout => 'email_layout_text' }
      format.html { render :layout => 'email_layout_1' }
    end
  end

end
