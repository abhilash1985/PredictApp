class Prediction < ActiveRecord::Base
  belongs_to :user_challenges
  belongs_to :match_questions
end
