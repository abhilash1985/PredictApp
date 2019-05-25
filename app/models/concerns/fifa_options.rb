# FifaOptions
module FifaOptions
  extend ActiveSupport::Concern

  def all_fifa_options_for(match)
    if question == 'Who will win the match?'
      { v: %W(#{match.team1_name} #{match.team2_name} Draw No\ Result) }
    elsif question =~ /Goals scored by/
      { v: %w(0 1 2 3 3+) }
    elsif question =~ /No of Fouls/
      { v: %w(0-10 11-15 16-20 21-25 25+) }
    elsif question =~ /No of Corners/
      { v: %w(0-3 4-7 8-10 11-15 15+) }
    elsif question =~ /No of Offsides/
      { v: %w(0 1-2 3-4 5-6 6+) }
    elsif question =~ /No of/
      { v: %w(0 1 2 3-5 5+) }
    elsif question =~ /Total shots by/
      { v: %w(0-3 4-6 7-9 10-15 15+) }
    elsif question =~ /Total shots on Target by/
      { v: %w(0-1 2-3 4-6 7-10 10+) }
    elsif question =~ /Possession percentage/
      { v: %w(0-30 31-40 41-50 51-60 60+) }
    elsif question =~ /Time of first goal/
      { v: %w(0-25 26-45 46-75 76-90 No\ Goal) }
    else
      { v: %w() }
    end
  end

  def all_fifa_ko_options_for(match)
    if question == 'Who will win the match?'
      { v: %W(#{match.team1_name} #{match.team2_name} No\ Result) }
    elsif question =~ /Total pass accuracy by/
      { v: %w(0-70 71-75 76-80 81-85 86-90 91-95 96-100) }
    elsif question =~ /This Match ends in/
      { v: %w(Full\ Time Extra\ Time Shoot\ Out Sudden\ Death) }
    elsif question =~ /Total goals in extra time/
      { v: %w(0 1 2 3 3+ Game\ ends\ in\ Full\ Time) }
    elsif question =~ /Total goal attempts in the match/
      { v: %w(0-10 11-15 16-20 21-25 26-30 31-35 35+) }

    elsif question =~ /Total no. of tackles in the match/
      { v: %w(0-10 11-15 16-20 21-25 26-30 31-35 35+) }
    elsif question =~ /Total no. of blocks in the match/
      { v: %w(0-2 3-5 6-8 9-10 11-12 13-15 15+) }
    elsif question =~ /Total no. of clearances in the match/
      { v: %w(0-25 26-35 36-45 46-50 51-55 56-60 60+) }
    elsif question =~ /Total no. of cards/
      { v: %w(0-1 2-3 4-5 6-7 8 8+) }

    elsif question =~ /Total no. of balls recovered in the match/
      { v: %w(0-50 51-60 61-70 71-80 81-90 91-100 100+) }
    elsif question =~ /Total no. of woodworks in the match?/
      { v: %w(0 1 2 3 4 5 5+) }
    elsif question =~ /Total no. of penalties in the match/
      { v: %w(0 1 2 3 4 5 5+) }
    elsif question =~ /Total distance/
      { v: %w(0-80 81-90 91-100 101-110 111-120 121-130 130+) }

    elsif question =~ /Who will score first goal for France/
      { v: %w(Griezmann Mbappe Giroud Pogba Others No\ Goal) }
    elsif question =~ /Who will score first goal for Croatia/
      { v: %w(Modric Rebic Mandzukic Rakitic Others No\ Goal) }
    elsif question =~ /Who will score first goal for Brazil/
      { v: %w(NeymarJr Coutinho Willian Paulinho Others No\ Goal) }
    elsif question =~ /Who will score first goal for England/
      { v: %w(Kane Sterling Lingard Stones Others No\ Goal) }

    elsif question =~ /Who will score first goal for Belgium/
      { v: %w(Lukaku Hazard DeBruyne Fellaini Chadli Others No\ Goal) }

    elsif question =~ /Who will be Man of the Match/
      { v: %w(Lukaku Mbappe DeBruyne Griezmann Hazard Giroud Others) }

    elsif question =~ /First goal in the match will be/
      { v: %w(Penalty Free-kick Long-range Header Own-Goal Others) }

    elsif question =~ /Who will win Fifa World Cup 2018/
      { v: %w(France Croatia) }
    elsif question =~ /Total Goals scored by France/
      { v: %w(0 1 2 3 4 5 5+) }
    elsif question =~ /Total Goals scored by Croatia/
      { v: %w(0 1 2 3 4 5 5+) }
    elsif question =~ /Who will win Golden Ball of the tournament/
      { v: %w(Hazard Modric Mbappe Kante Griezmann Kane Subasic Others) }
    elsif question =~ /Who will score first goal in the Match/
      { v: %w(Modric Mbappe Umtiti Perisic Griezmann Mandzukic Others) }

    elsif question =~ /Who will win 3rd Place/
      { v: %w(Belgium England) }
    elsif question =~ /Total Goals scored by Belgium/
      { v: %w(0 1 2 3 4 5 5+) }
    elsif question =~ /Total Goals scored by England/
      { v: %w(0 1 2 3 4 5 5+) }
    elsif question =~ /Who will be Budweiser Man of the Match/
      { v: %w(Lukaku Kane DeBruyne Young Hazard Pickford Others) }


    elsif question =~ /Goals scored by/
      { v: %w(0 1 2 3 4 4+) }
    elsif question =~ /No of Fouls/
      { v: %w(0-10 11-15 16-20 21-25 26-30 30+) }
    elsif question =~ /No of Corners/
      { v: %w(0-3 4-6 7-9 10-12 13-15 15+) }
    elsif question =~ /No of Offsides/
      { v: %w(0-1 2 3 4 5 5+) }
    elsif question =~ /No of/
      { v: %w(0-1 2 3 4 5 5+) }
    elsif question =~ /Total shots by/
      { v: %w(0-3 4-6 7-9 10-12 13-15 15+) }
    elsif question =~ /Total shots on Target by/
      { v: %w(0-1 2-3 4-5 6-7 8-10 10+) }
    elsif question =~ /Possession percentage/
      { v: %w(0-30 31-40 41-45 46-50 51-60 60+) }
    elsif question =~ /Time of first goal/
      { v: %w(0-25 26-45 46-75 76-90 Extra\ Time Penalty No\ Goal) }
    else
      { v: %w() }
    end
  end

  def self.others
    not_defaults.not_outs.not_power_plays.not_mom
  end

  def self.fifa_others
    fifa_not_defaults.fifa_not_cards.fifa_not_possession
  end
end
