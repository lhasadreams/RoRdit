# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  link_id    :integer
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Point, type: :model do
  it { should validate_presence_of :user_id }
  it { should belong_to(:user) }
  it { should belong_to(:link) }
  it { should belong_to(:comment) }
end
