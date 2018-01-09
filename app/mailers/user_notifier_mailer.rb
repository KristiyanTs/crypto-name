class UserNotifierMailer < ApplicationMailer
  default from: 'support@moonhythe.com'

  # How to use
  # UserNotifierMailer.send_authorization_key(current_user, @domain).deliver or deliver_later or deliver_now
  def send_authorization_key(user, domain)
    @user = user
    @domain = domain
    mail( 
      to: @user.email,
      subject: "Moonhythe: Authorization key for #{@domain.name}"
    )
  end
end
