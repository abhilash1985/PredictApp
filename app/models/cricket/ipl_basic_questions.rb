# module Cricket
module Cricket
  # module IplBasicQuestions
  module IplBasicQuestions
    def all_team_score_questions
      # Points 2
      {
        I18n.t('ipl.runs_mi') => team_score_points,
        I18n.t('ipl.runs_csk') => team_score_points,
        I18n.t('ipl.runs_dc') => team_score_points,
        I18n.t('ipl.runs_srh') => team_score_points,
        I18n.t('ipl.runs_kkr') => team_score_points,
        I18n.t('ipl.runs_rcb') => team_score_points,
        I18n.t('ipl.runs_kxip') => team_score_points,
        I18n.t('ipl.runs_rr') => team_score_points
      }
    end

    def powerplay_questions
      powerplay1_questions.merge(
        overs_10_questions, overs_10_20_questions, overs_16_20_questions, partnership_other_questions
      )
    end

    def powerplay1_questions
      # Points 2
      {
        I18n.t('ipl.pp1_batting1') => powerplay1_points,
        I18n.t('ipl.pp1_batting2') => powerplay1_points
      }
    end

    def overs_10_questions
      # Points 2
      {
        I18n.t('ipl.overs_10_batting1') => overs_10_points,
        I18n.t('ipl.overs_10_batting2') => overs_10_points
      }
    end

    def overs_10_20_questions
      # Points 2
      {
        I18n.t('ipl.overs_10_20_batting1') => overs_10_20_points,
        I18n.t('ipl.overs_10_20_batting2') => overs_10_20_points
      }
    end

    def overs_16_20_questions
      # Points 2
      {
        I18n.t('ipl.overs_16_20_batting1') => overs_16_20_points,
        I18n.t('ipl.overs_16_20_batting2') => overs_16_20_points
      }
    end

    def partnership_other_questions
      {
        I18n.t('semi.best_partnership_in_the_match') => partnership_points,
        I18n.t('ipl.runs_by_first_out_batsman') => runs_by_first_out_points
      }
    end

    def wickets_questions
      # Points 2
      {
        I18n.t('cricket.wickets_in_1st_innings') => wickets_points,
        I18n.t('cricket.wickets_in_2nd_innings') => wickets_points,
        I18n.t('ipl.wickets_in_10_1st_innings') => wickets_points,
        I18n.t('ipl.wickets_in_10_2nd_innings') => wickets_points
      }
    end

    def strike_rate_by_topscorer_questions
      {
        I18n.t('semi.strike_rate_of_top_scorer') => strike_rate_by_topscorer_points
      }
    end

    def others_questions
      drs_questions.merge(
        first_wicket_questions, first_caught_out_questions,
        individual_score_questions, first_boundary_questions,
        strike_rate_by_topscorer_questions
      )
    end
  end
end
