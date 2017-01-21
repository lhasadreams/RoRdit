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

require 'spec_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_secure_password }
end
