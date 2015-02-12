class Challenge < ActiveRecord::Base
  belongs_to :tournament
  has_many :matches
  has_many :user_challenges
  has_many :users, through: :user_challenges
end
