class Tournament < ActiveRecord::Base
  # Associations
  has_many :challenges
  # Scopes
  scope :world_cup, -> { where(name: 'ICC Cricket World Cup 2015') }
  scope :aus_nzl, -> { where(location: 'Australia & New Zealand') }
  scope :active, -> { where('end_date > ?', Date.today) }

  def to_params
  	"#{name}"
  end

  def total_points
    challenges.reduce(0) { |a, v| a + v.total_points }
  end

  def participated_total_points_for(user)
    challenges.ids_in(user.challenge_ids).reduce(0) { |a, v| a + v.total_points }
  end

  def total_points_for_user(user)
    predictions = user.predictions_for_tournament(self)
    return 0 if predictions.blank?
    predictions.sum(:points)
  end

  def total_percentage_for_user(user)
    points = BigDecimal.new total_points_for_user(user)
    total_points = BigDecimal.new participated_total_points_for(user)
    total_points == 0 ? 0 : (points/total_points * 100).round(2)
  end

  def users
    challenges.flat_map { |c| c.users }.uniq
  end

  def leaderboard
    users.each_with_object({}) do |user, hash|
      user_points = total_points_for_user(user)
      user_percentage = total_percentage_for_user(user)
      hash[user.id] = { name: user.show_name, points: user_points,
                        percentage: user_percentage }
    end.sort_by { |k, v| v[:points] }.reverse.to_h
  end
end
