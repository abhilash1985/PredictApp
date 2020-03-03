# TournamentType
class TournamentType < ApplicationRecord
  # Associations
  has_many :tournaments
  # Validations
  validates :name, :game, presence: true
  # Scopes
  scope :cwc2019, -> { where(name: 'cwc2019') }
  scope :ipl2020, -> { where(name: 'ipl2020') }
end
