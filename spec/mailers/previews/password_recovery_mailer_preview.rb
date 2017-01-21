class PasswordRecoveryMailerPreview < ActionMailer::Preview
  user = User.last
  PasswordRecoveryMailer.password_recovery(user)
end
