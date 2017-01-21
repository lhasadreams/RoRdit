# == Schema Information
#
# Table name: site_settings
#
#  id                :integer          not null, primary key
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  slogan            :string
#

require 'spec_helper'

RSpec.describe SiteSetting, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slogan) }
  it { should validate_length_of(:slogan).is_at_most(70) }
end
