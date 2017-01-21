# == Schema Information
#
# Table name: smtp_settings
#
#  id             :integer          not null, primary key
#  user_name      :string
#  password       :string
#  domain         :string
#  address        :string
#  port           :integer
#  authentication :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  default_from   :string
#

class SmtpSetting < ActiveRecord::Base
  validates_presence_of :user_name
  validates_presence_of :password
  validates_presence_of :port
  validates_presence_of :address
  validates_presence_of :authentication
  validates_presence_of :domain
  validates_presence_of :default_from

  after_save :clear_smtp_settings

  protected
  def clear_smtp_settings
    Rails.cache.delete("smtp_settings")
  end
end
