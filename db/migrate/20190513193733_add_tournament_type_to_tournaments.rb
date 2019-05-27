# AddTournamentTypeToTournaments
class AddTournamentTypeToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_reference :tournaments, :tournament_type, foreign_key: true, index: true
  end
end
