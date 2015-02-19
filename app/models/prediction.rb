class Prediction < ActiveRecord::Base
  belongs_to :user_challenges
  belongs_to :match_questions

  scope :by_match_question, ->(match_question_id) { where(match_question_id: match_question_id) }
end
