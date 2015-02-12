class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :tournament_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
