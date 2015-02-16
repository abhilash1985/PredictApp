module TournamentsHelper

	def load_icon
		['icon1.jpg', 'icon2.jpg', 'icon3.jpg', 'icon4.jpg', 'icon5.jpg', 'icon6.jpg'].sample
	end

	def option_collection(match)
		team1_ary = match.team1.players.collect{ |u| [u.first_name, u.id] }
		team2_ary = match.team2.players.collect{ |u| [u.first_name, u.id] }
		team1_ary + team2_ary
	end
end
