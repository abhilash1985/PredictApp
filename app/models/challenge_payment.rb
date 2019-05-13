# ChallengePayment
class ChallengePayment < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
end
