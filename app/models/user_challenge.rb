class UserChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  has_many :predictions
end
