# Challenge
class Challenge < ApplicationRecord
  include FifaChallenges
  # Associations
  belongs_to :tournament
  has_many :matches, dependent: :destroy
  has_many :user_challenges, dependent: :destroy
  has_many :users, through: :user_challenges
  has_many :challenge_payments, dependent: :destroy
  # Validations
  validates :name, :start_time, :end_time, presence: true
  # Scopes
  scope :by_name, ->(name) { where(name: name) }
  scope :ids_in, ->(ids) { where(id: ids) }
  scope :current, -> { where('end_time > ?', DateTime.now).includes(matches: [{ team1: :players }, { team2: :players }, :stadium, :match_questions]) }
  scope :previous, -> { where('end_time < ?', DateTime.now).includes(matches: [{ team1: :players }, { team2: :players }, :stadium, :match_questions]) }
  scope :knockout, -> { where('id > ?', 26) }
  scope :completed, -> { where('end_time < ?', DateTime.now) }

  def name_with_date
    "#{name} - #{start_time.to_s(:date_only)}"
  end

  def started?
    end_time <= DateTime.now
  end

  def total_points
    matches.reduce(0) { |a, e| a + e.total_points }
  end
end
