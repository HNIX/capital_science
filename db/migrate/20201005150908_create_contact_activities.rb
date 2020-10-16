class CreateContactActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_activities do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
