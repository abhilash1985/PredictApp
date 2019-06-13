# Prediction
class Prediction < ApplicationRecord
  # Associations
  belongs_to :user_challenge
  belongs_to :match_question
  # Scopes
  scope :by_match_question, ->(match_question_id) { where(match_question_id: match_question_id) }
  # Validations
  validates :user_challenge_id, uniqueness: { scope: :match_question_id, message: 'Only one prediction allowed' }

  def style_class
    if points.nil?
      'btn-primary'
    elsif points == 0
      'btn-danger'
    else
      'btn-success'
    end
  end
end
