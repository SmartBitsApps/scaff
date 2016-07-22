class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :description
      t.string :start_date
      t.string :end_date
      t.integer :manager
      t.boolean :visible

      t.timestamps null: false
    end
  end
end
