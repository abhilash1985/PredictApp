# frozen_string_literal: true

# Player
class Player < ApplicationRecord
  # Associations
  belongs_to :team
  # Scopes
  scope :by_first_name, ->(first_name) { where(first_name: first_name) }
  scope :by_last_name, ->(last_name) { where(last_name: last_name) }
  scope :order_by_captain, -> { order('last_name asc, player_style, first_name') }
  scope :not_withdrawn, -> { where.not('player_style like ?', '%Withdrawn%') }

  def full_name
    "#{first_name} (#{player_style.upcase})".strip
  end
end
