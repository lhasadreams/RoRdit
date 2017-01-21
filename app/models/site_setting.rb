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

class SiteSetting < ActiveRecord::Base
  has_attached_file :logo, default_url: ->(attachment){ ActionController::Base.helpers.asset_path("logo.png") }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  validates_presence_of :title
  validates :slogan, presence: true, length: { maximum: 70 }

  after_save :clear_site_settings

  protected
  def clear_site_settings
    Rails.cache.delete("site_settings")
  end
end
