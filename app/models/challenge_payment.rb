# ChallengePayment
class ChallengePayment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :challenge
end
