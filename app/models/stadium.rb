# Stadium
class Stadium < ApplicationRecord
  has_many :matches
  scope :by_name, ->(name) { where(name: name) }
  scope :like_name, ->(name) { where('name like ?', "%#{name}%") }
end
