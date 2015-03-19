ActiveRecord::Migration.create_table :products do |t|
  t.integer :quantity
  t.decimal :unit_amount
  t.date    :delivery_at
  t.time    :delivery_time

  t.timestamps null: true
end