class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.string :title
      t.string :slogan
      t.attachment :logo

      t.timestamps null: false
    end
  end
end
