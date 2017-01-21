namespace :settings do
  desc "Create site setting and admin user"
  task create: :environment do
    SiteSetting.create(title: "RoRdit", slogan: "Slogan is here.")
    AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  end
end