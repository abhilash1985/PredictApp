# MatchQuestion
class MatchQuestion < ApplicationRecord
  include EnglandTourMatchQuestion
  include FifaQuestions
  # Associations
  has_many :predictions
  belongs_to :question # added by Ashik
  belongs_to :match
  # Scopes
  scope :by_match, ->(match) { where(match_id: match.id) }
  scope :by_question, ->(question) { where(question_id: question.id) }
  scope :ids_in, ->(ids) { where(id: ids) }

  # callbacks
  after_save :update_prediction_points
  serialize :options, Hash

  alias_attribute :user_answer, :answer

  def question_id_with_points(index)
    "Q#{index + 1} (#{points}pts)"
  end

  def question_names_with_points(_index)
    "#{question_name} (#{points}pts)"
  end

  def question_name_with_points(index)
    "Q#{index + 1}: #{question_name} (#{points}pts)"
  end

  def question_name
    question.try(:question)
  end

  def update_prediction_points
    predictions.each do |prediction|
      prediction.update_attributes(points: points_for_prediction(prediction))
    end
  end

  def points_for_prediction(prediction)
    result = answer == prediction.user_answer ? points : 0
    prediction.user_challenge.point_booster ? result * 2 : result
  end

  def exact_answer
    return user_answer unless options[:v].blank?
    player = Player.find_by_id(user_answer)
    player.try(:first_name)
  end
end
