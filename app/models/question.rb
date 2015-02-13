class Question < ActiveRecord::Base
  has_many :match_questions
  has_many :matches, through: :match_questions
  scope :by_question, ->(question) { where(question: question) }

  def all_options_for(match)
    case question
    when 'Who will win the match'
      { v: %W(#{match.team1_short_name} #{match.team2_short_name} Tie #{'No Result'}) }
    when 'Who will win the toss', 'Who will be batting first'
      { v: %W(#{match.team1_short_name} #{match.team2_short_name}) }
    when 'Runs will be scored by the team batting first', 'Runs will be scored by the team batting second'
      { v: %w(<100 100-175 176-225 226-280 281-350 350<) }
    else
      { v: %w() }
    end
  end
end
