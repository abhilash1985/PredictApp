class UserChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  has_many :predictions

  scope :by_challenge, ->(challenge_id) { where(challenge_id: challenge_id) }
end
