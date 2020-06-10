class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.date :started_at
      t.date :finished_at
      t.string :image_name

      t.timestamps
    end
  end
end
