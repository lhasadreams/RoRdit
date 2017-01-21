class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :points_count, default: 0
      t.string :username
      t.references :user, index: true, foreign_key: true
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
