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

  def full_name
    "#{match_name} - #{question_name}"
  end

  def match_name
    match&.full_name
  end

  def question_name
    question&.question
  end

  def update_prediction_points
    predictions.each do |prediction|
      prediction.update(points: points_for_prediction(prediction))
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

  rails_admin do
    list do
      field :id
      field :match_name
      field :question_name
      field :options
      field :answer
      field :points
      field :created_at
      field :updated_at
    end

    edit do
      field :match_id, :enum do
        enum do
          Match.includes(:team1, :team2).all.collect { |p| [p.full_name, p.id] }
        end
      end

      field :question_id, :enum do
        enum do
          Question.all.collect { |p| [p.question, p.id] }
        end
      end

      field :options
      field :answer
      field :points
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :match_name
      field :question_name
      field :options
      field :answer
      field :points
      field :created_at
      field :updated_at
    end
  end
end
