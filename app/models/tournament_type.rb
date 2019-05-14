# TournamentType
class TournamentType < ApplicationRecord
  # Associations
  has_many :tournaments
  # Validations
  validates :name, :game, presence: true
end
