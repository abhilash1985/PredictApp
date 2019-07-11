# module Cricket
module Cricket
  # module SemiQuestions
  module SemiQuestions
    def semi1_questions
      {
        I18n.t('semi.semi_win') => [20, semi_win_options],
        I18n.t('cricket.mom') => [5, default_options],
        I18n.t('cricket.winning_margin') => [5, semi_winning_margin_options],
        I18n.t('cricket.runs_ind') => [5, semi_team_score_options],
        I18n.t('cricket.no_of_caught') => no_of_out_points,
        I18n.t('semi.best_partnership_in_the_match') => partnership_points,
        I18n.t('semi.no_of_runs_in_40_over') => no_of_runs_in_40_points,
        I18n.t('semi.best_economy_bowler') => economy_bowler_points,
        I18n.t('cricket.first_wicket_in_match') => first_wicket_points
      }
    end

    def semi2_questions
      {
        I18n.t('semi.semi_win') => [20, semi_win_options],
        I18n.t('cricket.mom') => [5, default_options],
        I18n.t('cricket.winning_margin') => [5, semi_winning_margin_options],
        I18n.t('cricket.runs_eng') => [5, semi_team_score_options],
        I18n.t('cricket.no_of_lbw') => no_of_out_points,
        I18n.t('semi.no_of_wickets_by_starc_and_behren') => no_of_wickets_by_starc_and_behren_points,
        I18n.t('semi.no_of_runs_in_25_over') => no_of_runs_in_25_points,
        I18n.t('semi.best_sr_batsman') => best_sr_points,
        I18n.t('cricket.individual_score') => individual_score_points
      }
    end

    def semi_win_options
      return [] if match.blank?
      [match.team1_name, match.team2_name]
    end

    def semi_winning_margin_options
      ['1-25Runs', '26-50Runs', '51-75Runs', '75+Runs', '1-3Wickets', '4-5Wickets',
       '6-7Wickets', '8-10Wickets']
    end

    def semi_team_score_options
      %w(0-210 211-235 236-260 261-280 281-300 301-315 316-335 335+)
    end

    def final_questions
      {
        I18n.t('bonus.win_world_cup') => [30, semi_win_options],
        I18n.t('cricket.mom') => [10, default_options],
        I18n.t('cricket.winning_margin') => [5, final_winning_margin_options],
        I18n.t('cricket.runs_nzl') => [3, final_team_score_options],
        I18n.t('final.overs_46_50_batting1') => overs_46_50_batting1_points,
        I18n.t('final.most_runs_scored_in_over') => most_runs_scored_in_over_points,
        I18n.t('final.no_of_boundaries_scored_in_final') => no_of_boundaries_scored_in_final_points,
        I18n.t('final.bowler_with_most_extras') => bowler_with_most_extras_points,
        I18n.t('final.longest_six') => longest_six_points,
        I18n.t('final.best_sr_batsman_in_final') => best_sr_batsman_in_final_points
      }
    end

    def final_winning_margin_options
      ['1-20Runs', '21-40Runs', '41-60Runs', '61-80Runs', '80+Runs', '1-3Wickets', '4-5Wickets',
       '6-7Wickets', '8-10Wickets']
    end

    def final_team_score_options
      %w(0-180 181-200 201-225 226-250 251-275 276-300 301-320 321-335 335+)
    end
  end
end
