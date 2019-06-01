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

  def show_winners_info(array, name)
    if array.include?(name)
      'alert-info'
    else
      'alert-warning'
    end
  end

  def show_amount(amount)
    return '-' if amount == 0
    amount
  end
end
