# frozen_string_literal: true

# module Cricket
module Cricket
  # module BasicQuestions
  module BasicQuestions
    def default_questions
      {
        I18n.t('cricket.win_the_match') => [10, default_win_options],
        I18n.t('cricket.mom') => [5, default_options]
      }
    end

    def default_winning_margin_questions
      # Points  # 3
      # No Results, Tie, 1-25Runs, 26-50Runs, 50+Runs, 1-3Wickets, 4-7Wickets, 7+Wickets
      {
        I18n.t('cricket.winning_margin') => default_winning_margin_points
      }
    end

    def team_score_questions
      team_1st_2nd_score_questions.merge(all_team_score_questions)
    end

    def team_1st_2nd_score_questions # Points 2
      {
        I18n.t('cricket.runs_1st_innings') => team_score_points,
        I18n.t('cricket.runs_2nd_innings') => team_score_points
      }
    end

    # def all_team_score_questions
    #   # Points 2
    #   # # 0-175, 176-225, 226-260, 261-285, 286-320, 321-350, 351-375, 375+
    #   {
    #     I18n.t('cricket.runs_afg') => team_score_points,
    #     I18n.t('cricket.runs_ban') => team_score_points,
    #     I18n.t('cricket.runs_eng') => team_score_points,
    #     I18n.t('cricket.runs_nzl') => team_score_points,
    #     I18n.t('cricket.runs_ind') => team_score_points,
    #     I18n.t('cricket.runs_pak') => team_score_points,
    #     I18n.t('cricket.runs_sa') => team_score_points,
    #     I18n.t('cricket.runs_aus') => team_score_points,
    #     I18n.t('cricket.runs_sl') => team_score_points,
    #     I18n.t('cricket.runs_wi') => team_score_points
    #   }
    # end

    def team_score_questions_for(team_name)
      # Points 2
      {
        I18n.t('cricket.runs_with_team_name', team_name: team_name) => team_score_points
      }
    end

    def no_of_out_questions
      # Points 2
      # 0, 1-2, 3-4, 5-6, 7-8, 9-10, 11-15 15+
      {
        I18n.t('cricket.no_of_bowled') => no_of_out_points,
        I18n.t('cricket.no_of_caught') => no_of_out_points,
        I18n.t('cricket.no_of_run_out') => no_of_out_points,
        I18n.t('cricket.no_of_stumped') => no_of_out_points,
        I18n.t('cricket.no_of_lbw') => no_of_out_points,
        I18n.t('cricket.no_of_other_outs') => no_of_out_points
      }
    end

    def no_of_extras_questions
      # Points 2
      # 0, 1-3, 4-7, 8-10, 11-15, 16-20, 21-25, 25+
      {
        I18n.t('cricket.no_of_extras') => no_of_extras_points,
        I18n.t('cricket.no_of_wide') => no_of_extras_points,
        I18n.t('cricket.no_of_no_ball') => no_of_extras_points,
        I18n.t('cricket.no_of_bye') => no_of_extras_points,
        I18n.t('cricket.no_of_leg_bye') => no_of_extras_points
      }
    end

    def powerplay_questions
      powerplay1_questions.merge(
        powerplay2_questions, powerplay3_questions, overs_25_questions, overs_30_40_questions
      )
    end

    def powerplay1_questions
      # Points 2
      # 0-30, 31-40, 41-50, 51-55, 56-65, 66-75, 76-85, 85+
      {
        I18n.t('cricket.pp1_batting1') => powerplay1_points,
        I18n.t('cricket.pp1_batting2') => powerplay1_points
      }
    end

    def powerplay2_questions
      # Points 2
      # 0-75, 76-100, 101-120, 121-130, 131-140, 141-150, 151-175, 175+
      {
        I18n.t('cricket.pp2_batting1') => powerplay2_points,
        I18n.t('cricket.pp2_batting2') => powerplay2_points
      }
    end

    def powerplay3_questions
      # Points 2
      # 0-40, 41-50, 51-60, 61-70, 71-80, 81-90, 91-100, 100+
      {
        I18n.t('cricket.pp3_batting1') => powerplay3_points,
        I18n.t('cricket.pp3_batting2') => powerplay3_points
      }
    end

    def overs_25_questions
      # Points 2
      # 0-75, 76-100, 101-120, 121-130, 131-140, 141-150, 151-175, 175+
      {
        I18n.t('cricket.overs_25_batting1') => overs_25_points,
        I18n.t('cricket.overs_25_batting2') => overs_25_points
      }
    end

    def overs_30_40_questions
      # Points 2
      # 0-30, 31-40, 41-50, 51-55, 56-65, 66-75, 76-85, 85+
      {
        I18n.t('cricket.overs_30_40_batting1') => overs_30_40_points,
        I18n.t('cricket.overs_30_40_batting2') => overs_30_40_points
      }
    end

    def bowler_batsman_questions
      # Points 3
      {
        I18n.t('cricket.best_bowler') => bowler_batsman_points,
        I18n.t('cricket.top_scorer') => bowler_batsman_points,
        I18n.t('cricket.top_scorer_2') => bowler_batsman_points,
        I18n.t('cricket.top_scorer_first') => bowler_batsman_points,
        I18n.t('cricket.top_scorer_second') => bowler_batsman_points,
        I18n.t('cricket.top_six_hitter') => bowler_batsman_points,
        I18n.t('cricket.top_four_hitter') => bowler_batsman_points,
        I18n.t('cricket.first_wicket_taker') => bowler_batsman_points,
        I18n.t('cricket.first_wicket_taker_second') => bowler_batsman_points,
        I18n.t('cricket.first_six_hitter') => bowler_batsman_points,
        I18n.t('cricket.first_four_hitter_second') => bowler_batsman_points,
        I18n.t('cricket.first_four_hitter') => bowler_batsman_points,
        I18n.t('cricket.first_six_hitter_second') => bowler_batsman_points
      }
    end

    def no_of_sixes_fours_questions
      no_of_sixes_questions.merge(no_of_boundaries_questions)
    end

    def no_of_sixes_questions
      # Points 2
      # 0, 1-2, 3-5, 6-8, 9-10, 11-12, 13-15, 15+
      {
        I18n.t('cricket.total_sixes') => no_of_sixes_points,
        I18n.t('cricket.total_sixes_1st_innings') => no_of_sixes_points,
        I18n.t('cricket.total_sixes_2nd_innings') => no_of_sixes_points
      }
    end

    def no_of_boundaries_questions
      # Points 2
      # 0-5, 6-10, 11-15, 16-20, 21-25, 26-30, 31-35, 35+
      {
        I18n.t('cricket.total_boundaries') => no_of_boundaries_points,
        I18n.t('cricket.total_boundaries_1st_innings') => no_of_boundaries_points,
        I18n.t('cricket.total_boundaries_2nd_innings') => no_of_boundaries_points,

        I18n.t('cricket.total_fours_sixes') => no_of_boundaries_points,
        I18n.t('cricket.total_fours_sixes_1st_innings') => no_of_boundaries_points,
        I18n.t('cricket.total_fours_sixes_2nd_innings') => no_of_boundaries_points
      }
    end

    def wickets_questions
      # Points 2
      # 0-1, 2-3, 4, 5, 6, 7, 8, 9-10
      {
        I18n.t('cricket.wickets_in_1st_innings') => wickets_points,
        I18n.t('cricket.wickets_in_2nd_innings') => wickets_points,
        I18n.t('cricket.wickets_in_25_1st_innings') => wickets_points,
        I18n.t('cricket.wickets_in_25_2nd_innings') => wickets_points
      }
    end

    def others_questions
      drs_questions.merge(
        toss_questions, first_wicket_questions, first_caught_out_questions,
        individual_score_questions, first_boundary_questions
      )
    end

    def toss_questions
      { I18n.t('cricket.win_the_toss') => [2, default_toss_options] }
    end

    def drs_questions
      # Points 2
      # 0, 1, 2, 3, 4, 5, 6, 7, 7+
      {
        I18n.t('cricket.total_drs') => drs_points
      }
    end

    def first_wicket_questions
      # Points 2
      # CaughtBehind LBW Stumped HitWicket RunOut Bowled Caught&Bowled Others NoWickets
      {
        I18n.t('cricket.first_wicket_in_match') => first_wicket_points,
        I18n.t('ipl.runs_scored_in_first') => runs_scored_first_wicket_points,
        I18n.t('ipl.runs_scored_in_second') => runs_scored_first_wicket_points
      }
    end

    def first_caught_out_questions
      # Points 2
      # CaughtBehind Slip Caught&Bowled LongOff Thirdman LongOn Others NoCaughtOut
      {
        I18n.t('cricket.first_caught_out_in_match') => first_caught_out_points,
        I18n.t('cricket.first_caught_out_in_first_innings') => first_caught_out_points,
        I18n.t('cricket.first_caught_out_in_second_innings') => first_caught_out_points
      }
    end

    def individual_score_questions
      # Points 2
      # 0-40 41-60 61-75 76-90 91-100 101-125 126-150 150+
      {
        I18n.t('cricket.individual_score') => individual_score_points,
        I18n.t('cricket.individual_score_in_1st_innings') => individual_score_points,
        I18n.t('cricket.individual_score_in_2nd_innings') => individual_score_points
      }
    end

    def first_boundary_questions
      # Points 2
      # CoverDrive SquareCut StrightDrive Edge PullShot Hook Others NoBoundary
      {
        I18n.t('cricket.first_boundary_in_match') => first_boundary_points,
        I18n.t('cricket.first_boundary_in_first_innings') => first_boundary_points,
        I18n.t('cricket.first_boundary_in_second_innings') => first_boundary_points
      }
    end
  end
end
