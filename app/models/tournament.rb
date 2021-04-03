# frozen_string_literal: true

# Tournament
class Tournament < ApplicationRecord
  include Leaderboard
  include FanClubLeaderboard
  # Associations
  has_many :challenges, dependent: :destroy
  has_many :matches, dependent: :destroy
  belongs_to :tournament_type
  # Scopes
  scope :world_cup, -> { where(name: 'ICC Cricket World Cup 2015') }
  scope :fifa_world_cup, -> { where(name: I18n.t(:fifa_2018)) }
  scope :cricket_2019, -> { where(name: I18n.t(:cricket_2019)) }
  scope :russia, -> { where(location: 'Russia') }
  # scope :ipl2015, -> { where(name: 'IPL 2015') }
  scope :aus_nzl, -> { where(location: 'Australia & New Zealand') }
  scope :ipl2019, -> { where(name: 'VIVO IPL 2019') }
  scope :ipl2020, -> { where(name: I18n.t(:ipl_2020)) }
  scope :ipl2021, -> { where(name: I18n.t(:ipl_2021)) }
  scope :active, -> { where('end_date >= ?', Date.today) }

  def to_params
    name.to_s
  end

  def image_name
    case name
    when I18n.t(:cricket_2019)
      'cricket_2019.jpg'
    when I18n.t(:ipl_2020), I18n.t(:ipl_2021)
      'ipl.jpg'
    end
  end

  def cwc2015?
    name == self.class.world_cup.first.name
  end

  def fifa2019?
    name == self.class.fifa_world_cup.first.name
  end

  def ko_challenges(from = nil)
    from.blank? ? challenges.completed : challenges.knockout
  end

  def total_points(from)
    ko_challenges(from).reduce(0) { |a, v| a + v.total_points }
  end

  def participated_total_points_for(user, from)
    ko_challenges(from).ids_in(user.challenge_ids).reduce(0) { |a, v| a + v.total_points }
  end

  def total_points_for_match(user, from)
    ko_challenges(from).reduce(0) do |a, v|
      a + v.matches.id_in(match_ids(user)).reduce(0) { |a, v| a + v.total_points }
    end
  end

  def match_ids(user)
    match_question_ids = user.match_question_ids(self)
    MatchQuestion.where(id: match_question_ids).pluck(:match_id).uniq
  end

  def no_of_matches(user, from)
    ko_challenges(from).reduce(0) do |a, v|
      a + v.matches.id_in(match_ids(user)).count
    end
  end

  def no_of_zero_points(user)
    matches = Match.where(id: match_ids(user))
    matches.select { |m| user.total_points_for_match(m) == 0 }.size
  end

  def total_points_for_user(user, from)
    predictions = user.predictions_for_tournament(self, from)
    return 0 if predictions.blank?

    predictions.sum(:points)
  end

  def total_paid_points_for_user(user, from)
    paid_predictions = user.paid_predictions_for_tournament(self, from).uniq
    return 0 if paid_predictions.blank?

    paid_predictions.sum(:points)
  end

  def total_percentage_for_user(user, from)
    points = BigDecimal(total_points_for_user(user, from))
    total_points = BigDecimal(total_points_for_match(user, from))
    total_points == 0 ? 0 : (points / total_points * 100).round(2)
  end

  def users(from = nil)
    # User.all
    ko_challenges(from).flat_map(&:users).uniq
  end

  def leaderboard(from = nil)
    points =
      users(from).each_with_object({}) do |user, hash|
        user_points = total_points_for_user(user, from)
        user_paid_points = total_paid_points_for_user(user, from)
        user_percentage = total_percentage_for_user(user, from)
        no_of_matches = no_of_matches(user, from)
        no_of_zero = 0
        hash[user.id] = { name: user.show_name, points: user_points,
                          paid_points: user_paid_points,
                          no_of_matches: no_of_matches,
                          no_of_zero: no_of_zero,
                          percentage: user_percentage }
      end
    points.sort_by { |_k, v| v[:points] }.reverse.to_h
  end

  def ko_challenge_ids
    challenges.knockout.pluck(:id)
  end
end
