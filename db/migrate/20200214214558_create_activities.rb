class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.string :contact_name
      t.string :contact_phone
      t.string :website
      t.text :notes
      t.integer :dependent_id

      t.timestamps null: false
    end
  end
end
