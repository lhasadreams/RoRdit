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

require 'spec_helper'

RSpec.describe SmtpSetting, type: :model do
  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:port) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:authentication) }
  it { should validate_presence_of(:domain) }
  it { should validate_presence_of(:default_from) }
end
