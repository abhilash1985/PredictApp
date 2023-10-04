# frozen_string_literal: true

# TournamentType
class TournamentType < ApplicationRecord
  # Associations
  has_many :tournaments, dependent: :destroy
  # Validations
  validates :name, :game, presence: true
  # Scopes
  scope :cwc2019, -> { where(name: 'cwc2019') }
  scope :ipl2020, -> { where(name: 'ipl2020') }
  scope :ipl2021, -> { where(name: 'ipl2021') }
  scope :ipl2022, -> { where(name: 'ipl2022') }
  scope :fifa2022, -> { where(name: 'fifa2022') }
  scope :cwc2023, -> { where(name: 'cwc2023') }
end
