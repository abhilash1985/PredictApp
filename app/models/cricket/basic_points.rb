# module Cricket
module Cricket
  # module BasicPoints
  module BasicPoints
    def default_points
      []
    end

    def default_winning_margin_points
      [3, default_winning_margin_options]
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
      [2, no_of_out_options]
    end

    def overs_30_40_points
      [2, no_of_out_options]
    end

    def bowler_batsman_points
      [3, no_of_out_options]
    end

    def no_of_sixes_points
      [2, no_of_out_options]
    end

    def no_of_boundaries_points
      [2, no_of_out_options]
    end

    def wickets_points
      [2, no_of_out_options]
    end

    def drs_points
      [2, no_of_out_options]
    end

    def first_wicket_points
      [2, no_of_out_options]
    end

    def first_caught_out_points
      [2, no_of_out_options]
    end

    def individual_score_points
      [2, no_of_out_options]
    end

    def first_boundary_points
      [2, no_of_out_options]
    end
  end
end
