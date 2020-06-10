class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :trip, foreign_key: true
      t.date :date
      t.time :departure_time
      t.string :departure_place
      t.time :arrival_time
      t.string :arrival_place
      t.string :event
      t.integer :price

      t.timestamps
    end
  end
end
