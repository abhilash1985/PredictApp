# module Cricket
module Cricket
  # module BonusQuestions
  module BonusQuestions
    def bonus_questions
      {
        I18n.t('bonus.highest_individual_score') => [20, highest_individual_score_options],
        I18n.t('bonus.first_500_prediction_points') => [20, first_500_prediction_points],
        I18n.t('bonus.leading_wicket_taker') => [20, leading_wicket_taker_options],
        I18n.t('bonus.most_runs_in_tournament') => [20, most_runs_in_tournament_options],
        I18n.t('bonus.win_world_cup') => [30, win_wc_options],
        I18n.t('bonus.player_of_the_tournament') => [20, mos_options],
        I18n.t('bonus.prediction_game_winner') => [30, prediction_game_winner_options],
        I18n.t('bonus.team_with_most_sixes') => [20, team_with_most_six_options],
        I18n.t('bonus.will_india_reach_finals') => [20, will_india_reach_finals_options],
        I18n.t('bonus.leading_wickets') => [20, leading_wickets_options],
        I18n.t('bonus.leading_runs') => [20, leading_runs_options],
        I18n.t('bonus.total_tournament_sixes') => [20, total_tournament_sixes_options]
      }
    end

    def win_wc_options
      %w(AUS IND ENG PAK WI NZL SA BAN Others)
    end

    def team_with_most_six_options
      %w(ENG AUS WI IND NZL PAK SA SL Others)
    end

    def leading_wickets_options
      %w(0-15 16-18 19-20 21-23 24-25 26-28 29-30 30+)
    end

    def leading_runs_options
      %w(0-400 401-450 451-475 476-500 501-525 526-550 551-600 600+)
    end

    def mos_options
      %w(RG.Sharma Shakib M.Amir V.Kohli M.Starc D.Warner K.Williamson B.Stokes Others)
    end

    def most_runs_in_tournament_options
      %w(Shakib D.Warner V.Kohli K.Williamson J.Buttler C.Gayle RG.Sharma J.Roy Others)
    end

    def leading_wicket_taker_options
      %w(M.Amir P.Cummins K.Rabada M.Starc M.Henry O.Thomas J.Archer J.Bumrah Others)
    end

    def will_india_reach_finals_options
      %w(YES NO)
    end

    def highest_individual_score_options
      %w(0-150 151-160 161-175 176-185 186-190 191-200 201-210 210+)
    end

    def first_500_prediction_points
      %w(Vineeth.M Keerthivasan Arun.B Vishnu.B Fazal.S Retheesh.R Others None)
    end

    def prediction_game_winner_options
      %w(Vishnu.B Arun.B Gipson.P Fazal.S Vineeth.M Retheesh.R Keerthivasan Vimesh.K Others)
    end

    def total_tournament_sixes_options
      %w(0-250 251-275 276-300 301-325 326-350 351-375 376-400 400+)
    end
  end
end
