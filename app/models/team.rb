class Team < ActiveRecord::Base
  # Associations
  has_many :matches
  has_many :players
  # Scopes
  scope :by_name, ->(name) { where(name: name) }
  scope :by_short_name, ->(short_name) { where(short_name: short_name) }
end
