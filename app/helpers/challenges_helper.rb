# helpers for chalenges
module ChallengesHelper
  def challenge_path(challenge, name)
    case name
    when 'current'
      predictions_table_challenge_path(challenge)
    else
      points_table_challenge_path(challenge)
    end
  end
end
