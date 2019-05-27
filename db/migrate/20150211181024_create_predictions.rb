# CreatePredictions
class CreatePredictions < ActiveRecord::Migration[5.2]
  def change
    create_table :predictions do |t|
      t.integer :user_challenge_id
      t.integer :match_question_id
      t.string :user_answer
      t.integer :points

      t.timestamps null: false
    end
  end
end
