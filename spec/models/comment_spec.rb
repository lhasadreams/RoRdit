# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment      :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  link_id      :integer
#  points_count :integer          default(0)
#  username     :string
#

require 'spec_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:link_id) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:user) }
  it { should belong_to(:link) }
end
