# AddColumnsToMatches
class AddColumnsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :round_id, :integer
    add_column :matches, :team1_score, :integer, default: 0
    add_column :matches, :team2_score, :integer, default: 0
    add_column :matches, :won_in, :string, default: 'FT'
  end
end
