# module Cricket
module Cricket
  # module SelectQuestions
  module SelectQuestions
    def sample_questions
      questions = {}
      questions.merge(
        default_questions, select_random(select_team_score_questions),
        default_winning_margin_questions,
        select_random(select_out_extras_questions),
        select_random(powerplay_questions),
        select_random(select_bowler_batsman_sixes_fours_questions),
        select_random(select_others_questions)
      )
    end

    def select_team_score_questions
      team1_name = match.team1_name
      team2_name = match.team2_name
      team_1st_2nd_score_questions.merge(
        team_score_questions_for(team1_name),
        team_score_questions_for(team2_name)
      )
    end

    def select_out_extras_questions
      no_of_out_questions.merge(no_of_extras_questions)
    end

    def select_bowler_batsman_sixes_fours_questions
      bowler_batsman_questions.merge(no_of_sixes_fours_questions)
    end

    def select_others_questions
      wickets_questions.merge(others_questions)
    end

    def select_random(questions)
      [questions.to_a.shuffle[1]].to_h
    rescue
      questions.to_a.shuffle.sample(1).to_h
    end
  end
end
