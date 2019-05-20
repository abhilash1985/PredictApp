# AddIndicesToTable
class AddIndicesToTable < ActiveRecord::Migration[5.2]
  def change
    add_index :tournaments, :name
    add_index :tournaments, :start_date
    add_index :tournaments, :end_date
    add_index :stadia, :name
    add_index :teams, :name
    add_index :rounds, :name
    add_index :players, :first_name
    add_index :players, :last_name
    add_index :challenges, :name
    add_index :challenges, :tournament_id
    add_index :challenges, :start_time
    add_index :challenges, :end_time
    add_index :questions, :question
    add_index :matches, :match_no
    add_index :matches, :team1_id
    add_index :matches, :team2_id
    add_index :matches, :stadium_id
    add_index :matches, :challenge_id
    add_index :match_questions, :match_id
    add_index :match_questions, :question_id
    add_index :match_questions, :answer
    add_index :match_questions, :points
    add_index :user_challenges, :user_id
    add_index :user_challenges, :challenge_id
    add_index :predictions, :user_challenge_id
    add_index :predictions, :match_question_id
    add_index :predictions, :user_answer
    add_index :predictions, :points
  end
end
