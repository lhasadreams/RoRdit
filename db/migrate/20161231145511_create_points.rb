class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.references :user, index: true, foreign_key: true
      t.references :link, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
