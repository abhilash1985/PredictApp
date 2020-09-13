# module Cricket
module Cricket
  # module IplBasicOptions
  module IplBasicOptions
    def default_options
      []
    end

    def default_win_options
      return [] if match.blank?
      [match.team1_name, match.team2_name, 'No Result']
    end

    def default_toss_options
      return [] if match.blank?
      [match.team1_name, match.team2_name, 'No Result']
    end

    def default_winning_margin_options
      ['No Results', '1-15Runs', '16-30Runs', '31-50Runs', '50+Runs', '1-3Wickets',
        '4-5Wickets', '6-7Wickets', '8-10Wickets']
    end

    def team_score_options
      %w(0-120 121-140 141-150 151-160 161-175 176-200 201-220 220+)
    end

    def no_of_out_options
      %w(0 1-2 3-4 5-6 7 8 9-10 10+)
    end

    def no_of_extras_options
      %w(0-3 4-7 8-10 11-15 16-20 21-25 26-30 30+)
    end

    def powerplay1_options
      %w(0-30 31-40 41-45 46-50 51-56 56-60 61-70 70+)
    end

    def overs_10_options
      %w(0-40 41-50 51-60 61-70 71-75 76-85 86-100 100+)
    end

    def overs_10_20_options
      %w(0-50 51-60 61-70 71-80 81-90 91-100 101-120 120+)
    end

    def overs_16_20_options
      %w(0-30 31-40 41-45 46-50 51-56 56-65 66-75 75+)
    end

    def bowler_batsman_options
      []
    end

    def no_of_sixes_options
      %w(0-2 3-5 6-8 9-10 11-12 13-15 16-20 20+)
    end

    def no_of_boundaries_options
      %w(0-5 6-10 11-15 16-20 21-25 26-30 31-35 35+)
    end

    def wickets_options
      %w(0-1 2 3 4-5 6 7 8 9-10)
    end

    def drs_options
      %w(0 1 2 3 4 5 6 6+)
    end

    def first_wicket_options
      ['Caught Behind', 'LBW', 'Stumped', 'RunOut', 'Bowled', 'Caught & Bowled',
       'Others', 'No Wickets']
    end

    def first_caught_out_options
      ['Caught Behind', 'Slip', 'Caught & Bowled', 'Long Off', 'Thirdman', 'Long On', 'Others',
       'No Caught Out']
    end

    def individual_score_options
      %w(0-40 41-50 51-60 61-70 71-80 81-90 91-100 100+)
    end

    def first_boundary_options
      ['Cover Drive', 'Square Cut', 'Stright Drive', 'Edge', 'Pull Shot', 'Hook Shot', 'Others',
       'No Boundary']
    end

    def partnership_options
      %w[0-50 51-60 61-70 71-80 81-90 91-100 101-120 120+]
    end

    def runs_by_first_out_options
       ['0-10', '11-20', '21-30', '31-40', '41-50', '51-75', '75+' 'No Wickets Lost']
    end

    def strike_rate_by_topscorer_options
      %w[0-100 101-120 121-130 131-140 141-150 151-160 161-175 175+]
    end

    # def no_of_runs_in_40_options
    #   %w(0-1 2-3 4-5 6-7 8 9 10 10+)
    # end

    # def no_of_runs_in_25_options
    #   %w(0-1 2-3 4 5 6 7 8 8+)
    # end

    # def no_of_wickets_by_starc_and_behren_options
    #   %w(0-1 2 3 4 5 6 7 7+)
    # end

    # Final options
    # def overs_46_50_batting1_options
    #   %w(0-10 11-20 21-25 26-30 31-35 36-40 41-45 46-50 50+)
    # end

    def most_runs_scored_in_over_options
      %w(0-6 7-10 11-12 13-15 16-18 19-20 21-23 24-25 25+)
    end

    def no_of_boundaries_scored_in_final_options
      %w(0-5 6-10 11-15 16-20 21-25 26-30 31-35 36-40 40+)
    end

    def bowler_with_most_extras_options
      default_options
    end

    def longest_six_options
      %w(0-80 81-85 86-90 91-95 96-100 101-105 106-110 110+ NoSixes)
    end

    def best_sr_batsman_in_final_options
      %w(0-90 91-100 101-110 111-120 121-130 131-140 141-150 151-170 170+)
    end

    # Strike Rate of Top Scorer
    # Economy of Best Bowler
    # Runs scored by the batsman who gets out first
  end
end
