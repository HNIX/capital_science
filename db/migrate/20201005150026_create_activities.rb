class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.datetime :due_date
      t.string :status
      t.text :comment
      t.string :event
      t.references :owner
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
