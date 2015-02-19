module TournamentsHelper

	def load_icon
		['icon1.jpg', 'icon2.jpg', 'icon3.jpg', 'icon4.jpg', 'icon5.jpg', 'icon6.jpg'].sample
	end

	def option_collection(match)
  	team1_players = match.team_players('team1')
    team2_players = match.team_players('team2')
	  [[match.team1_name, team1_players]] + [[match.team2_name, team2_players]]
	end
end
