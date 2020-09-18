# Match
class Match < ApplicationRecord
  # Associations
  belongs_to :challenge, optional: true
  belongs_to :stadium
  belongs_to :round, optional: true
  belongs_to :tournament
  belongs_to :team1, class_name: 'Team', foreign_key: :team1_id
  belongs_to :team2, class_name: 'Team', foreign_key: :team2_id
  has_many :match_questions, dependent: :destroy
  has_many :questions, through: :match_questions
  # validations
  validates :match_no, :team1_id, :team2_id, presence: true
  # Scopes
  scope :by_match_no, ->(match_no) { where(match_no: match_no) }
  scope :id_in, ->(match_ids) { where(id: match_ids) }
  scope :no_in, ->(match_no) { where(match_no: match_no) }
  scope :by_challenge, ->(challenge) { where(challenge_id: challenge.id) }
  scope :current_matches, -> { where('match_date >= ?', Date.today.to_time) }

  def self.by_team(team_id)
    where('team1_id = :team OR team2_id = :team_id', team: team_id)
  end

  def team1_name
    team1.try(:name)
  end

  def team2_name
    team2.try(:name)
  end

  def team_players(team)
    send(team).players.pluck(:id, :first_name, :player_style)
              .collect { |u| ["#{u[1]} (#{u[2].upcase})", u[0]] }
  end

  def team1_short_name
    team1.try(:short_name)
  end

  def team2_short_name
    team2.try(:short_name)
  end

  def full_name
    "Match #{match_no} : #{team1_short_name} VS #{team2_short_name}"
  end

  def full_name_with_date
    "#{full_name} - #{match_date.to_s(:default_with_time)}"
  end

  def full_name_with_points
    "#{full_name} : #{total_points}(pts)"
  end

  def stadium_name
    stadium.try(:name)
  end

  def total_points
    match_questions.sum(:points)
  end

  def started?
    (match_date - 10.minutes) <= Time.zone.now
  end

  # Creating match questions based on question
  def create_match_question(question, selected_questions = {})
    match_question = match_questions.by_question(question).first_or_initialize
    options = selected_questions.fetch(question.question, [])[1]
    raise 'Invalid options' if options.nil?
    match_question.options = { v: options }
    match_question.points = question.weightage
    match_question.save
    p "#{match_question.id} - Match: #{match_no}, Q: #{question.question}, Options: #{options}"
  end

  rails_admin do
    # list do
      # field :team1_short_name
      # field :team2_short_name
      # field :created_at
    # end
  end
end
