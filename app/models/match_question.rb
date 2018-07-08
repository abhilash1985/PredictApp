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

    def knockout_questions(team1_name, team2_name, index)
      [Question.fifa_defaults, Question.fifa_team_score(team1_name),
       Question.fifa_team_score(team2_name), Question.match_ends_in,
       Question.fifa_ko_cards_defensive_only.offset(index).limit(1),
       Question.fifa_shots_first_goal_percentage(team1_name, team2_name)
               .offset(rand(10)).limit(1)]
    end

    def quarter_questions(team1_name, team2_name, index)
      [Question.fifa_defaults, Question.fifa_team_score(team1_name),
       Question.fifa_team_score(team2_name), Question.match_ends_in,
       quarter_defensive_questions(index),
       quarter_shots_questions(index, team1_name, team2_name),
       Question.first_goal(team1_name, team2_name).limit(1)]
    end

    def final_questions(team1_name, team2_name, index)
      [Question.fifa_defaults, Question.fifa_team_score(team1_name),
       Question.fifa_team_score(team2_name), Question.match_ends_in,
       Question.golden_ball,
       semi_points_questions(index)[0], semi_points_questions(index)[1],
       semi_defensive_questions(index),
       semi_shots_questions(index, team1_name, team2_name),
       Question.first_goal(team1_name, team2_name).limit(1)]
    end

    def quarter_defensive_questions(index)
      case index
      when 0
        Question.recovered_balls.limit(1)
      when 1
        Question.blocked_balls.limit(1)
      when 2
        Question.tackled_balls.limit(1)
      when 3
        Question.cleared_balls.limit(1)
      end
    end

    def quarter_shots_questions(index, team1_name, team2_name)
      case index
      when 0
        Question.pass_accuracy(team1_name, team1_name).limit(1)
      when 1
        Question.time_of_first_goal(team2_name, team2_name).limit(1)
      when 2
        Question.possession_percentage(team1_name, team1_name).limit(1)
      when 3
        Question.distance_covered(team1_name, team1_name).limit(1)
      end
    end

    def semi_questions(team1_name, team2_name, index)
      [Question.fifa_defaults, Question.fifa_team_score(team1_name),
       Question.fifa_team_score(team2_name), Question.match_ends_in,
       semi_points_questions(index)[0], semi_points_questions(index)[1],
       semi_defensive_questions(index),
       semi_shots_questions(index, team1_name, team1_name),
       Question.first_goal(team2_name, team2_name).limit(1)]
    end

    def semi_points_questions(index)
      case index
      when 0
        [Question.mom.limit(1), Question.woodworks.limit(1)]
      when 1
        [Question.goal_type.limit(1), Question.penalties.limit(1)]
      end
    end

    def semi_defensive_questions(index)
      case index
      when 0
        Question.total_fouls.limit(1)
      when 1
        Question.corners.limit(1)
      when 2
        Question.goal_attempts.limit(1)
      when 3
        Question.recovered_balls.limit(1)
      end
    end

    def semi_shots_questions(index, team1_name, team2_name)
      case index
      when 0
        Question.pass_accuracy(team1_name, team2_name).limit(1)
      when 1
        Question.distance_covered(team1_name, team2_name).limit(1)
      when 2
        Question.possession_percentage(team1_name, team2_name).limit(1)
      when 3
        Question.time_of_first_goal(team1_name, team2_name).limit(1)
      end
    end

    def find_all_questions(team1_name, team2_name, index, play = 'ko')
      if play == 'ko'
        knockout_questions(team1_name, team2_name, index)
      elsif play == 'semi'
        semi_questions(team1_name, team2_name, index)
      else
        quarter_questions(team1_name, team2_name, index)
      end
    end

    def find_matches(play = 'ko')
      if play == 'ko'
        Match.knockouts
      elsif play == 'quarter'
        Match.quarter
      elsif play == 'semi'
        Match.semi
      else
        Match.all
      end
    end

    def add_football_ko_match_questions(play = 'ko')
      find_matches(play).each_with_index do |match, index|
        team1_name = match.team1_name
        team2_name = match.team2_name
        all_questions = find_all_questions(team1_name, team2_name, index, play)
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
        by == 'cricket' ? question.all_options_for(match) : question.all_fifa_ko_options_for(match)
      match_question.points = question.weightage
      match_question.save
    end
  end
end
