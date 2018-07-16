# CricketQuestions
module CricketQuestions
  extend ActiveSupport::Concern

  included do
    # scope :team_score, ->(short_name) { where(question: "Runs will be scored by the team #{short_name}?") }
    scope :team_score, ->(name) { where(question: "Runs will be scored by #{name}?") }
    scope :defaults, -> { where(question: %w(Who\ will\ win\ the\ match? Who\ will\ win\ the\ toss?)) }
    scope :mom, -> { where(question: 'Who will be the man of the match?') }
    scope :not_defaults, -> { where('question not like ? and question not like ?', '%Who will win the%', '%Runs will be scored by the team%') }
    scope :points_2, -> { where(points: 2) }
    scope :points_1, -> { where(points: 1) }
    scope :outs, -> { where('question like ?', '%outs in the match%') }
    scope :not_outs, -> { where('question not like ?', '%outs in the match%') }
    scope :power_plays, -> { where('question like ?', '%How many runs will be scored%') }
    scope :not_power_plays, -> { where('question not like ?', '%How many runs will be scored%') }
    scope :not_mom, -> { where('question not like ?', '%man of the match%') }
    scope :drs, -> { where('question like ?', '%Total No. of DRS usage in the match%') }
    scope :extras, -> { where('question like ?', '%Total No. of Extras in the match%') }
    scope :lbw, -> { where('question like ?', '%Total No. of Caught outs in the match%') }
    scope :caught_out, -> { where('question like ?', '%Total No. of LBW outs in the match%') }
    scope :winning_margin, -> { where('question like ?', '%Winning margin will be%') }
    scope :power_play2_batting_first, lambda {
      where('question like ?', '%How many runs will be scored in the Power Play2 by the team batting first%')
    }
  end
end
