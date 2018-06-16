# TournamentsHelper
module TournamentsHelper
  def load_icon
    # ['icon1.jpg', 'icon2.jpg', 'icon3.jpg', 'icon4.jpg', 'icon5.jpg', 'icon6.jpg',
    #  'icon7.jpg', 'icon8.jpg', 'icon9.jpg', 'icon10.jpg', 'icon11.jpg'].sample
    ['icon1.jpg', 'icon2.jpg', 'icon7.jpg', 'icon8.jpg', 'icon9.jpg'].sample
  end

  def option_collection(match)
    team1_players = match.team_players('team1')
    team2_players = match.team_players('team2')
    [[match.team1_name, team1_players]] + [[match.team2_name, team2_players]]
  end

  def options_hash(page_from, match_question, prediction)
    all_options = {}
    all_options[:page_from] = page_from
    all_options[:match_question] = match_question
    all_options[:prediction] = prediction
    all_options
  end

  def leaderboard(from = nil)
    from.blank? ? 'Leaderboard' : 'Knockout Board'
  end
end
