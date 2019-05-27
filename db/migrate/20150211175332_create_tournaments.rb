# CreateTournaments
class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :location
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
