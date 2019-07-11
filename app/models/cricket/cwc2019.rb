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

    def all_semi_questions
      semi1_questions.merge(semi2_questions)
    end

    def import_bonus_match_questions
      matches = Match.where(match_no: match_no)
      import_stage_match_questions(all_bonus_questions, matches)
    end

    def import_semi_match_questions
      selected_questions = [semi1_questions, semi2_questions]
      questions = Question.by_question(selected_questions[index].keys).order('updated_at asc')
      questions.each do |question|
        match.create_match_question(question, selected_questions[index])
      end
    end

    def import_final_match_questions
      selected_questions = final_questions
      questions = Question.by_question(selected_questions.keys).order('updated_at asc')
      questions.each do |question|
        match.create_match_question(question, selected_questions)
      end
    end

    def import_stage_match_questions(all_questions, matches)
      selected_questions = all_questions
      questions = Question.by_question(selected_questions.keys).order('updated_at')
      matches.each_with_index do |match, index|
        match.create_match_question(questions[index], selected_questions)
      end
    end
  end
end
