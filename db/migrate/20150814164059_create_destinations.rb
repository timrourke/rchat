class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :location
      t.string :hotel
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
