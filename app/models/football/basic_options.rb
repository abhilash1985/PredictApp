# frozen_string_literal: true

# module Football
module Football
  # module BasicOptions
  module BasicOptions
    def default_options
      []
    end

    def default_win_options
      return [] if match.blank?

      [match.team1_name, match.team2_name, 'Draw', 'No Result']
    end

    def team_score_options
      %w(0 1 2 3 4 4+)
    end

    def first_goal_options
      ['No Goals', 'Others']
    end

    def total_goals_options
      %w(0 1 2 3 4 4+)
    end

    def total_shots_options
      %w(0-5 6-10 11-15 16-20 21-25 25+)
    end

    def total_shots_by_team_options
      %w(0-3 4-6 7-10 11-12 13-15 15+)
    end

    def total_shots_on_target_options
      %w(0-1 2-3 4-5 6-7 8-10 10+)
    end

    def total_shots_on_target_by_team_options
      %w(0-1 2 3 4 5+)
    end

    def no_of_fouls_options
      %w(0-5 6-10 11-15 16-20 21-25 25+)
    end

    def no_of_fouls_by_team_options
      %w(0-3 4-6 7-10 11-12 13-15 15+)
    end

    def no_of_cards_options
      %w(0 1 2 3 4 4+)
    end

    def possession_options
      %w(0-20% 21-35% 36-50% 51-60% 61-75% 75%+)
    end

    def total_passes_options
      %w(0-400 401-600 601-700 701-850 851-1000 1000+)
    end

    def total_passes_by_team_options
      %w(0-150 151-250 251-400 401-500 501-600 600+)
    end

    def pass_accuracy_options
      %w(0-50% 51-65% 66-75% 76-85% 86-95% 95%+)
    end

    def offside_options
      %w(0 1 2 3 4 4+)
    end

    def corners_options
      %w(0-1 2-3 4-5 6-7 8-10 10+)
    end

    def corners_by_team_options
      %w(0-1 2 3 4 5+)
    end

    def types_of_goals_options
      ['Free Kick', 'Header', 'Penalty', 'Tap-In', 'Others', 'No Goals']
    end
  end
end
