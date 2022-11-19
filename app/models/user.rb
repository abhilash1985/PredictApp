# frozen_string_literal: true

# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable # , :confirmable
  # Associations
  has_many :user_challenges, dependent: :destroy
  has_many :challenges, through: :user_challenges
  has_many :payments, dependent: :destroy
  has_many :challenge_payments, dependent: :destroy
  has_many :prizes, dependent: :destroy

  belongs_to :team, optional: true
  # scope
  scope :order_by_name, -> { order(:first_name) }
  scope :by_team_id, ->(team_id) { where(team_id: team_id) }
  # Constants
  POINT_BOOSTER = 5

  def show_name
    full_name.blank? ? show_email : full_name
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def show_email
    email.split('@')[0]
  end

  def has_predictions_for_match(match)
    !predictions_for_match(match).blank?
  end

  def prediction_for_match_question(challenge, match_question)
    user_challenge = user_challenges.by_challenge(challenge.id).first
    return if user_challenge.blank?

    user_challenge.predictions.by_match_question(match_question.id).first
  end

  def object_from_hash(options = {})
    pages_from_array = %w[prediction edit_prediction_for_user]
    pages_from_array.include?(options[:page_from]) ? options[:prediction] : options[:match_question]
  end

  def checked_value(option, options = {})
    object = object_from_hash(options)
    return if object.blank?

    option == object.user_answer
  end

  def selected_value(options = {})
    object = object_from_hash(options)
    return if object.blank?

    object.user_answer
  end

  def submit_value(match)
    prediction = predictions_for_match(match)
    prediction.blank? ? 'Submit' : 'Update'
  end

  def matches
    # challenges.joins(:matches)
    challenges.flat_map(&:matches)
  end

  def matches_for_challenge(challenge)
    # matches.where('matches.challenge_id = ?', challenge.id)
    matches.select { |match| match.challenge_id == challenge.id }
  end

  def predictions
    user_challenges.joins(:predictions)
  end

  def predictions_for(challenge)
    @prediction ||= predictions.where('user_challenges.challenge_id = ?', challenge.id)
  end

  def predictions_for_tournament(tournament, from = nil)
    challenge_ids = from.blank? ? tournament.challenge_ids : tournament.ko_challenge_ids
    @prediction ||= predictions.where('user_challenges.challenge_id in (?)', challenge_ids)
  end

  def paid_predictions_for_tournament(tournament, from = nil)
    challenge_ids = from.blank? ? tournament.challenge_ids : tournament.ko_challenge_ids
    @paid_prediction ||= predictions.where('user_challenges.challenge_id in (?)
                                            and user_challenges.paid = ?', challenge_ids, true)
  end

  def amount_paid_for(challenge)
    return false if challenge.blank?

    user_challenge = user_challenges.by_challenge(challenge.id).first
    return false if user_challenge.nil?

    user_challenge.try(:paid)
  end

  def total_points_for_challenge(challenge)
    user_challenge = user_challenges.by_challenge(challenge.id).first
    return 0 if user_challenge.nil?

    user_challenge.predictions.sum(:points)
  end

  def total_percentage_for_challenge(challenge)
    points = BigDecimal(total_points_for_challenge(challenge))
    total_points = BigDecimal(challenge.total_points)
    total_points == 0 ? 0 : (points / total_points * 100).round(2)
  end

  def predictions_for_match(match)
    predictions.where('predictions.match_question_id in (?)',
                      match.match_question_ids)
               .select('predictions.*')
               .order('predictions.match_question_id')
  end

  def predictions_for_match_question(match_question)
    predictions.where('predictions.match_question_id in (?)',
                      match_question)
               .select('predictions.*')
               .order('predictions.match_question_id').first
  end

  def total_points_for_match(match)
    predictions_for_match(match).sum(:points)
  end

  def total_percentage_for_match(match)
    points = BigDecimal(total_points_for_match(match))
    total_points = BigDecimal(match.total_points)
    total_points == 0 ? 0 : (points / total_points * 100).round(2)
  end

  def match_question_ids(tournament)
    predictions_for_tournament(tournament).pluck('predictions.match_question_id')
  end

  def point_booster_availed
    user_challenges.point_booster_enabled.size
  end

  def point_booster_left
    ::User::POINT_BOOSTER - point_booster_availed
  end

  def point_booster_available?
    point_booster_availed < ::User::POINT_BOOSTER
  end

  def user_challenges_for_match(match)
    user_challenges.by_challenge(match.challenge_id)
  end

  def point_booster_enabled_for(match)
    pb_enabled = point_booster_selected_for(match)
    pb_enabled ? 'YES' : 'NO'
  end

  def point_booster_selected_for(match)
    user_challenge = user_challenges_for_match(match).first
    user_challenge.try(:point_booster)
  end
end
