# CreateTournamentTypes
class CreateTournamentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_types do |t|
      t.string :name
      t.string :game
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :tournament_types, :name
    add_index :tournament_types, :game
    add_index :tournament_types, :active
  end
end
