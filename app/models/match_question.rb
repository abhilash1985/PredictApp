class MatchQuestion < ActiveRecord::Base
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

  def question_names_with_points(index)
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
    answer == prediction.user_answer ? points : 0
  end

  def exact_answer
    return user_answer unless options[:v].blank?
    player = Player.find_by_id(user_answer)
    player.try(:first_name)
  end

  class << self
    def add_match_questions
      Match.order(:id).each do |match|
        all_questions = [Question.defaults,
                         Question.others.offset(rand(7)).limit(3),
                         Question.outs.offset(rand(3)).limit(1),
                         Question.power_plays.offset(rand(6)).limit(1),
                         Question.team_score(match.team1_short_name.upcase),
                         Question.team_score(match.team2_short_name.upcase)]
        all_questions.each do |questions|
          questions.each do |question|
            create_match_question_for(match, question)
          end
        end
      end
    end

    def add_football_match_questions
      Match.order(:id).each do |match|
        team1_name = match.team1_name
        team2_name = match.team2_name
        all_questions = [Question.fifa_defaults,
                         Question.fifa_team_score(team1_name),
                         Question.fifa_team_score(team2_name),
                         Question.fifa_cards_percentage(team1_name, team2_name).offset(rand(7)).limit(1),
                         Question.fifa_shots_first_goal(team1_name, team2_name).offset(rand(6)).limit(1)]
        all_questions.each do |questions|
          questions.each do |question|
            create_match_question_for(match, question, 'fifa')
          end
        end
      end
    end

    def create_match_question_for(match, question, by = 'cricket')
      match_question = by_match(match).by_question(question).first_or_initialize
      match_question.options =
        by == 'cricket' ? question.all_options_for(match) : question.all_fifa_options_for(match)
      match_question.points = question.weightage
      match_question.save
    end
  end
end
