class Question < ActiveRecord::Base
  has_many :match_questions
  has_many :matches, through: :match_questions
  scope :by_question, ->(question) { where(question: question) }
  scope :team_score, ->(short_name) { where(question: "Runs will be scored by the team #{short_name}?") }
  scope :defaults, -> { where(question: %W(#{'Who will win the match?'} #{'Who will win the toss?'} #{'Who will be the man of the match?'})) }
  scope :not_defaults, -> { where("question not like ? and question not like ?", '%Who will win the%', '%Runs will be scored by the team%') }
  scope :points_2, -> { where(points: 2) }
  scope :points_1, -> { where(points: 1) }
  scope :outs, -> { where('question like ?', '%outs that can happen in the match%') }
  scope :not_outs, -> { where('question not like ?', '%outs that can happen in the match%') }
  scope :power_plays, -> { where('question like ?', '%How many runs will be scored%') }
  scope :not_power_plays, -> { where('question not like ?', '%How many runs will be scored%') }
  scope :not_mom, -> { where('question not like ?', '%man of the match%') }


  # FIFA QUESTION SCOPES
  scope :fifa_team_score, ->(name) { where(question: "Goals scored by #{name}?") }
  scope :fifa_defaults, -> { where(question: 'Who will win the match?') }
  scope :fifa_not_defaults, -> { where("question not like ?", '%Who will win the%') }
  scope :fifa_cards, ->(name) { where('question = ?', "Total shots by #{name}?") }
  scope :fifa_shots, -> { where('question like ?', 'Total shots%') }
  scope :fifa_possession, -> { where('question like ?', 'Possession percentage by%') }
  scope :match_ends_in, -> { where('question like ?', 'This Match ends in%') }

  scope :fifa_cards_percentage, lambda { |name1, name2|
    where('question like ? or question = ? or question = ?', 'No of%in the match%',
                                                              )
  }

  scope :fifa_ko_cards_defensive_only, lambda {
    where('(question like ? or question like ?) and question not like ?',
             'No of%in the match%', "Total no. of%", "%Red cards%").order('id desc')
  }

  scope :fifa_shots_first_goal_percentage, lambda { |name1, name2|
    where('question = ? or question = ? or
           question = ? or question = ? or
           question = ? or question = ? or
           question = ? or question = ? or
           question like ? or question like ?', "Total shots by #{name1}?",
                                          "Total shots by #{name2}?",
                                          "Total shots on Target by #{name1}?",
                                          "Total shots on Target by #{name2}?",
                                          "Time of first goal by #{name1}?",
                                          "Time of first goal by #{name2}?",
                                          "Possession percentage by #{name1}?",
                                          "Possession percentage by #{name2}?",
                                          "Total goals in extra time%",
                                          "Total goal attempts in the match%")
  }

  scope :fifa_shots_first_goal, lambda { |name1, name2|
    where('question = ? or question = ? or
           question = ? or question = ? or
           question = ? or question = ?', "Total shots by #{name1}?",
                                          "Total shots by #{name2}?",
                                          "Total shots on Target by #{name1}?",
                                          "Total shots on Target by #{name2}?",
                                          "Time of first goal by #{name1}?",
                                          "Time of first goal by #{name2}?")
  }

  def all_options_for(match)
    case question
    when 'Who will win the match?'
      { v: %W(#{match.team1_short_name} #{match.team2_short_name} Tie #{'No Result'}) }
    when 'Who will win the toss?', 'Who will be batting first?'
      { v: %W(#{match.team1_short_name} #{match.team2_short_name}) }
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
      { v: %W(#{'1-3 wkts'} #{'4-6 wkts'} #{'7< wkts'} #{'0-20 runs'} #{'21-50 runs'} #{'50< runs'} Tie #{'No Result'}) }
    else
      { v: %w() }
    end
  end

  def all_fifa_options_for(match)
    if question == 'Who will win the match?'
      { v: %W(#{match.team1_name} #{match.team2_name} Draw #{'No Result'}) }
    elsif question.match(/Goals scored by/)
      { v: %w(0 1 2 3 3+) }
    elsif question.match(/No of Fouls/)
      { v: %w(0-10 11-15 16-20 21-25 25+) }
    elsif question.match(/No of Corners/)
      { v: %w(0-3 4-7 8-10 11-15 15+) }
    elsif question.match(/No of Offsides/)
      { v: %w(0 1-2 3-4 5-6 6+) }
    elsif question.match(/No of/)
      { v: %w(0 1 2 3-5 5+) }
    elsif question.match(/Total shots by/)
      { v: %w(0-3 4-6 7-9 10-15 15+) }
    elsif question.match(/Total shots on Target by/)
      { v: %w(0-1 2-3 4-6 7-10 10+) }
    elsif question.match(/Possession percentage/)
      { v: %w(0-30 31-40 41-50 51-60 60+) }
    elsif question.match(/Time of first goal/)
      { v: %w(0-25 26-45 46-75 76-90 No\ Goal) }
    else
      { v: %w() }
    end
  end

  def all_fifa_ko_options_for(match)
    if question == 'Who will win the match?'
      { v: %W(#{match.team1_name} #{match.team2_name} #{'No Result'}) }
    elsif question.match(/Total pass accuracy by/)
      { v: %w(0-75 76-80 81-85 86-90 91-95 96-100) }
    elsif question.match(/This Match ends in/)
      { v: %w(Full\ Time Extra\ Time Shoot\ Out Sudden\ Death) }
    elsif question.match(/Total goals in extra time/)
      { v: %w(0 1 2 3 3+ Game\ ends\ in\ Full\ Time) }
    elsif question.match(/Total goal attempts in the match/)
      { v: %w(0-10 11-20 21-26 26-31 31-35 35+) }

    elsif question.match(/Total no. of tackles in the match/)
      { v: %w(0-10 11-20 21-26 26-31 31-35 35+) }
    elsif question.match(/Total no. of blocks in the match/)
      { v: %w(0-2 3-5 6-8 9-10 11-12 12+) }
    elsif question.match(/Total no. of clearances in the match/)
      { v: %w(0-25 26-35 36-45 46-55 56-60 60+) }
    elsif question.match(/Total no. of cards/)
      { v: %w(0-1 2-3 4-5 6-7 8 8+) }

    elsif question.match(/Goals scored by/)
      { v: %w(0 1 2 3 4 4+) }
    elsif question.match(/No of Fouls/)
      { v: %w(0-10 11-15 16-20 21-25 26-30 30+) }
    elsif question.match(/No of Corners/)
      { v: %w(0-3 4-6 7-9 10-12 13-15 15+) }
    elsif question.match(/No of Offsides/)
      { v: %w(0-1 2 3 4 5 5+) }
    elsif question.match(/No of/)
      { v: %w(0-1 2 3 4 5 5+) }
    elsif question.match(/Total shots by/)
      { v: %w(0-3 4-6 7-9 10-12 13-15 15+) }
    elsif question.match(/Total shots on Target by/)
      { v: %w(0-1 2-3 4-5 6-7 8-10 10+) }
    elsif question.match(/Possession percentage/)
      { v: %w(0-30 31-40 41-45 46-50 51-60 60+) }
    elsif question.match(/Time of first goal/)
      { v: %w(0-25 26-45 46-75 76-90 Extra\ Time Penalty No\ Goal) }
    else
      { v: %w() }
    end
  end

  class << self
    def others
      not_defaults.not_outs.not_power_plays.not_mom
    end

    def fifa_others
      fifa_not_defaults.fifa_not_cards.fifa_not_possession
    end
  end
end
