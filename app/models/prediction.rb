class Prediction < ActiveRecord::Base
  belongs_to :user_challenges
  belongs_to :match_questions

  scope :by_match_question, ->(match_question_id) { where(match_question_id: match_question_id) }

  def exact_answer
    return user_answer if user_answer.to_i == 0
    player = Player.find_by_id(user_answer)
    player.try(:full_name)
  end
end
