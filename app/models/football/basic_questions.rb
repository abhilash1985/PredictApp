# frozen_string_literal: true

# module Football
module Football
  # module BasicQuestions
  module BasicQuestions
    def default_questions
      {
        I18n.t('football.win_the_match') => [8, default_win_options],
      }
    end

    def team_score_questions_for(team_name)
      # Points 5
      {
        I18n.t('football.goals_with_team_name', team_name: team_name) => team_score_points
      }
    end

    def player_goals_questions
      # Points 3
      {
        I18n.t('football.first_goal') => first_goal_points,
        I18n.t('football.first_goal_in_second_half') => first_goal_points,
        I18n.t('football.most_goals_by_player') => first_goal_points,
        I18n.t('football.most_goals_by_player_in_1st_half') => first_goal_points,
        I18n.t('football.most_goals_by_player_in_2nd_half') => first_goal_points,
        I18n.t('football.total_goals_in_the_first_half') => total_goals_points,
        I18n.t('football.total_goals_in_the_second_half') => total_goals_points
      }
    end

    def player_goals_team_questions(team_name)
      {
        I18n.t('football.total_goals_in_the_1st_half_by_team', team_name: team_name) => total_goals_points,
        I18n.t('football.total_goals_in_the_2nd_half_by_team', team_name: team_name) => total_goals_points
      }
    end

    def shots_questions
      {
        I18n.t('football.total_shots') => total_shots_points,
        I18n.t('football.total_shots_on_target') => total_shots_on_target_points
      }
    end

    def shots_team_questions(team_name)
      {
        I18n.t('football.total_shots_by_team', team_name: team_name) => total_shots_by_team_points,
        I18n.t('football.total_shots_on_target_by_team', team_name: team_name) => total_shots_on_target_by_team_points
      }
    end

    def cards_questions
      {
        I18n.t('football.total_no_of_fouls') => no_of_fouls_points,
        I18n.t('football.total_no_of_cards') => no_of_cards_points,
        I18n.t('football.total_no_of_yellow_cards') => no_of_cards_points,
        I18n.t('football.total_no_of_red_cards') => no_of_cards_points
      }
    end

    def cards_team_questions(team_name)
      {
        I18n.t('football.total_no_of_fouls_by_team', team_name: team_name) => no_of_fouls_by_team_points,
        I18n.t('football.total_no_of_cards_by_team', team_name: team_name) => no_of_cards_points,
        I18n.t('football.total_no_of_yellow_cards_by_team', team_name: team_name) => no_of_cards_points,
        I18n.t('football.total_no_of_red_cards_by_team', team_name: team_name) => no_of_cards_points
      }
    end

    def possession_questions(team_name)
      {
        I18n.t('football.total_no_of_possession_by_team', team_name: team_name) => possession_points
      }
    end

    def passes_questions
      {
        I18n.t('football.total_no_of_passes') => total_passes_points
        
      }
    end

    def passes_team_questions(team_name)
      {
        I18n.t('football.total_no_of_passess_by_team', team_name: team_name) => total_passes_by_team_points
      }
    end

    def pass_accuracy_questions(team_name)
      {
        I18n.t('football.pass_accuracy_by_team', team_name: team_name) => pass_accuracy_points
      }
    end

    def offside_questions
      {
        I18n.t('football.total_no_of_offsides') => offside_points
      }
    end

    def offside_team_questions(team_name)
      {
        I18n.t('football.total_no_of_offsides_by_team', team_name: team_name) => offside_points
      }
    end

    def corners_questions
      {
        I18n.t('football.total_no_of_corners') => corners_points
      }
    end

    def corners_team_questions(team_name)
      {
        I18n.t('football.total_no_of_corners_by_team', team_name: team_name) => corners_by_team_points
      }
    end

    def first_goal_questions
      {
        I18n.t('football.first_goal_in_the_match_will_be') => types_of_goals_points
      }
    end
  end
end
