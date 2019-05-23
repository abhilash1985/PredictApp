# module Cricket for cricket related questions and answers
module Cricket
  # BasicClass
  class BasicClass
    include ::Cricket::BasicQuestions
    include ::Cricket::BasicOptions
    include ::Cricket::BasicPoints

    attr_accessor :tournament, :match, :question

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
  end
end
