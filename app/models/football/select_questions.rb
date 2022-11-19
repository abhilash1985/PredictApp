# frozen_string_literal: true

# module Football
module Football
  # module SelectQuestions
  module SelectQuestions
    def sample_questions
      questions = {}
      questions.merge(
        default_questions, 
        select_team_score_questions,
        select_random(select_player_goals_questions),
        select_random(select_shots_questions),
        select_random(select_others_questions)
      )
    end

    def select_team_score_questions
      @team1_name = match.team1_name
      @team2_name = match.team2_name
      team_score_questions_for(@team1_name).merge(
        team_score_questions_for(@team2_name)
      )
    end

    def select_player_goals_questions
      player_goals_questions.merge(
        player_goals_team_questions(@team1_name),
        player_goals_team_questions(@team2_name),
        first_goal_questions
      )
    end

    def select_shots_questions
      shots_questions.merge(
        shots_team_questions(@team1_name),
        shots_team_questions(@team2_name),
        passes_questions,
        passes_team_questions(@team1_name),
        passes_team_questions(@team2_name),
        possession_questions(@team1_name),
        possession_questions(@team2_name),
        pass_accuracy_questions(@team1_name),
        pass_accuracy_questions(@team2_name)
      )
    end

    def select_others_questions
      cards_questions.merge(
        cards_team_questions(@team1_name),
        cards_team_questions(@team2_name),
        offside_questions,
        offside_team_questions(@team1_name),
        offside_team_questions(@team2_name),
        corners_questions,
        corners_team_questions(@team1_name),
        corners_team_questions(@team2_name)
      )
    end

    def select_random(questions)
      [questions.to_a.shuffle[1]].to_h
    rescue StandardError
      questions.to_a.shuffle.sample(1).to_h
    end
  end
end
