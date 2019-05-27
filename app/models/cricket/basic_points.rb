# module Cricket
module Cricket
  # module BasicPoints
  module BasicPoints
    def default_points
      []
    end

    def default_winning_margin_points
      [5, default_winning_margin_options]
    end

    def team_score_points
      [2, team_score_options]
    end

    def no_of_out_points
      [2, no_of_out_options]
    end

    def no_of_extras_points
      [2, no_of_extras_options]
    end

    def powerplay1_points
      [2, powerplay1_options]
    end

    def powerplay2_points
      [2, powerplay2_options]
    end

    def powerplay3_points
      [2, powerplay3_options]
    end

    def overs_25_points
      [2, overs_25_options]
    end

    def overs_30_40_points
      [2, overs_30_40_options]
    end

    def bowler_batsman_points
      [2, bowler_batsman_options]
    end

    def no_of_sixes_points
      [2, no_of_sixes_options]
    end

    def no_of_boundaries_points
      [2, no_of_boundaries_options]
    end

    def wickets_points
      [2, wickets_options]
    end

    def drs_points
      [2, drs_options]
    end

    def first_wicket_points
      [2, first_wicket_options]
    end

    def first_caught_out_points
      [2, first_caught_out_options]
    end

    def individual_score_points
      [2, individual_score_options]
    end

    def first_boundary_points
      [2, first_boundary_options]
    end
  end
end
