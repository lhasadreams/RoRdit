namespace :settings do
  desc "Create site setting and admin user"
  task create: :environment do
    SiteSetting.create(title: "Habdit", slogan: "Reddit in Ruby on Rails in Habitat")
    AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  end

  task update: :environment do
    title = ENV["SITE_TITLE"] || "Habdit"
    slogan = ENV["SITE_SLOGAN"] || "Reddit in Ruby on Rails in Habitat"

    site_setting = SiteSetting.first
    site_setting.title = title
    site_setting.slogan = slogan
    site_setting.save
  end
end
