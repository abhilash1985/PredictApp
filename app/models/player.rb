class Player < ActiveRecord::Base
  # Associations
  belongs_to :team
  # Scopes
  scope :by_first_name, ->(first_name) { where(first_name: first_name) }
  scope :by_last_name, ->(last_name) { where(last_name: last_name) }

  def full_name
    "#{first_name} (#{player_style.upcase})".strip
  end
end
