class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :brigade, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
