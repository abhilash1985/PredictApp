class UserChallenge < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :challenge
  has_many :predictions
  # Scopes
  scope :by_challenge, ->(challenge_id) { where(challenge_id: challenge_id) }
  scope :by_user, ->(user_id) { where(user_id: user_id) }

  def exact_answer
    match_question = MatchQuestion.find_by_id(match_question_id)
    return user_answer unless match_question && match_question.options[:v].blank?
    player = Player.find_by_id(user_answer)
    player.try(:first_name)
  end

  def style_class
    points == 0 ? 'btn-danger' : 'btn-success'
  end
end
