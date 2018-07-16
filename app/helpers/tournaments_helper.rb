# TournamentsHelper
module TournamentsHelper
  def load_icon
    # ['icon1.jpg', 'icon2.jpg', 'icon3.jpg', 'icon4.jpg', 'icon5.jpg', 'icon6.jpg',
    #  'icon7.jpg', 'icon8.jpg', 'icon9.jpg', 'icon10.jpg', 'icon11.jpg'].sample
    ['icon10.jpg', 'icon11.jpg', 'icon12.jpg', 'icon13.jpg'].sample
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

  def fixed_lb(user)
    return [0, 0, 0, 0, 0] unless @current_tournament.try(:name).to_s.include?('FIFA')
    case user
    when 'Matz V'
      [342, 342, 49, 2, 4, 779]
    when 'retheesh r'
      [337, 337, 49, 0, 4, 779]
    when 'Abhilash V'
      [328, 328, 49, 0, 4, 779]
    when 'Robin Wilson'
      [306, 306, 47, 1, 9, 743]
    when 'Rajesh Omanakuttan'
      [290, 290, 49, 0, 10, 779]
    when 'Shaji Easow'
      [277, 277, 45, 2, 5, 709]
    when 'Vineeth m'
      [272, 272, 46, 1, 6, 734]
    when 'Linsy Lawrens'
      [272, 272, 43, 0, 4, 689]
    when 'Aravind S'
      [296, 271, 49, 0, 6, 779]
    when 'Sanandh C K'
      [262, 262, 43, 0, 7, 689]
    when 'Charles Skariah'
      [259, 259, 45, 0, 4, 719]
    when 'Honest Chiyan'
      [254, 254, 43, 1, 4, 689]
    when 'Samith Valsalan'
      [233, 233, 43, 1, 9, 689]
    when 'Antony Rony'
      [232, 232, 40, 0, 6, 644]
    when 'Vivak Vijayakumar'
      [237, 219, 44, 0, 8, 694]
    when 'Rajasree M'
      [202, 202, 43, 0, 9, 689]
    when 'Arun Kurian'
      [208, 184, 42, 0, 11, 661]
    when 'Kartheek Pichani'
      [227, 181, 49, 0, 12, 779]
    when 'Anija Thomas'
      [141, 131, 29, 0, 7, 467]
    when 'Suman M'
      [128, 128, 25, 0, 7, 408]
    when 'Rinto Antony'
      [250, 121, 43, 0, 5, 689]
    when 'kurian mathew'
      [243, 118, 46, 1, 9, 734]
    when 'SreeKanth R'
      [150, 88, 26, 0, 6, 434]
    when 'Sani Ks'
      [57, 57, 11, 0, 2, 189]
    when 'Aswathy S'
      [71, 34, 12, 0, 1, 206]
    when 'Vishnubhararth Balakrishnan'
      [53, 34, 9, 0, 1, 135]
    when 'Priya K'
      [273, 0, 45, 1, 4, 707]
    when 'Ajay George'
      [289, 0, 49, 0, 6, 779]
    when 'Aswathy Abhilash'
      [121, 0, 30, 0, 8, 488]
    when 'Reshma M'
      [29, 23, 7, 0, 1, 121]
    when 'Arun kumar'
      [39, 0, 6, 0, 0, 96]
    when 'Ranjith Varghese'
      [0, 0, 2, 0, 2, 30]
    else
      [0, 0, 0, 0, 0]
    end
  end
end
