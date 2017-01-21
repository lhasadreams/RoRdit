# == Schema Information
#
# Table name: links
#
#  id             :integer          not null, primary key
#  title          :string
#  url            :string
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  popularity     :float            default(0.0)
#  hostname       :string
#  comments_count :integer          default(0)
#  points_count   :integer          default(0)
#  username       :string
#

require 'spec_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :hostname }
  it { should validate_presence_of :url }
  it { should validate_uniqueness_of :url }
  it { should have_many(:points) }
  it { should have_many(:comments) }
  it { should belong_to(:user) }
end
