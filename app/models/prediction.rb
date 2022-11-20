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

  def user_challenge_name
    user_challenge&.full_name
  end

  def match_question_name
    match_question&.full_name
  end

  # rails_admin do
  #   list do
  #     field :id
  #     field :user_challenge_name
  #     field :match_question_name
  #     field :user_answer
  #     field :points
  #     field :created_at
  #     field :updated_at
  #   end

  #   edit do
  #     field :user_challenge_id, :enum do
  #       enum do
  #         UserChallenge.includes(:user, :challenge).all.collect { |p| [p.full_name, p.id] }
  #       end
  #     end

  #     field :match_question_id, :enum do
  #       enum do
  #         MatchQuestion.includes(:question, match: %i[team1 team2]).all
  #                      .collect { |p| [p.full_name, p.id] }
  #       end
  #     end

  #     field :user_answer
  #     field :points
  #     field :created_at
  #     field :updated_at
  #   end

  #   show do
  #     field :id
  #     field :user_challenge_name
  #     field :match_question_name
  #     field :user_answer
  #     field :points
  #     field :created_at
  #     field :updated_at
  #   end
  # end
end
