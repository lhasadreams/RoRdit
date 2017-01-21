class PasswordRecoveryMailer < ApplicationMailer
  def password_recovery(user)
    smtp_settings = Rails.cache.fetch("smtp_settings") { SmtpSetting.last }

    delivery_options = { user_name: smtp_settings[:user_name],
                         password: smtp_settings[:password],
                         domain: smtp_settings[:domain],
                         address: smtp_settings[:address],
                         port: smtp_settings[:port],
                         authentication: smtp_settings[:authentication]}
    @user = user
    mail(to: @user.email, subject: "Reset your password", delivery_method_options: delivery_options,
         from: smtp_settings[:default_from])
  end
end
