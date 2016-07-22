class CreateEventAddresses < ActiveRecord::Migration
  def change
    create_table :event_addresses do |t|
      t.references :event, index: true, foreign_key: true
      t.string :street
      t.string :street_number
      t.string :city

      t.timestamps null: false
    end
  end
end
