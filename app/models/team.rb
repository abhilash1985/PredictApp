class Team < ActiveRecord::Base
  has_many :matches
  scope :by_name, ->(name) { where(name: name) }
  scope :by_short_name, ->(short_name) { where(short_name: short_name) }
end
