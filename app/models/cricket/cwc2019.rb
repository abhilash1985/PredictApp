# module Cricket for cricket related questions and answers
module Cricket
  # Cwc2019
  class Cwc2019 < BasicClass
    def all_bonus_questions
      questions = {}
      questions.merge(
        bonus_questions
      )
    end

    def import_bonus_match_questions
      selected_questions = all_bonus_questions
      questions = Question.by_question(selected_questions.keys)
      matches = Match.where(match_no: 19..30)
      matches.each_with_index do |match, index|
        match.create_match_question(questions[index], selected_questions)
      end
    end
  end
end
