class CreateUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :usages do |t|
      t.bigint :user_id
      t.integer :kwh
      t.date :start_date
      t.date :end_date
      t.string :meter_id

      t.timestamps
    end
  end
end
