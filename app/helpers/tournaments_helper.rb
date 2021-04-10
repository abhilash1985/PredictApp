# TournamentsHelper
module TournamentsHelper
  def load_icon(team1, team2)
    path = "icons/#{@current_tournament_type}/#{@current_tournament_name}"
    team_icon_img = teams_icon(path, team1, team2)
    if asset_present?(team_icon_img)
      team_icon_img
    else
      "#{path}/#{deafult_icon}"
    end
  end

  def teams_icon(path, team1, team2)
    team_image = "#{team1}_#{team2}"
    "#{path}/#{team_image}.jpg"
  end

  def deafult_icon
    ['icon.jpg', 'icon1.jpg', 'icon2.jpg', 'icon3.jpg', 'icon4.jpg', 'icon5.jpg', 'icon6.jpg'].sample
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

  def show_icon(team1, team2)
    image_tag(load_icon(team1, team2).to_s, size: '400x300')
  end

  def show_team_logo(team_short_name, size = '50x50')
    image_tag("flags/#{@current_tournament_type}/#{team_short_name}.png", size: size)
  rescue StandardError
    image_tag("flags/#{@current_tournament_type}/icc.jpeg", size: size)
  end

  def show_users_name_in_club(team_id)
    User.by_team_id(team_id).order_by_name.select(:id, :first_name, :last_name)
        .map(&:full_name).join(', ')
  end

  def show_player_name_in_prediction_graph(data)
    return {} if data.blank?

    data.each_with_object({}) do |(key, value), hash|
      new_key = Player.find_by_id(key).first_name
      hash[new_key] = value
    end
  end
end
