# module Cricket
module Cricket
  # module BonusQuestions
  module IplBonusQuestions
    def bonus_questions
      {
        I18n.t('ipl_bonus.win_ipl') => [20, win_ipl_options],
        I18n.t('ipl_bonus.purple_cap') => [15, leading_wicket_taker_options],
        I18n.t('ipl_bonus.orange_cap') => [15, most_runs_in_tournament_options],
        I18n.t('ipl_bonus.most_valuable_player') => [15, mvp_options],

        I18n.t('ipl_bonus.player_with_most_sixes') => [10, player_with_most_six_options],
        I18n.t('ipl_bonus.player_with_most_catches') => [10, player_with_most_catch_options],
        I18n.t('ipl_bonus.strike_rate_in_innings') => [10, strike_rate_in_innings_options],

        I18n.t('ipl_bonus.team_with_most_sixes') => [10, team_with_most_six_options],
        I18n.t('ipl_bonus.leading_wickets') => [10, leading_wickets_options],
        I18n.t('ipl_bonus.leading_runs') => [10, leading_runs_options]
      }
    end

    def win_ipl_options
      %w[MI DC RCB KKR SRH CSK RR KXIP]
    end

    def team_with_most_six_options
      %w[MI DC RCB KKR SRH CSK RR KXIP]
    end

    def leading_wickets_options
      %w(0-15 16-18 19-20 21-23 24-25 26-28 29-30 30+)
    end

    def leading_runs_options
      %w(0-400 401-450 451-475 476-500 501-525 526-550 551-600 600+)
    end

    def mvp_options
      %w[R.Tewatia K.Rahul J.Bumrah K.Rabada S.Dhawan J.Archer A.Devilliers Others]
    end

    def most_runs_in_tournament_options
      %w[K.Rahul M.Agarwal V.Kohli F.DuPlessis S.Dhawan D.Warner Q.DeKock Others]
    end

    def leading_wicket_taker_options
      %w[R.Khan M.Shami K.Rabada Y.Chahal A.Nortje J.Archer J.Bumrah Others]
    end

    def player_with_most_six_options
      %w[A.Devilliers N.Pooran S.Samson K.Pollard R.Sharma M.Agarwal E.Morgan Others]
    end

    def player_with_most_catch_options
      %w[F.DuPlessis S.Hetmyer R.Tewatia K.Pollard D.Padikkal S.Gill M.Agarwal Others]
    end

    def strike_rate_in_innings
      %w[N.Pooran C.Morris H.Pandya K.Pollard J.Archer A.Devilliers C.Gayle Others]
    end
  end
end
