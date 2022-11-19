# frozen_string_literal: true

# module Football for Football related questions and answers
module Football
  # BasicClass
  class BasicClass
    include ::Football::BasicQuestions
    # include ::Football::BonusQuestions
    # include ::Football::SemiQuestions
    include ::Football::SelectQuestions
    include ::Football::BasicOptions
    include ::Football::BasicPoints

    attr_accessor :tournament, :match, :question, :date, :matches, :index,
                  :challenge

    def initialize(args = {})
      args.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def all_questions
      questions = {}
      questions.merge(
        default_questions, player_goals_questions, shots_questions, cards_questions,
        passes_questions, offside_questions, corners_questions, first_goal_questions,
        teams_questions
      )
    end

    def teams_questions
      Team.pluck(:name).each_with_object({}) do |team_name, hash|
        hash.merge!(
          team_score_questions_for(team_name),
          player_goals_team_questions(team_name),
          shots_team_questions(team_name),
          cards_team_questions(team_name),
          possession_questions(team_name),
          passes_team_questions(team_name),
          pass_accuracy_questions(team_name),
          offside_team_questions(team_name),
          corners_team_questions(team_name)
        )
      end
    end

    def basic_options
      options = all_questions[question.question][1]
      { v: options }
    end

    def import_match_questions
      selected_questions = sample_questions
      questions = Question.by_question(selected_questions.keys).order(:id)
      questions.each do |question|
        match.create_match_question(question, selected_questions)
      end
    end

    def import_challenges
      challenge = tournament.challenges.by_name("#{@challenge} - Match#{index + 1}")
                            .first_or_initialize
      dates = challenge_dates
      challenge.start_time = dates[0]
      challenge.end_time = dates[1]
      return unless challenge.save

      update_matches(challenge, matches)
    end

    private

    def challenge_dates
      start_time = date.to_time
      end_time = matches.first.match_date
      [start_time, end_time]
    end

    def update_matches(challenge, matches)
      challenge.matches.update_all(challenge_id: nil)
      matches.each { |m| m.update(challenge_id: challenge.id) }
      p "#{challenge.id}: #{challenge.name}, ST: #{challenge.start_time},
         ET: #{challenge.end_time}, Matches: #{matches.map(&:id).join}"
    end
  end
end
