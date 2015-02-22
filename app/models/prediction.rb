class Prediction < ActiveRecord::Base
  # Associations
  belongs_to :user_challenges
  belongs_to :match_questions
  # Scopes
  scope :by_match_question, ->(match_question_id) { where(match_question_id: match_question_id) }

  def style_class
    points == 0 ? 'btn-danger' : 'btn-success'
  end
end
