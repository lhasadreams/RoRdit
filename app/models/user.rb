# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string
#  password_digest      :string
#  email                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  reset_password_token :string
#

class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { in: 6..25 }, on: :create

  def send_password_reset_token
    self.update(reset_password_token: rand(100_000...999_999))
    PasswordRecoveryMailer.password_recovery(self).deliver_now
  end
end
