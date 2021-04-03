# module Cricket
module Cricket
  # module IplBasicPoints
  module IplBasicPoints
    def default_points
      []
    end

    def overs_10_points
      [2, overs_10_options]
    end

    def overs_11_20_points
      [2, overs_11_20_options]
    end

    def overs_16_20_points
      [2, overs_16_20_options]
    end

    def partnership_points
      [2, partnership_options]
    end

    def runs_by_first_out_points
      [2, runs_by_first_out_options]
    end

    def economy_bowler_points
      [2, default_options]
    end

    def best_sr_points
      [2, default_options]
    end

    def best_extras_points
      [2, default_options]
    end

    def best_avg_points
      [2, default_options]
    end

    def best_sr_bowler_points
      [2, default_options]
    end

    def no_of_runs_in_40_points
      [2, no_of_runs_in_40_options]
    end

    def no_of_runs_in_25_points
      [2, no_of_runs_in_25_options]
    end

    def no_of_wickets_by_starc_and_behren_points
      [2, no_of_wickets_by_starc_and_behren_options]
    end

    # Final Questions
    def overs_46_50_batting1_points
      [2, overs_46_50_batting1_options]
    end

    def most_runs_scored_in_over_points
      [2, most_runs_scored_in_over_options]
    end

    def no_of_boundaries_scored_in_final_points
      [2, no_of_boundaries_scored_in_final_options]
    end

    def bowler_with_most_extras_points
      [2, bowler_with_most_extras_options]
    end

    def longest_six_points
      [2, longest_six_options]
    end

    def best_sr_batsman_in_final_points
      [2, best_sr_batsman_in_final_options]
    end

    def strike_rate_by_topscorer_points
      [2, strike_rate_by_topscorer_options]
    end

    def specific_over_points
      [2, specific_over_options]
    end
  end
end
