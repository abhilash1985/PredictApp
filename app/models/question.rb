class Question < ActiveRecord::Base
  has_many :match_questions
  has_many :matches, through: :match_questions
  scope :by_question, ->(question) { where(question: question) }
  scope :team_score, ->(short_name) { where(question: "Runs will be scored by the team #{short_name} will be?") }
  scope :defaults, -> { where(question: %W(#{'Who will win the match?'} #{'Who will win the toss?'} #{'Who will be the man of the match?'})) }
  scope :not_defaults, -> { where("question not like ? and question not like ?", '%Who will win the%', '%Runs will be scored by the team%') }
  scope :points_2, -> { where(points: 2) }
  scope :points_1, -> { where(points: 1) }
  scope :outs, -> { where('question like ?', '%outs that can happen in the match%') }
  scope :not_outs, -> { where('question not like ?', '%outs that can happen in the match%') }
  scope :power_plays, -> { where('question like ?', '%How many runs will be scored%') }
  scope :not_power_plays, -> { where('question not like ?', '%How many runs will be scored%') }
  scope :not_mom, -> { where('question not like ?', '%man of the match%') }

  def all_options_for(match)
    case question
    when 'Who will win the match?'
      { v: %W(#{match.team1_short_name} #{match.team2_short_name} Tie #{'No Result'}) }
    when 'Who will win the toss?', 'Who will be batting first?'
      { v: %W(#{match.team1_short_name} #{match.team2_short_name}) }
    when 'Runs will be scored by the team batting first?', 'Runs will be scored by the team batting second?',
         'Runs will be scored by the team AFG will be?', 'Runs will be scored by the team BAN will be?',
         'Runs will be scored by the team ENG will be?', 'Runs will be scored by the team IND will be?',
         'Runs will be scored by the team NZ will be?', 'Runs will be scored by the team PAK will be?',
         'Runs will be scored by the team IRE will be?', 'Runs will be scored by the team SA will be?',
         'Runs will be scored by the team WI will be?', 'Runs will be scored by the team AUS will be?',
         'Runs will be scored by the team ZIM will be?', 'Runs will be scored by the team SCO will be?',
         'Runs will be scored by the team UAE will be?', 'Runs will be scored by the team SL will be?'
      { v: %w(<125 126-175 176-225 226-280 281-330 330<) }
    when 'No. of bowled outs that can happen in the match?', 'No. of caught outs that can happen in the match?',
         'No. of run outs that can happen in the match?', 'No. of lbw outs that can happen in the match?'
      { v: %w(0 1-3 4-7 8-10 10<) }
    when 'How many runs will be scored in the batting power play by the team batting first?',
         'How many runs will be scored in the batting power play by the team batting second?'
      { v: %w(0-20 21-30 31-40 41-50 50<) }
    when 'How many runs will be scored in the mandatory power play by the team batting first?',
         'How many runs will be scored in the mandatory power play by the team batting second?',
         'How many runs will be scored in the log overs by the team batting first?'
      { v: %w(<30 31-50 51-65 66-80 80<) }
    when 'How many runs will be scored in the first 25 overs by the team batting first?',
         'How many runs will be scored in the first 25 overs by the team batting second?'
      { v: %w(<75 76-100 101-120 121-150 150<) }
    when 'Highest individual score in the match will be?'
      { v: %w(<30 31-50 51-70 71-85 85<) }
    when 'How many sixes will be hit by both the teams in the match?'
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

  class << self
    def others
      not_defaults.not_outs.not_power_plays.not_mom
    end
  end
end
