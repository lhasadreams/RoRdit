RSpec.describe PasswordRecoveryMailer, :type => :mailer do
  describe '#password_recovery' do
    before do
      SmtpSetting.create(user_name: "steve", password: "jobs", domain: "apple.com", address: "smtp.apple.com", port: 587,
                         authentication: "login", default_from: "Steve Jobs <steve@apple.com>")
    end

    let(:user) { create(:user) }
    let(:mail) { user.send_password_reset_token }

    it 'checks mail data' do
      expect(mail.subject).to eql("Reset your password")
      expect(mail.to).to eql([user.email])
      expect(mail.from).to eql(['steve@apple.com'])
      expect(mail.body).to match("#{user.reset_password_token}")
    end
  end
end
