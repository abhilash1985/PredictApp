class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :match_no
      t.integer :team1_id
      t.integer :team2_id
      t.integer :stadium_id
      t.integer :challenge_id

      t.timestamps null: false
    end
  end
end
