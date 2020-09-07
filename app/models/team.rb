# team
class Team < ApplicationRecord
  # Associations
  # has_many :team1_matches, class_name: 'Match', foreign_key: 'team1_id'
  # has_many :team2_matches, class_name: 'Match', foreign_key: 'team2_id'
  has_many :players, dependent: :destroy
  # Scopes
  scope :by_name, ->(name) { where(name: name) }
  scope :by_short_name, ->(short_name) { where(short_name: short_name) }

  def matches
    Match.by_team(id)
  end

  def rank_details
    "Rank: #{rank}"
  end
end
