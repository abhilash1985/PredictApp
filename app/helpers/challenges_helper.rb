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

  def position_hash
    { 1 => 'alert-warning', 2 => 'alert-info', 3 => 'alert-danger' }
  end

  def show_winners_info(position)
    position_hash[position]
  end

  def show_amount(amount)
    return '-' if amount == 0
    amount
  end

  def show_position(klass)
    value = position_hash.invert[klass]
    value.ordinalize
  end
end
