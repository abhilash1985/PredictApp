# AddTournamentIdToMatches
class AddTournamentIdToMatches < ActiveRecord::Migration[5.2]
  def change
    add_reference :matches, :tournament, foreign_key: true
  end
end
