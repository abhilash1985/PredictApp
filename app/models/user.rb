class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Associations
  has_many :user_challenges
  has_many :challenges, through: :user_challenges

  def show_name
    full_name.blank? ? show_email : full_name
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def show_email
    email.split('@')[0]
  end

  def has_predictions_for_match(match)
    !predictions_for_match(match).blank?
  end

  def prediction_for_match_question(challenge, match_question)
    user_challenge = user_challenges.by_challenge(challenge.id).first
    return if user_challenge.blank?
    user_challenge.predictions.by_match_question(match_question.id).first
  end

  def checked_value(option, prediction)
    return if prediction.blank?
    option == prediction.user_answer
  end

  def selected_value(prediction)
    return if prediction.blank?
    prediction.user_answer
  end

  def submit_value(match)
    prediction = predictions_for_match(match)
    prediction.blank? ? 'Submit' : 'Edit' 
  end

  def matches
    # challenges.joins(:matches)
    challenges.flat_map(&:matches)
  end
  
  def matches_for_challenge(challenge)
    # matches.where('matches.challenge_id = ?', challenge.id)
    matches.select { |match| match.challenge_id == challenge.id }
  end

  def predictions
    user_challenges.joins(:predictions)
  end

  def predictions_for(challenge)
    @prediction ||= predictions.where('user_challenges.challenge_id = ?', challenge.id)
  end

  def total_points_for_challenge(challenge)
    predictions_for(challenge).reduce(0) { |a, v| a + v.points }
  end

  def total_percentage_for_challenge(challenge)
    points = BigDecimal.new total_points_for_challenge(challenge)
    total_points = BigDecimal.new challenge.total_points
    total_points == 0 ? 0 : (points/total_points * 100).round(2)
  end

  def predictions_for_match(match)
    predictions.where('predictions.match_question_id in (?)', match.match_question_ids) 
  end

  def points_for_match(match)
    predictions_for_match(match).sum(:points)
  end
end
