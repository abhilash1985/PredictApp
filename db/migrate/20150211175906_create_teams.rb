# CreateTeams
class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :rank

      t.timestamps null: false
    end
  end
end
