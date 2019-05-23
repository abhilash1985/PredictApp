# module Cricket
module Cricket
  # module BasicOptions
  module BasicOptions
    def default_options
      []
    end

    def default_win_options
      return [] if match.blank?
      [match.team1_name, match.team2_name, 'Tie', 'No Result']
    end

    def default_winning_margin_options
      ['No Results', 'Tie', '1-25Runs', '26-50Runs', '50+Runs', '1-3Wickets', '4-7Wickets',
       '7+Wickets']
    end

    def team_score_options
      %w(0-175 176-225 226-260 261-285 286-320 321-350 351-375 375+)
    end

    def no_of_out_options
      %w(0 1-2 3-4 5-6 7-8 9-10 11-15 15+)
    end

    def no_of_extras_options
      %w(0 1-3 4-7 8-10 11-15 16-20 21-25 25+)
    end

    def powerplay1_options
      %w(0-30 31-40 41-50 51-55 56-65 66-75 76-85 85+)
    end

    def powerplay2_options
      %w(0-75 76-100 101-120 121-130 131-140 141-150 151-175 175+)
    end

    def powerplay3_options
      %w(0-40 41-50 51-60 61-70 71-80 81-90 91-100 100+)
    end

    def overs_25_options
      %w(0-75 76-100 101-120 121-130 131-140 141-150 151-175 175+)
    end

    def overs_30_40_options
      %w(0-30 31-40 41-50 51-55 56-65 66-75 76-85 85+)
    end

    def bowler_batsman_options
      []
    end

    def no_of_sixes_options
      %w(0 1-2 3-5 6-8 9-10 11-12 13-15 15+)
    end

    def no_of_boundaries_options
      %w(0-5 6-10 11-15 16-20 21-25 26-30 31-35 35+)
    end

    def wickets_options
      %w(0-1 2-3 4 5 6 7 8 9-10)
    end

    def drs_options
      %w(0 1 2 3 4 5 6 6+)
    end

    def first_wicket_options
      ['Caught Behind', 'LBW', 'Stumped', 'Hit Wicket', 'RunOut', 'Bowled', 'Caught & Bowled',
       'Others', 'No Wickets']
    end

    def first_caught_out_options
      ['Caught Behind', 'Slip', 'Caught & Bowled', 'Long Off', 'Thirdman', 'Long On', 'Others',
       'No Caught Out']
    end

    def individual_score_options
      %w(0-40 41-60 61-75 76-90 91-100 101-125 126-150 150+)
    end

    def first_boundary_options
      ['Cover Drive', 'Square Cut', 'Stright Drive', 'Edge', 'Pull Shot', 'Hook', 'Others',
       'No Boundary']
    end
  end
end
