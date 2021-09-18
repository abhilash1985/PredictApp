# frozen_string_literal: true

# Player
class Player < ApplicationRecord
  # Associations
  belongs_to :team
  # Scopes
  scope :by_first_name, ->(first_name) { where(first_name: first_name) }
  scope :by_last_name, ->(last_name) { where(last_name: last_name) }
  scope :order_by_captain, -> { order('last_name desc, first_name') }
  scope :not_withdrawn, -> { where("player_style not like '%withdrawn%'") }

  def full_name
    "#{first_name} (#{player_style.upcase})".strip
  end
end
