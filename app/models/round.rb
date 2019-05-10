# Round
class Round < ApplicationRecord
  scope :by_name, ->(name) { where(name: name) }
end
