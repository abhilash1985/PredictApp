# module Cricket for cricket related questions and answers
module Cricket
  # BasicClass
  class BasicClass
    include ::Cricket::BasicQuestions
    include ::Cricket::BonusQuestions
    include ::Cricket::SemiQuestions
    include ::Cricket::SelectQuestions
    include ::Cricket::BasicOptions
    include ::Cricket::BasicPoints

    attr_accessor :tournament, :match, :question, :date, :matches, :index

    def initialize(args = {})
      args.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def all_questions
      questions = {}
      questions.merge(
        default_questions, default_winning_margin_questions,
        team_score_questions, no_of_out_questions,
        no_of_extras_questions, powerplay_questions, bowler_batsman_questions,
        no_of_sixes_fours_questions, wickets_questions, others_questions
      )
    end

    def basic_options
      options = all_questions[question.question][1]
      { v: options }
    end

    def import_match_questions
      selected_questions = sample_questions
      questions = Question.by_question(selected_questions.keys)
      questions.each do |question|
        match.create_match_question(question, selected_questions)
      end
    end

    def import_challenges
      challenge = tournament.challenges.by_name("CWC2019 - Day#{index + 1}").first_or_initialize
      dates = challenge_dates
      challenge.start_time = dates[0]
      challenge.end_time = dates[1]
      if challenge.save
        challenge.matches.update_all(challenge_id: nil)
        matches.each { |m| m.update_attributes(challenge_id: challenge.id) }
        p "#{challenge.id}: #{challenge.name}, ST: #{challenge.start_time}, ET: #{challenge.end_time}, " \
           "Matches: #{matches.map(&:id).join}"
      end
    end

    private

    def challenge_dates
      start_time = date.to_time
      end_time = matches.first.match_date - 35.minutes
      [start_time, end_time]
    end
  end
end
