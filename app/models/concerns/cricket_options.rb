# CricketOptions
module CricketOptions
  extend ActiveSupport::Concern

  included do
  end

  def england_tour_options_for(match)
    if question == 'Who will win the match?'
      { v: %W(#{match.team1_name} #{match.team2_name} Tie No\ Result) }
    elsif question =~ /Who will win the toss/ || question =~ /Who will be batting first/
      { v: %W(#{match.team1_name} #{match.team2_name} No\ Result) }
    elsif question =~ /Runs will be scored by/
      { v: %w(<125 126-175 176-225 226-280 281-330 330<) }
    elsif question =~ /Total No. of LBW outs in the match/
      { v: %w(0 1-3 4-6 7-9 10-12 12<) }
    elsif question =~ /Total No. of Caught outs in the match/
      { v: %w(0 1-3 4-6 7-9 10-12 12<) }
    elsif question =~ /Total No. of Extras in the match/
      { v: %w(0-5 6-10 11-15 16-20 21-25 25<) }
    elsif question =~ /Total No. of DRS usage in the match/
      { v: %w(0 1 2 3 4 4+) }
    elsif question =~ /How many runs will be scored in the Power Play2/
      { v: %w(<75 76-100 101-120 121-150 151-175 175<) }
    elsif question =~ /Winning margin will be/
      { v: %w(1-3\ wkts 4-6\ wkts 7<\ wkts 0-20\ runs 21-50\ runs 50<\ runs Tie\ No\ Result) }
    else
      { v: %w() }
    end
  end

  def all_options_for(match)
    case question
    when 'Who will win the match?'
      { v: %W(#{match.team1_name} #{match.team2_name} Tie No\ Result) }
    when 'Who will win the toss?', 'Who will be batting first?'
      { v: %W(#{match.team1_name} #{match.team1_name}) }
    when 'Runs will be scored by the team batting first?', 'Runs will be scored by the team batting second?',
         'Runs will be scored by the team AFG?', 'Runs will be scored by the team BAN?',
         'Runs will be scored by the team ENG?', 'Runs will be scored by the team IND?',
         'Runs will be scored by the team NZ?', 'Runs will be scored by the team PAK?',
         'Runs will be scored by the team IRE?', 'Runs will be scored by the team SA?',
         'Runs will be scored by the team WI?', 'Runs will be scored by the team AUS?',
         'Runs will be scored by the team ZIM?', 'Runs will be scored by the team SCO?',
         'Runs will be scored by the team UAE?', 'Runs will be scored by the team SRI?'
      { v: %w(<125 126-175 176-225 226-280 281-330 330<) }
    when 'No. of bowled outs that can happen in the match?', 'No. of caught outs that can happen in the match?',
         'No. of run outs that can happen in the match?', 'No. of lbw outs that can happen in the match?'
      { v: %w(0 1-3 4-7 8-10 10<) }
    when 'How many runs will be scored in the batting power play by the team batting first?',
         'How many runs will be scored in the batting power play by the team batting second?'
      { v: %w(0-20 21-30 31-40 41-50 50<) }
    when 'How many runs will be scored in the mandatory power play by the team batting first?',
         'How many runs will be scored in the mandatory power play by the team batting second?',
         'How many runs will be scored in the slog overs by the team batting first?'
      { v: %w(<30 31-50 51-65 66-80 80<) }
    when 'How many runs will be scored in the first 25 overs by the team batting first?',
         'How many runs will be scored in the first 25 overs by the team batting second?'
      { v: %w(<75 76-100 101-120 121-150 150<) }
    when 'Highest individual score in the match will be?'
      { v: %w(<30 31-50 51-70 71-85 85<) }
    when 'How many sixes will be hit by both the teams together in the match?'
      { v: %w(0 1-2 3-4 5-6 6<) }
    when 'How many wickets will fell in the first innings of the match?',
         'How many wickets will fell in the first 25 overs of the match?'
      { v: %w(0 1-3 4-6 7-8 9-10) }
    when 'Winning margin will be?'
      { v: %w(1-3\ wkts 4-6\ wkts 7<\ wkts 0-20\ runs 21-50\ runs 50<\ runs Tie\ No\ Result) }
    else
      { v: %w() }
    end
  end
end
