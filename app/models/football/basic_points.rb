# frozen_string_literal: true

# module Football
module Football
  # module BasicPoints
  module BasicPoints
    def default_points
      []
    end

    def team_score_points
      [5, team_score_options]
    end

    def first_goal_points
      [3, first_goal_options]
    end

    def total_goals_points
      [3, total_goals_options]
    end

    def total_shots_points
      [2, total_shots_options]
    end

    def total_shots_by_team_points
      [2, total_shots_by_team_options]
    end

    def total_shots_on_target_points
      [2, total_shots_on_target_options]
    end

    def total_shots_on_target_by_team_points
      [2, total_shots_on_target_by_team_options]
    end

    def no_of_fouls_points
      [2, no_of_fouls_options]
    end

    def no_of_fouls_by_team_points
      [2, no_of_fouls_by_team_options]
    end

    def no_of_cards_points
      [2, no_of_cards_options]
    end

    def possession_points
      [2, possession_options]
    end

    def total_passes_points
      [2, total_passes_options]
    end

    def total_passes_by_team_points
      [2, total_passes_by_team_options]
    end

    def pass_accuracy_points
      [2, pass_accuracy_options]
    end

    def offside_points
      [2, offside_options]
    end

    def corners_points
      [2, corners_options]
    end

    def corners_by_team_points
      [2, corners_by_team_options]
    end

    def types_of_goals_points
      [3, types_of_goals_options]
    end
  end
end
