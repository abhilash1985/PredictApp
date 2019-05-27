# CreatePlayers
class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.integer :team_id
      t.date :dob

      t.timestamps null: false
    end
  end
end
