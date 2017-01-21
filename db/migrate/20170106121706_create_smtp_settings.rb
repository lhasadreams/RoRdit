class CreateSmtpSettings < ActiveRecord::Migration
  def change
    create_table :smtp_settings do |t|
      t.string :user_name
      t.string :password
      t.string :domain
      t.string :address
      t.integer :port
      t.string :authentication
      t.string :default_from

      t.timestamps null: false
    end
  end
end
