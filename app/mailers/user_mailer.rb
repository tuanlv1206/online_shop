class UserMailer < ApplicationMailer
  def new_password(user)
    @user = user
    mail from: 'from@example.com', to: user.email_address, subject: 'Your new password'
  end
end

